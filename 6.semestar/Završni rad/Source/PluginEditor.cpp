/*
  ==============================================================================

    This file contains the basic framework code for a JUCE plugin editor.

  ==============================================================================
*/

#include "PluginProcessor.h"
#include "PluginEditor.h"

SpectrumAnalyzer::SpectrumAnalyzer(MultibandAudioCompressorAudioProcessor& p) :
    audioProcessor(p),
    leftPathProducer(audioProcessor.leftChannelFifo),
    rightPathProducer(audioProcessor.rightChannelFifo)
{
    const auto& params = audioProcessor.getParameters();
    for (auto param : params)
    {
        param->addListener(this);
    }

    using namespace Params;
    const auto& paramNames = GetParams();

    auto floatHelper = [&apvts = audioProcessor.apvts, &paramNames](auto& param, const auto& paramName)
        {
            param = dynamic_cast<juce::AudioParameterFloat*>(apvts.getParameter(paramNames.at(paramName)));
            jassert(param != nullptr);
        };

    floatHelper(lowMidXoverParam, Names::Low_Mid_Crossover_Freq);
    floatHelper(midHighXoverParam, Names::Mid_High_Crossover_Freq);

    floatHelper(lowThreasholdParam, Names::Threashold_Low_Band);
    floatHelper(midThreasholdParam, Names::Threashold_Mid_Band);
    floatHelper(highThreasholdParam, Names::Threashold_High_Band);

    startTimerHz(60);
}

SpectrumAnalyzer::~SpectrumAnalyzer()
{
    const auto& params = audioProcessor.getParameters();
    for (auto param : params)
    {
        param->removeListener(this);
    }
}

void SpectrumAnalyzer::drawFFTAnalysis(juce::Graphics& g, juce::Rectangle<int> bounds)
{
    using namespace juce;

    auto responseArea = getAnalysisArea(bounds);

    Graphics::ScopedSaveState sss(g);
    g.reduceClipRegion(responseArea);

    auto leftChannelFFTPath = leftPathProducer.getPath();
    leftChannelFFTPath.applyTransform(AffineTransform().translation(responseArea.getX(), 0));

    g.setColour(Colour(97u, 18u, 167u));
    g.strokePath(leftChannelFFTPath, PathStrokeType(1.f));

    auto rightChannelFFTPath = rightPathProducer.getPath();
    rightChannelFFTPath.applyTransform(AffineTransform().translation(responseArea.getX(), 0));

    g.setColour(Colour(215u, 201u, 134u));
    g.strokePath(rightChannelFFTPath, PathStrokeType(1.f));
}

void SpectrumAnalyzer::paint(juce::Graphics& g)
{
    using namespace juce;
    g.fillAll(Colours::black);

    auto bounds = getLocalBounds();
    g.setColour(Colours::blueviolet);
    g.fillAll();

    auto localBounds = bounds;

    bounds.reduce(3, 3);
    g.setColour(Colours::black);
    g.fillRoundedRectangle(bounds.toFloat(), 3);

    g.drawRect(localBounds);

    drawBackgroundGrid(g, bounds);

    if (shouldShowFFTAnalysis)
    {
        drawFFTAnalysis(g, bounds);
    }

    drawCrossovers(g, bounds);

    drawTextLabels(g, bounds);
}

void SpectrumAnalyzer::drawCrossovers(juce::Graphics& g, juce::Rectangle<int> bounds)
{
    using namespace juce;
    bounds = getAnalysisArea(bounds);

    const auto top = bounds.getY();
    const auto bottom = bounds.getBottom();
    const auto right = bounds.getRight();
    const auto left = bounds.getX();

    auto mapX = [left = bounds.getX(), width = bounds.getWidth()](float frequency)
        {
            auto normX = juce::mapFromLog10(frequency, MIN_FREQUENCY, MAX_FREQUENCY);
            return left + width * normX;
        };

    auto lowMidX = mapX(lowMidXoverParam->get());
    g.setColour(Colours::orange);
    g.drawVerticalLine(lowMidX, top, bottom);

    auto midHighX = mapX(midHighXoverParam->get());
    g.drawVerticalLine(midHighX, top, bottom);

    auto mapY = [bottom, top](float db)
        {
            return jmap(db, NEGATIVE_INFINITY, MAX_DECIBELS, (float)bottom, (float)top);
        };

    auto zeroDb = mapY(0.f);
    g.setColour(Colours::hotpink.withAlpha(0.3f));
    g.fillRect(Rectangle<float>::leftTopRightBottom(left, zeroDb, lowMidX, mapY(lowBandGR)));
    g.fillRect(Rectangle<float>::leftTopRightBottom(lowMidX, zeroDb, midHighX, mapY(midBandGR)));
    g.fillRect(Rectangle<float>::leftTopRightBottom(midHighX, zeroDb, right, mapY(highBandGR)));

    g.setColour(Colours::blueviolet);
    g.drawHorizontalLine(mapY(lowThreasholdParam->get()), left, lowMidX);
    g.drawHorizontalLine(mapY(midThreasholdParam->get()), lowMidX, midHighX);
    g.drawHorizontalLine(mapY(highThreasholdParam->get()), midHighX, right);
}

void SpectrumAnalyzer::update(const std::vector<float>& values)
{
    jassert(values.size() == 6);

    enum
    {
        LowBandIn,
        LowBandOut,
        MidBandIn,
        MidBandOut,
        HighBandIn,
        HighBandOut
    };

    lowBandGR = values[LowBandOut] - values[LowBandIn];
    midBandGR = values[MidBandOut] - values[MidBandIn];
    highBandGR = values[HighBandOut] - values[HighBandIn];

    repaint();
}

std::vector<float> SpectrumAnalyzer::getFrequencies()
{
    return std::vector<float>
    {
        20, 50, 100,
            200, 500, 1000,
            2000, 5000, 10000,
            20000
    };
}

std::vector<float> SpectrumAnalyzer::getGains()
{
    std::vector<float> values;
    auto increment = MAX_DECIBELS;
    for (auto db = NEGATIVE_INFINITY; db <= MAX_DECIBELS; db += MAX_DECIBELS)
    {
        values.push_back(db);
    }

    return values;
}

std::vector<float> SpectrumAnalyzer::getXs(const std::vector<float>& freqs, float left, float width)
{
    std::vector<float> xs;
    for (auto f : freqs)
    {
        auto normX = juce::mapFromLog10(f, MIN_FREQUENCY, MAX_FREQUENCY);
        xs.push_back(left + width * normX);
    }

    return xs;
}

void SpectrumAnalyzer::drawBackgroundGrid(juce::Graphics& g, juce::Rectangle<int> bounds)
{
    using namespace juce;
    auto freqs = getFrequencies();

    auto renderArea = getAnalysisArea(bounds);
    auto left = renderArea.getX();
    auto right = renderArea.getRight();
    auto top = renderArea.getY();
    auto bottom = renderArea.getBottom();
    auto width = renderArea.getWidth();

    auto xs = getXs(freqs, left, width);

    g.setColour(Colours::dimgrey);
    for (auto x : xs)
    {
        g.drawVerticalLine(x, top, bottom);
    }

    auto gain = getGains();

    for (auto gDb : gain)
    {
        auto y = jmap(gDb, NEGATIVE_INFINITY, MAX_DECIBELS, (float)bottom, (float)top);

        g.setColour(gDb == 0.f ? Colour(0u, 172u, 1u) : Colours::darkgrey);
        g.drawHorizontalLine(y, left, right);
    }
}

void SpectrumAnalyzer::drawTextLabels(juce::Graphics& g, juce::Rectangle<int> bounds)
{
    using namespace juce;
    g.setColour(Colours::lightgrey);
    const int fontHeight = 10;
    g.setFont(fontHeight);

    auto renderArea = getAnalysisArea(bounds);
    auto left = renderArea.getX();

    auto top = renderArea.getY();
    auto bottom = renderArea.getBottom();
    auto width = renderArea.getWidth();

    auto freqs = getFrequencies();
    auto xs = getXs(freqs, left, width);

    for (int i = 0; i < freqs.size(); ++i)
    {
        auto f = freqs[i];
        auto x = xs[i];

        bool addK = false;
        String str;
        if (f > 999.f)
        {
            addK = true;
            f /= 1000.f;
        }

        str << f;
        if (addK)
            str << "k";
        str << "Hz";

        auto textWidth = g.getCurrentFont().getStringWidth(str);

        Rectangle<int> r;

        r.setSize(textWidth, fontHeight);
        r.setCentre(x, 0);
        r.setY(bounds.getY());

        g.drawFittedText(str, r, juce::Justification::centred, 1);
    }

    auto gain = getGains();

    for (auto gDb : gain)
    {
        auto y = jmap(gDb, NEGATIVE_INFINITY, MAX_DECIBELS, (float)bottom, (float)top);

        String str;
        if (gDb > 0)
            str << "+";
        str << gDb;

        auto textWidth = g.getCurrentFont().getStringWidth(str);

        Rectangle<int> r;
        r.setSize(textWidth, fontHeight);
        r.setX(bounds.getRight() - textWidth);
        r.setCentre(r.getCentreX(), y);

        g.setColour(gDb == 0.f ? Colour(0u, 172u, 1u) : Colours::lightgrey);

        g.drawFittedText(str, r, juce::Justification::centredLeft, 1);

        r.setX(bounds.getX() + 1);
        g.drawFittedText(str, r, juce::Justification::centredLeft, 1);
    }
}

void SpectrumAnalyzer::resized()
{
    using namespace juce;
    auto bounds = getLocalBounds();
    auto fftBounds = getAnalysisArea(bounds).toFloat();
    auto negInf = jmap(bounds.toFloat().getBottom(), fftBounds.toFloat().getBottom(), fftBounds.getY(), NEGATIVE_INFINITY, MAX_DECIBELS);
    leftPathProducer.updateNegativeInfinity(negInf);
    rightPathProducer.updateNegativeInfinity(negInf);
}

void SpectrumAnalyzer::parameterValueChanged(int parameterIndex, float newValue)
{
    parametersChanged.set(true);
}

void PathProducer::process(juce::Rectangle<float> fftBounds, double sampleRate)
{
    juce::AudioBuffer<float> tempIncomingBuffer;
    while (leftChannelFifo->getNumCompleteBuffersAvailable() > 0)
    {
        if (leftChannelFifo->getAudioBuffer(tempIncomingBuffer))
        {
            auto size = tempIncomingBuffer.getNumSamples();

            jassert(size <= monoBuffer.getNumSamples());
            size = juce::jmin(size, monoBuffer.getNumSamples());

            auto writePointer = monoBuffer.getWritePointer(0, 0);
            auto readPointer = monoBuffer.getReadPointer(0, size);
            std::copy(readPointer, readPointer + (monoBuffer.getNumSamples() - size), writePointer);

            juce::FloatVectorOperations::copy(monoBuffer.getWritePointer(0, monoBuffer.getNumSamples() - size),
                tempIncomingBuffer.getReadPointer(0, 0),
                size);

            leftChannelFFTDataGenerator.produceFFTDataForRendering(monoBuffer, negativeInfinity);
        }
    }

    const auto fftSize = leftChannelFFTDataGenerator.getFFTSize();
    const auto binWidth = sampleRate / double(fftSize);

    while (leftChannelFFTDataGenerator.getNumAvailableFFTDataBlocks() > 0)
    {
        std::vector<float> fftData;
        if (leftChannelFFTDataGenerator.getFFTData(fftData))
        {
            pathProducer.generatePath(fftData, fftBounds, fftSize, binWidth, negativeInfinity);
        }
    }

    while (pathProducer.getNumPathsAvailable() > 0)
    {
        pathProducer.getPath(leftChannelFFTPath);
    }
}

void SpectrumAnalyzer::timerCallback()
{
    if (shouldShowFFTAnalysis)
    {
        auto bounds = getLocalBounds();
        auto fftBounds = getAnalysisArea(bounds).toFloat();
        fftBounds.setBottom(bounds.getBottom());
        auto sampleRate = audioProcessor.getSampleRate();

        leftPathProducer.process(fftBounds, sampleRate);
        rightPathProducer.process(fftBounds, sampleRate);
    }

    if (parametersChanged.compareAndSetBool(false, true))
    {
        
    }

    repaint();
}

juce::Rectangle<int> SpectrumAnalyzer::getRenderArea(juce::Rectangle<int> bounds)
{
    bounds.removeFromTop(12);
    bounds.removeFromBottom(2);
    bounds.removeFromLeft(20);
    bounds.removeFromRight(20);

    return bounds;
}


juce::Rectangle<int> SpectrumAnalyzer::getAnalysisArea(juce::Rectangle<int> bounds)
{
    bounds = getRenderArea(bounds);
    bounds.removeFromTop(4);
    bounds.removeFromBottom(4);
    return bounds;
}

//==============================================================================

template<typename T>
bool truncateKiloValue(T& value)
{
    if (value > static_cast<T>(999))
    {
        value /= static_cast<T>(1000);
        return true;
    }

    return false;
}

juce::String getValString(const juce::RangedAudioParameter& param, bool getLow, juce::String suffix)
{
    juce::String str;

    auto val = getLow ? param.getNormalisableRange().start : param.getNormalisableRange().end;

    bool addK = truncateKiloValue(val);
    str << val;
    if (addK) str << "k";

    str << suffix;

    return str;
}

void LookAndFeel::drawRotarySlider(juce::Graphics& g,
    int x,
    int y,
    int width,
    int height,
    float sliderPosProportional,
    float rotaryStartAngle,
    float rotaryEndAngle,
    juce::Slider& slider)
{
    using namespace juce;

    auto bounds = Rectangle<float>(x, y, width, height);

    auto enabled = slider.isEnabled();

    g.setColour(enabled ? Colour(97u, 18u, 167u) : Colours::darkgrey);
    g.fillEllipse(bounds);

    g.setColour(enabled ? Colour(255u, 154u, 1u) : Colours::grey);
    g.drawEllipse(bounds, 1.f);

    if (auto* rswl = dynamic_cast<RotarySliderWithLabels*>(&slider))
    {
        auto center = bounds.getCentre();
        Path p;

        Rectangle<float> r;
        r.setLeft(center.getX() - 2);
        r.setRight(center.getX() + 2);
        r.setTop(bounds.getY());
        r.setBottom(center.getY() - rswl->getTextHeight() * 1.5);

        p.addRoundedRectangle(r, 2.f);

        jassert(rotaryStartAngle < rotaryEndAngle);

        auto sliderAngRad = jmap(sliderPosProportional, 0.f, 1.f, rotaryStartAngle, rotaryEndAngle);

        p.applyTransform(AffineTransform().rotated(sliderAngRad, center.getX(), center.getY()));

        g.fillPath(p);

        g.setFont(rswl->getTextHeight());
        auto text = rswl->getDisplayString();
        auto strWidth = g.getCurrentFont().getStringWidth(text);

        r.setSize(strWidth + 4, rswl->getTextHeight() + 2);
        r.setCentre(bounds.getCentre());

        g.setColour(enabled ? Colours::black : Colours::darkgrey);
        g.fillRect(r);

        g.setColour(enabled ? Colours::white : Colours::lightgrey);
        g.drawFittedText(text, r.toNearestInt(), juce::Justification::centred, 1);
    }
}

void LookAndFeel::drawToggleButton(juce::Graphics& g,
    juce::ToggleButton& toggleButton,
    bool shouldDrawButtonAsHighlighted,
    bool shouldDrawButtonAsDown)
{
    using namespace juce;

    if (auto* pb = dynamic_cast<PowerButton*>(&toggleButton))
    {
        Path powerButton;

        auto bounds = toggleButton.getLocalBounds();

        auto size = jmin(bounds.getWidth(), bounds.getHeight()) - 6;
        auto r = bounds.withSizeKeepingCentre(size, size).toFloat();

        float ang = 30.f;

        size -= 6;

        powerButton.addCentredArc(r.getCentreX(),
            r.getCentreY(),
            size * 0.5,
            size * 0.5,
            0.f,
            degreesToRadians(ang),
            degreesToRadians(360.f - ang),
            true);

        powerButton.startNewSubPath(r.getCentreX(), r.getY());
        powerButton.lineTo(r.getCentre());

        PathStrokeType pst(2.f, PathStrokeType::JointStyle::curved);

        auto color = toggleButton.getToggleState() ? Colours::dimgrey : Colour(0u, 172u, 1u);

        g.setColour(color);
        g.strokePath(powerButton, pst);
        g.drawEllipse(r, 2);
    }
    else if (auto* analyzerButton = dynamic_cast<AnalyzerButton*>(&toggleButton))
    {
        auto color = !toggleButton.getToggleState() ? Colours::dimgrey : Colour(0u, 172u, 1u);

        g.setColour(color);

        auto bounds = toggleButton.getLocalBounds();
        g.drawRect(bounds);

        g.strokePath(analyzerButton->randomPath, PathStrokeType(1.f));
    }
    else
    {
        auto bounds = toggleButton.getLocalBounds().reduced(2);
        auto buttonIsOn = toggleButton.getToggleState();
        const int cornerSize = 4;

        g.setColour(buttonIsOn ? toggleButton.findColour(TextButton::ColourIds::buttonOnColourId) : toggleButton.findColour(TextButton::ColourIds::buttonColourId));
        g.fillRoundedRectangle(bounds.toFloat(), cornerSize);

        g.setColour(buttonIsOn ? juce::Colours::black : juce::Colours::white);
        g.drawRoundedRectangle(bounds.toFloat(), cornerSize, 1);
        g.drawFittedText(toggleButton.getName(), bounds, juce::Justification::centred, 1);
    }
}

//==============================================================================

void RotarySliderWithLabels::paint(juce::Graphics& g)
{
    using namespace juce;

    auto startAng = degreesToRadians(180.f + 45.f);
    auto endAng = degreesToRadians(180.f - 45.f) + MathConstants<float>::twoPi;

    auto range = getRange();

    auto sliderBounds = getSliderBounds();

    auto bounds = getLocalBounds();
    g.setColour(Colours::blueviolet);
    g.drawFittedText(getName(), bounds.removeFromTop(getTextHeight()+2), Justification::centredBottom, 1);

    getLookAndFeel().drawRotarySlider(g,
        sliderBounds.getX(),
        sliderBounds.getY(),
        sliderBounds.getWidth(),
        sliderBounds.getHeight(),
        jmap(getValue(), range.getStart(), range.getEnd(), 0.0, 1.0),
        startAng,
        endAng,
        *this);

    auto center = sliderBounds.toFloat().getCentre();
    auto radius = sliderBounds.getWidth() * 0.5f;

    g.setColour(Colour(0u, 172u, 1u));
    g.setFont(getTextHeight());

    auto numChoices = labels.size();
    for (int i = 0; i < numChoices; ++i)
    {
        auto pos = labels[i].pos;
        jassert(0.f <= pos);
        jassert(pos <= 1.f);

        auto ang = jmap(pos, 0.f, 1.f, startAng, endAng);

        auto c = center.getPointOnCircumference(radius + getTextHeight() * 0.5f + 1, ang);

        Rectangle<float> r;
        auto str = labels[i].label;
        r.setSize(g.getCurrentFont().getStringWidth(str), getTextHeight());
        r.setCentre(c);
        r.setY(r.getY() + getTextHeight());

        g.drawFittedText(str, r.toNearestInt(), juce::Justification::centred, 1);
    }

}

juce::Rectangle<int> RotarySliderWithLabels::getSliderBounds() const
{
    auto bounds = getLocalBounds();
    bounds.removeFromTop(getTextHeight() * 1.5);

    auto size = juce::jmin(bounds.getWidth(), bounds.getHeight());

    size -= getTextHeight() * 1.5;
    juce::Rectangle<int> r;
    r.setSize(size, size);
    r.setCentre(bounds.getCentreX(), 0);
    r.setY(bounds.getY());

    return r;

}

juce::String RotarySliderWithLabels::getDisplayString() const
{
    if (auto* choiceParam = dynamic_cast<juce::AudioParameterChoice*>(param))
        return choiceParam->getCurrentChoiceName();

    juce::String str;
    bool addK = false;

    if (auto* floatParam = dynamic_cast<juce::AudioParameterFloat*>(param))
    {
        float val = getValue();
        addK = truncateKiloValue(val);
        str = juce::String(val, (addK ? 2 : 0));
    }
    else
    {
        jassertfalse;
    }

    if (suffix.isNotEmpty())
    {
        str << " ";
        if (addK)
            str << "k";

        str << suffix;
    }

    return str;
}

void RotarySliderWithLabels::changeParam(juce::RangedAudioParameter* p)
{
    param = p;
    repaint();
}

//==============================================================================

juce::String RatioSlider::getDisplayString() const
{
    auto choiceParam = dynamic_cast<juce::AudioParameterChoice*>(param);
    jassert(choiceParam != nullptr);

    auto currentChoice = choiceParam->getCurrentChoiceName();
    if (currentChoice.contains(".0")) currentChoice = currentChoice.substring(0, currentChoice.indexOf("."));
    currentChoice << ":1";

    return currentChoice;
}

//==============================================================================

CompressorBandControls::CompressorBandControls(juce::AudioProcessorValueTreeState& apv) :
    apvts(apv),
    attackSlider(nullptr, "ms", "ATTACK"),
    releaseSlider(nullptr, "ms", "RELEASE"),
    threasholdSlider(nullptr, "dB", "THRESHOLD"),
    ratioSlider(nullptr, "")
{
    addAndMakeVisible(attackSlider);
    addAndMakeVisible(releaseSlider);
    addAndMakeVisible(threasholdSlider);
    addAndMakeVisible(ratioSlider);

    bypassButton.addListener(this);
    soloButton.addListener(this);
    muteButton.addListener(this);

    bypassButton.setName("B");
    bypassButton.setColour(juce::TextButton::ColourIds::buttonOnColourId, juce::Colours::blueviolet);
    bypassButton.setColour(juce::TextButton::ColourIds::buttonColourId, juce::Colours::black);
    soloButton.setName("S");
    soloButton.setColour(juce::TextButton::ColourIds::buttonOnColourId, juce::Colours::blueviolet);
    soloButton.setColour(juce::TextButton::ColourIds::buttonColourId, juce::Colours::black);
    muteButton.setName("M");
    muteButton.setColour(juce::TextButton::ColourIds::buttonOnColourId, juce::Colours::blueviolet);
    muteButton.setColour(juce::TextButton::ColourIds::buttonColourId, juce::Colours::black);

    addAndMakeVisible(bypassButton);
    addAndMakeVisible(soloButton);
    addAndMakeVisible(muteButton);

    lowBand.setName("Low");
    lowBand.setColour(juce::TextButton::ColourIds::buttonOnColourId, juce::Colours::blueviolet);
    lowBand.setColour(juce::TextButton::ColourIds::buttonColourId, juce::Colours::black);
    midBand.setName("Mid");
    midBand.setColour(juce::TextButton::ColourIds::buttonOnColourId, juce::Colours::blueviolet);
    midBand.setColour(juce::TextButton::ColourIds::buttonColourId, juce::Colours::black);
    highBand.setName("High");
    highBand.setColour(juce::TextButton::ColourIds::buttonOnColourId, juce::Colours::blueviolet);
    highBand.setColour(juce::TextButton::ColourIds::buttonColourId, juce::Colours::black);

    lowBand.setRadioGroupId(1);
    midBand.setRadioGroupId(1);
    highBand.setRadioGroupId(1);

    auto buttonSwitcher = [safePtr = this->safePtr]()
    {
        if (auto* c = safePtr.getComponent())
        {
            c->updateAttachments();
        }
    };

    lowBand.onClick = buttonSwitcher;
    midBand.onClick = buttonSwitcher;
    highBand.onClick = buttonSwitcher;

    lowBand.setToggleState(true, juce::NotificationType::dontSendNotification);
    updateAttachments();

    addAndMakeVisible(lowBand);
    addAndMakeVisible(midBand);
    addAndMakeVisible(highBand);
}

CompressorBandControls::~CompressorBandControls()
{
    bypassButton.removeListener(this);
    soloButton.removeListener(this);
    muteButton.removeListener(this);
}

void CompressorBandControls::resized()
{
    auto bounds = getLocalBounds().reduced(5);
    using namespace juce;

    auto createBandButtonControlBox = [](std::vector<Component*> comps)
    {
        FlexBox flexBox;
        flexBox.flexDirection = FlexBox::Direction::column;
        flexBox.flexWrap = FlexBox::Wrap::noWrap;

        auto spacer = FlexItem().withWidth(2);

        for (auto* comp : comps)
        {
            flexBox.items.add(spacer);
            flexBox.items.add(FlexItem(*comp).withFlex(1.f));
        }
        flexBox.items.add(spacer);

        return flexBox;
    };

    auto bandButtonControlBox = createBandButtonControlBox({ &bypassButton, &soloButton, &muteButton });
    auto bandSelectControlBox = createBandButtonControlBox({ &lowBand, &midBand, &highBand });

    FlexBox flexBox;
    flexBox.flexDirection = FlexBox::Direction::row;
    flexBox.flexWrap = FlexBox::Wrap::noWrap;

    auto spacer = FlexItem().withWidth(4);

    flexBox.items.add(FlexItem(bandSelectControlBox).withWidth(50));
    flexBox.items.add(spacer);
    flexBox.items.add(FlexItem(attackSlider).withFlex(1.f));
    flexBox.items.add(spacer);
    flexBox.items.add(FlexItem(releaseSlider).withFlex(1.f));
    flexBox.items.add(spacer);
    flexBox.items.add(FlexItem(threasholdSlider).withFlex(1.f));
    flexBox.items.add(spacer);
    flexBox.items.add(FlexItem(ratioSlider).withFlex(1.f));
    flexBox.items.add(spacer);
    flexBox.items.add(FlexItem(bandButtonControlBox).withWidth(30));

    flexBox.performLayout(bounds);
}

void CompressorBandControls::paint(juce::Graphics& g)
{
    using namespace juce;
    auto bounds = getLocalBounds();
    g.setColour(Colours::blueviolet);
    g.fillAll();

    auto localBounds = bounds;

    bounds.reduce(3, 3);
    g.setColour(Colours::black);
    g.fillRoundedRectangle(bounds.toFloat(), 3);

    g.drawRect(localBounds);
}

void CompressorBandControls::buttonClicked(juce::Button* button)
{
    updateSliderEnamlements();
    updateSoloMuteBypassToggleStates(*button);
}

void CompressorBandControls::updateSliderEnamlements()
{
    auto disabled = muteButton.getToggleState() || bypassButton.getToggleState();
    attackSlider.setEnabled(!disabled);
    releaseSlider.setEnabled(!disabled);
    threasholdSlider.setEnabled(!disabled);
    ratioSlider.setEnabled(!disabled);
}

void CompressorBandControls::updateSoloMuteBypassToggleStates(juce::Button& clickedButton)
{
    if (&clickedButton == &soloButton && soloButton.getToggleState())
    {
        bypassButton.setToggleState(false, juce::NotificationType::sendNotification);
        muteButton.setToggleState(false, juce::NotificationType::sendNotification);
    }
    if (&clickedButton == &muteButton && muteButton.getToggleState())
    {
        bypassButton.setToggleState(false, juce::NotificationType::sendNotification);
        soloButton.setToggleState(false, juce::NotificationType::sendNotification);
    }
    if (&clickedButton == &bypassButton && bypassButton.getToggleState())
    {
        soloButton.setToggleState(false, juce::NotificationType::sendNotification);
        muteButton.setToggleState(false, juce::NotificationType::sendNotification);
    }
}

void CompressorBandControls::updateAttachments()
{
    enum BandType
    {
        Low,
        Mid,
        High
    };

    BandType bandType = [this]()
    {
            if (lowBand.getToggleState()) return BandType::Low;
            if (midBand.getToggleState()) return BandType::Mid;
            return BandType::High;
    }();

    using namespace Params;
    std::vector<Names> names;

    switch (bandType)
    {
        case Low:
        {
            names = std::vector<Names>
            {
                Names::Attack_Low_Band,
                Names::Release_Low_Band,
                Names::Threashold_Low_Band,
                Names::Ratio_Low_Band,
                Names::Mute_Low_Band,
                Names::Solo_Low_Band,
                Names::Bypassed_Low_Band,
            };
            break;
        }
        case Mid:
        {
            names = std::vector<Names>
            {
                Names::Attack_Mid_Band,
                Names::Release_Mid_Band,
                Names::Threashold_Mid_Band,
                Names::Ratio_Mid_Band,
                Names::Mute_Mid_Band,
                Names::Solo_Mid_Band,
                Names::Bypassed_Mid_Band,
            };
            break;
        }
        case High:
        {
            names = std::vector<Names>
            {
                Names::Attack_High_Band,
                Names::Release_High_Band,
                Names::Threashold_High_Band,
                Names::Ratio_High_Band,
                Names::Mute_High_Band,
                Names::Solo_High_Band,
                Names::Bypassed_High_Band,
            };
            break;
        }
    }

    enum Pos
    {
        Attack,
        Release,
        Threashold,
        Ratio,
        Mute,
        Solo,
        Bypass
    };

    const auto& params = GetParams();

    auto getParamHelper = [&params, &apvts = this->apvts, &names](const auto& pos) -> auto&
        {
            return getParam(apvts, params, names.at(pos));
        };

    attackSliderAttachment.reset();
    releaseSliderAttachment.reset();
    threasholdSliderAttachment.reset();
    ratioSliderAttachment.reset();
    bypassButtonAttachment.reset();
    soloButtonAttachment.reset();
    muteButtonAttachment.reset();

    auto& attackParam = getParamHelper(Pos::Attack);
    addLabelPairs(attackSlider.labels, attackParam, "ms");
    attackSlider.changeParam(&attackParam);

    auto& releaseParam = getParamHelper(Pos::Release);
    addLabelPairs(releaseSlider.labels, releaseParam, "ms");
    releaseSlider.changeParam(&releaseParam);

    auto& threasholdParam = getParamHelper(Pos::Threashold);
    addLabelPairs(threasholdSlider.labels, threasholdParam, "dB");
    threasholdSlider.changeParam(&threasholdParam);

    auto& ratioParamRap = getParamHelper(Pos::Ratio);
    ratioSlider.labels.clear();
    ratioSlider.labels.add({ 0.f, "1:1" });
    auto ratioParam = dynamic_cast<juce::AudioParameterChoice*>(&ratioParamRap);
    ratioSlider.labels.add({ 1.0f, juce::String(ratioParam->choices.getReference(ratioParam->choices.size() - 1).getIntValue()) + ":1" });
    ratioSlider.changeParam(ratioParam);

    auto makeAttachmentHelper = [&params, &apvts = this->apvts](auto& attachment, const auto& name, auto& slider)
        {
            makeAttachment(attachment, apvts, params, name, slider);
        };

    makeAttachmentHelper(attackSliderAttachment, names[Pos::Attack], attackSlider);
    makeAttachmentHelper(releaseSliderAttachment, names[Pos::Release], releaseSlider);
    makeAttachmentHelper(threasholdSliderAttachment, names[Pos::Threashold], threasholdSlider);
    makeAttachmentHelper(ratioSliderAttachment, names[Pos::Ratio], ratioSlider);
    makeAttachmentHelper(bypassButtonAttachment, names[Pos::Bypass], bypassButton);
    makeAttachmentHelper(soloButtonAttachment, names[Pos::Solo], soloButton);
    makeAttachmentHelper(muteButtonAttachment, names[Pos::Mute], muteButton);
}

//==============================================================================

GlobalControls::GlobalControls(juce::AudioProcessorValueTreeState& apvts)
{
    using namespace Params;
    const auto& params = GetParams();

    auto getParamHelper = [&params, &apvts](const auto& name) -> auto&
        {
            return getParam(apvts, params, name);
        };

    auto& gainInParam = getParamHelper(Names::Gain_In);
    auto& lowMidParam = getParamHelper(Names::Low_Mid_Crossover_Freq);
    auto& midHighParam = getParamHelper(Names::Mid_High_Crossover_Freq);
    auto& gainOutParam = getParamHelper(Names::Gain_Out);

    inGainSlider = std::make_unique<RSWL>(&gainInParam, "dB", "INPUT TRIM");
    lowMidXoverSlider = std::make_unique<RSWL>(&lowMidParam, "Hz", "LOW-MID X-OVER");
    midHighXoverSlider = std::make_unique<RSWL>(&midHighParam, "Hz", "MID-HI X-OVER");
    outGainSlider = std::make_unique<RSWL>(&gainOutParam, "dB", "OUTPUT TRIM");

    auto makeAttachmentHelper = [&params, &apvts](auto& attachment, const auto& name, auto& slider)
        {
            makeAttachment(attachment, apvts, params, name, slider);
        };

    makeAttachmentHelper(inGainSliderAttachment, Names::Gain_In, *inGainSlider);
    makeAttachmentHelper(lowMidXoverSliderAttachment, Names::Low_Mid_Crossover_Freq, *lowMidXoverSlider);
    makeAttachmentHelper(midHighXoverSliderAttachment, Names::Mid_High_Crossover_Freq, *midHighXoverSlider);
    makeAttachmentHelper(outGainSliderAttachment, Names::Gain_Out, *outGainSlider);

    addLabelPairs(inGainSlider->labels, gainInParam, "dB");
    addLabelPairs(lowMidXoverSlider->labels, lowMidParam, "Hz");
    addLabelPairs(midHighXoverSlider->labels, midHighParam, "Hz");
    addLabelPairs(outGainSlider->labels, gainOutParam, "dB");

    addAndMakeVisible(*inGainSlider);
    addAndMakeVisible(*lowMidXoverSlider);
    addAndMakeVisible(*midHighXoverSlider);
    addAndMakeVisible(*outGainSlider);
}

void GlobalControls::paint(juce::Graphics& g)
{
    using namespace juce;
    auto bounds = getLocalBounds();
    g.setColour(Colours::blueviolet);
    g.fillAll();

    auto localBounds = bounds;

    bounds.reduce(3, 3);
    g.setColour(Colours::black);
    g.fillRoundedRectangle(bounds.toFloat(), 3);

    g.drawRect(localBounds);
}

void GlobalControls::resized()
{
    auto bounds = getLocalBounds().reduced(5);
    using namespace juce;

    FlexBox flexBox;
    flexBox.flexDirection = FlexBox::Direction::row;
    flexBox.flexWrap = FlexBox::Wrap::noWrap;

    auto spacer = FlexItem().withWidth(4);
    auto endCap = FlexItem().withWidth(6);

    flexBox.items.add(endCap);
    flexBox.items.add(FlexItem(*inGainSlider).withFlex(1.f));
    flexBox.items.add(spacer);
    flexBox.items.add(FlexItem(*lowMidXoverSlider).withFlex(1.f));
    flexBox.items.add(spacer);
    flexBox.items.add(FlexItem(*midHighXoverSlider).withFlex(1.f));
    flexBox.items.add(spacer);
    flexBox.items.add(FlexItem(*outGainSlider).withFlex(1.f));
    flexBox.items.add(endCap);

    flexBox.performLayout(bounds);
}

//==============================================================================

ControlBar::ControlBar()
{
    analyzerButton.setToggleState(true, juce::NotificationType::dontSendNotification);
    addAndMakeVisible(analyzerButton);
    addAndMakeVisible(globalBypassButton);
}

void ControlBar::resized()
{
    auto bounds = getLocalBounds();
    analyzerButton.setBounds(bounds.removeFromLeft(50).withTrimmedTop(4).withTrimmedBottom(4));
    globalBypassButton.setBounds(bounds.removeFromRight(60).withTrimmedTop(2).withTrimmedBottom(2));
}

//==============================================================================

MultibandAudioCompressorAudioProcessorEditor::MultibandAudioCompressorAudioProcessorEditor (MultibandAudioCompressorAudioProcessor& p)
    : AudioProcessorEditor (&p), audioProcessor (p)
{
    // Make sure that before the constructor has finished, you've set the
    // editor's size to whatever you need it to be.

    setLookAndFeel(&lnf);

    controlBar.analyzerButton.onClick = [this]()
        {
            auto shouldBeOn = controlBar.analyzerButton.getToggleState();
            analyzer.toggleAnalysisEnablement(shouldBeOn);
        };

    controlBar.globalBypassButton.onClick = [this]()
        {
            toggleGlobalBypassState();
        };

    addAndMakeVisible(controlBar);
    addAndMakeVisible(analyzer);
    addAndMakeVisible(globalControls);
    addAndMakeVisible(bandControls);

    setSize (600, 500);

    startTimerHz(60);
}

MultibandAudioCompressorAudioProcessorEditor::~MultibandAudioCompressorAudioProcessorEditor()
{
    setLookAndFeel(nullptr);
}

void MultibandAudioCompressorAudioProcessorEditor::paint (juce::Graphics& g)
{
    g.fillAll(juce::Colours::black);
}

void MultibandAudioCompressorAudioProcessorEditor::resized()
{
    // This is generally where you'll want to lay out the positions of any
    // subcomponents in your editor..
    auto bounds = getLocalBounds();
    controlBar.setBounds(bounds.removeFromTop(32));
    bandControls.setBounds(bounds.removeFromBottom(135));
    analyzer.setBounds(bounds.removeFromTop(225));
    globalControls.setBounds(bounds);
}

void MultibandAudioCompressorAudioProcessorEditor::timerCallback()
{
    std::vector<float> values
    {
        audioProcessor.lowBandComp.getRMSInputLevelDb(),
        audioProcessor.lowBandComp.getRMSOutputLevelDb(),
        audioProcessor.midBandComp.getRMSInputLevelDb(),
        audioProcessor.midBandComp.getRMSOutputLevelDb(),
        audioProcessor.highBandComp.getRMSInputLevelDb(),
        audioProcessor.highBandComp.getRMSOutputLevelDb()
    };

    analyzer.update(values);
    updateGlobalBypassButton();
}

void MultibandAudioCompressorAudioProcessorEditor::updateGlobalBypassButton()
{
    auto params = getBypassParams();
    bool allBandsAreBypassed = std::all_of(params.begin(), params.end(), [](const auto& param) {return param->get(); });
    controlBar.globalBypassButton.setToggleState(allBandsAreBypassed, juce::NotificationType::dontSendNotification);
}

void MultibandAudioCompressorAudioProcessorEditor::toggleGlobalBypassState()
{
    auto shouldEnableEverything = !controlBar.globalBypassButton.getToggleState();
    auto params = getBypassParams();

    auto bypassParamHelper = [](auto* param, bool shouldBeBypassed)
        {
            param->beginChangeGesture();
            param->setValueNotifyingHost(shouldBeBypassed ? 1.f : 0.f);
            param->endChangeGesture();
        };
    for (auto* param : params)
    {
        bypassParamHelper(param, !shouldEnableEverything);
    }
}

std::array<juce::AudioParameterBool*, 3> MultibandAudioCompressorAudioProcessorEditor::getBypassParams()
{
    using namespace Params;
    using namespace juce;
    const auto& params = Params::GetParams();
    auto& apvts = audioProcessor.apvts;

    auto boolHelper = [&apvts, &params](const auto& paramName)
        {
            auto param = dynamic_cast<juce::AudioParameterBool*>(apvts.getParameter(params.at(paramName)));
            jassert(param != nullptr);

            return param;
        };

    auto* lowBypassParam = boolHelper(Names::Bypassed_Low_Band);
    auto* midBypassParam = boolHelper(Names::Bypassed_Mid_Band);
    auto* highBypassParam = boolHelper(Names::Bypassed_High_Band);

    return { lowBypassParam, midBypassParam, highBypassParam };
}