/*
  ==============================================================================

    This file contains the basic framework code for a JUCE plugin editor.

  ==============================================================================
*/

#pragma once

#include <JuceHeader.h>
#include "PluginProcessor.h"

enum FFTOrder
{
    order2048 = 11,
    order4096 = 12,
    order8192 = 13
};

template<typename BlockType>
struct FFTDataGenerator
{
    void produceFFTDataForRendering(const juce::AudioBuffer<float>& audioData, const float negativeInfinity)
    {
        const auto fftSize = getFFTSize();

        fftData.assign(fftData.size(), 0);
        auto* readIndex = audioData.getReadPointer(0);
        std::copy(readIndex, readIndex + fftSize, fftData.begin());

        window->multiplyWithWindowingTable(fftData.data(), fftSize);

        forwardFFT->performFrequencyOnlyForwardTransform(fftData.data());

        int numBins = (int)fftSize / 2;

        for (int i = 0; i < numBins; ++i)
        {
            auto v = fftData[i];
            if (!std::isinf(v) && !std::isnan(v))
            {
                v /= float(numBins);
            }
            else
            {
                v = 0.f;
            }
            fftData[i] = v;
        }

        for (int i = 0; i < numBins; ++i)
        {
            auto data = juce::Decibels::gainToDecibels(fftData[i], negativeInfinity);
            fftData[i] = data;
        }

        fftDataFifo.push(fftData);
    }

    void changeOrder(FFTOrder newOrder)
    {
        order = newOrder;
        auto fftSize = getFFTSize();

        forwardFFT = std::make_unique<juce::dsp::FFT>(order);
        window = std::make_unique<juce::dsp::WindowingFunction<float>>(fftSize, juce::dsp::WindowingFunction<float>::blackmanHarris);

        fftData.clear();
        fftData.resize(fftSize * 2, 0);

        fftDataFifo.prepare(fftData.size());
    }
    //==============================================================================
    int getFFTSize() const { return 1 << order; }
    int getNumAvailableFFTDataBlocks() const { return fftDataFifo.getNumAvailableForReading(); }
    //==============================================================================
    bool getFFTData(BlockType& fftData) { return fftDataFifo.pull(fftData); }
private:
    FFTOrder order;
    BlockType fftData;
    std::unique_ptr<juce::dsp::FFT> forwardFFT;
    std::unique_ptr<juce::dsp::WindowingFunction<float>> window;

    Fifo<BlockType> fftDataFifo;
};

template<typename PathType>
struct AnalyzerPathGenerator
{
    void generatePath(const std::vector<float>& renderData,
        juce::Rectangle<float> fftBounds,
        int fftSize,
        float binWidth,
        float negativeInfinity)
    {
        auto top = fftBounds.getY();
        auto bottom = fftBounds.getBottom();
        auto width = fftBounds.getWidth();

        int numBins = (int)fftSize / 2;

        PathType p;
        p.preallocateSpace(3 * (int)fftBounds.getWidth());

        auto map = [bottom, top, negativeInfinity](float v)
            {
                return juce::jmap(v,
                    negativeInfinity, MAX_DECIBELS,
                    bottom, top);
            };

        auto y = map(renderData[0]);

        if (std::isnan(y) || std::isinf(y))
            y = bottom;

        p.startNewSubPath(0, y);

        const int pathResolution = 2;

        for (int binNum = 1; binNum < numBins; binNum += pathResolution)
        {
            y = map(renderData[binNum]);

            if (!std::isnan(y) && !std::isinf(y))
            {
                auto binFreq = binNum * binWidth;
                auto normalizedBinX = juce::mapFromLog10(binFreq, MIN_FREQUENCY, MAX_FREQUENCY);
                int binX = std::floor(normalizedBinX * width);
                p.lineTo(binX, y);
            }
        }

        pathFifo.push(p);
    }

    int getNumPathsAvailable() const
    {
        return pathFifo.getNumAvailableForReading();
    }

    bool getPath(PathType& path)
    {
        return pathFifo.pull(path);
    }
private:
    Fifo<PathType> pathFifo;
};

struct PathProducer
{
    PathProducer(SingleChannelSampleFifo<MultibandAudioCompressorAudioProcessor::BlockType>& scsf) :
        leftChannelFifo(&scsf)
    {
        leftChannelFFTDataGenerator.changeOrder(FFTOrder::order2048);
        monoBuffer.setSize(1, leftChannelFFTDataGenerator.getFFTSize());
    }
    void process(juce::Rectangle<float> fftBounds, double sampleRate);
    juce::Path getPath() { return leftChannelFFTPath; }
    void updateNegativeInfinity(float nf) { negativeInfinity = nf; }
private:
    SingleChannelSampleFifo<MultibandAudioCompressorAudioProcessor::BlockType>* leftChannelFifo;

    juce::AudioBuffer<float> monoBuffer;

    FFTDataGenerator<std::vector<float>> leftChannelFFTDataGenerator;

    AnalyzerPathGenerator<juce::Path> pathProducer;

    juce::Path leftChannelFFTPath;

    float negativeInfinity{ -48.f };
};

struct SpectrumAnalyzer : juce::Component,
    juce::AudioProcessorParameter::Listener,
    juce::Timer
{
    SpectrumAnalyzer(MultibandAudioCompressorAudioProcessor&);
    ~SpectrumAnalyzer();

    void parameterValueChanged(int parameterIndex, float newValue) override;

    void parameterGestureChanged(int parameterIndex, bool gestureIsStarting) override { }

    void timerCallback() override;

    void paint(juce::Graphics& g) override;
    void resized() override;

    void toggleAnalysisEnablement(bool enabled)
    {
        shouldShowFFTAnalysis = enabled;
    }

    void update(const std::vector<float>& values);
private:
    MultibandAudioCompressorAudioProcessor& audioProcessor;

    bool shouldShowFFTAnalysis = true;

    juce::Atomic<bool> parametersChanged{ false };

    void drawBackgroundGrid(juce::Graphics& g, juce::Rectangle<int> bounds);
    void drawTextLabels(juce::Graphics& g, juce::Rectangle<int> bounds);

    std::vector<float> getFrequencies();
    std::vector<float> getGains();
    std::vector<float> getXs(const std::vector<float>& freqs, float left, float width);

    juce::Rectangle<int> getRenderArea(juce::Rectangle<int> bounds);

    juce::Rectangle<int> getAnalysisArea(juce::Rectangle<int> bounds);

    PathProducer leftPathProducer, rightPathProducer;
    void drawFFTAnalysis(juce::Graphics& g, juce::Rectangle<int> bounds);
    void drawCrossovers(juce::Graphics& g, juce::Rectangle<int> bounds);

    juce::AudioParameterFloat* lowMidXoverParam{ nullptr };
    juce::AudioParameterFloat* midHighXoverParam{ nullptr };

    juce::AudioParameterFloat* lowThreasholdParam{ nullptr };
    juce::AudioParameterFloat* midThreasholdParam{ nullptr };
    juce::AudioParameterFloat* highThreasholdParam{ nullptr };

    float lowBandGR{ 0.f };
    float midBandGR{ 0.f };
    float highBandGR{ 0.f };
};

struct LookAndFeel : juce::LookAndFeel_V4
{
    void drawRotarySlider(juce::Graphics&,
        int x, int y, int width, int height,
        float sliderPosProportional,
        float rotaryStartAngle,
        float rotaryEndAngle,
        juce::Slider&) override;

    void drawToggleButton(juce::Graphics& g,
        juce::ToggleButton& toggleButton,
        bool shouldDrawButtonAsHighlighted,
        bool shouldDrawButtonAsDown) override;
};

struct RotarySliderWithLabels : juce::Slider
{
    RotarySliderWithLabels(juce::RangedAudioParameter* rap, const juce::String& unitSuffix, const juce::String& title) :
            juce::Slider(juce::Slider::SliderStyle::RotaryHorizontalVerticalDrag,
            juce::Slider::TextEntryBoxPosition::NoTextBox),
        param(rap),
        suffix(unitSuffix)
    {
        setName(title);
    }

    struct LabelPos
    {
        float pos;
        juce::String label;
    };

    juce::Array<LabelPos> labels;

    void paint(juce::Graphics& g) override;
    juce::Rectangle<int> getSliderBounds() const;
    int getTextHeight() const { return 14; }
    virtual juce::String getDisplayString() const;
    void changeParam(juce::RangedAudioParameter* p);
protected:
    juce::RangedAudioParameter* param;
    juce::String suffix;
};

struct RatioSlider : RotarySliderWithLabels
{
    RatioSlider(juce::RangedAudioParameter* rap, const juce::String& unitSuffix) :
        RotarySliderWithLabels(rap, unitSuffix, "RATIO"){}

    juce::String getDisplayString() const override;
};

struct PowerButton : juce::ToggleButton { };

struct AnalyzerButton : juce::ToggleButton
{
    void resized() override
    {
        auto bounds = getLocalBounds();
        auto insetRect = bounds.reduced(4);

        randomPath.clear();

        juce::Random r;

        randomPath.startNewSubPath(insetRect.getX(),
            insetRect.getY() + insetRect.getHeight() * r.nextFloat());

        for (auto x = insetRect.getX() + 1; x < insetRect.getRight(); x += 2)
        {
            randomPath.lineTo(x,
                insetRect.getY() + insetRect.getHeight() * r.nextFloat());
        }
    }

    juce::Path randomPath;
};

template<typename Attachment, typename APVTS, typename Params, typename ParamName, typename SliderType>
void makeAttachment(std::unique_ptr<Attachment>& attachment,
    APVTS& apvts,
    const Params& params,
    const ParamName& name,
    SliderType& slider)
{
    attachment = std::make_unique<Attachment>(apvts, params.at(name), slider);
}

template<typename APVTS, typename Params, typename Name>
juce::RangedAudioParameter& getParam(APVTS& apvts, const Params& params, const Name& name)
{
    auto param = apvts.getParameter(params.at(name));
    jassert(param != nullptr);
    return *param;
}

juce::String getValString(const juce::RangedAudioParameter& param, bool getLow, juce::String suffix);

template<typename Labels, typename ParamType, typename SuffixType>
void addLabelPairs(Labels& labels, const ParamType& param, const SuffixType& suffix)
{
    labels.clear();
    labels.add({ 0.f, getValString(param, true, suffix) });
    labels.add({ 1.f, getValString(param, false, suffix) });
};

struct CompressorBandControls : juce::Component, juce::Button::Listener
{
    CompressorBandControls(juce::AudioProcessorValueTreeState& apvts);
    ~CompressorBandControls() override;
    void resized() override;
    void paint(juce::Graphics& g) override;
    void buttonClicked(juce::Button* button) override;
private:
    juce::AudioProcessorValueTreeState& apvts;
    RotarySliderWithLabels attackSlider, releaseSlider, threasholdSlider;
    RatioSlider ratioSlider;
    using Attachment = juce::AudioProcessorValueTreeState::SliderAttachment;
    std::unique_ptr<Attachment> attackSliderAttachment, releaseSliderAttachment, threasholdSliderAttachment, ratioSliderAttachment;
    juce::ToggleButton bypassButton, soloButton, muteButton, lowBand, midBand, highBand;
    using ButtonAttachment = juce::AudioProcessorValueTreeState::ButtonAttachment;
    std::unique_ptr<ButtonAttachment> bypassButtonAttachment, soloButtonAttachment, muteButtonAttachment;
    juce::Component::SafePointer<CompressorBandControls> safePtr { this };
    void updateAttachments();
    void updateSliderEnamlements();
    void updateSoloMuteBypassToggleStates(juce::Button& clickedButton);
};

struct GlobalControls : juce::Component
{
    GlobalControls(juce::AudioProcessorValueTreeState& apvts);
    void paint(juce::Graphics& g) override;
    void resized() override;

private:
    using RSWL = RotarySliderWithLabels;
    std::unique_ptr<RSWL> inGainSlider, lowMidXoverSlider, midHighXoverSlider, outGainSlider;

    using Attachment = juce::AudioProcessorValueTreeState::SliderAttachment;
    std::unique_ptr<Attachment> inGainSliderAttachment, lowMidXoverSliderAttachment, midHighXoverSliderAttachment, outGainSliderAttachment;
};

struct ControlBar : juce::Component
{
    ControlBar();
    void resized();

    AnalyzerButton analyzerButton;
    PowerButton globalBypassButton;
};

//==============================================================================
/**
*/
class MultibandAudioCompressorAudioProcessorEditor  : public juce::AudioProcessorEditor, juce::Timer
{
public:
    MultibandAudioCompressorAudioProcessorEditor (MultibandAudioCompressorAudioProcessor&);
    ~MultibandAudioCompressorAudioProcessorEditor() override;

    //==============================================================================
    void paint (juce::Graphics&) override;
    void resized() override;

    void timerCallback() override;
private:
    // This reference is provided as a quick way for your editor to
    // access the processor object that created it.
    LookAndFeel lnf;
    MultibandAudioCompressorAudioProcessor& audioProcessor;

    ControlBar controlBar;
    GlobalControls globalControls {audioProcessor.apvts};
    CompressorBandControls bandControls{audioProcessor.apvts};
    SpectrumAnalyzer analyzer{audioProcessor};

    void toggleGlobalBypassState();

    std::array<juce::AudioParameterBool*, 3> getBypassParams();

    void updateGlobalBypassButton();

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (MultibandAudioCompressorAudioProcessorEditor)
};
