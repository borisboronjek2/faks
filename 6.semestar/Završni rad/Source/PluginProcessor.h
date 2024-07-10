/*
  ==============================================================================

    This file contains the basic framework code for a JUCE plugin processor.

  ==============================================================================
*/

#pragma once

#include <JuceHeader.h>

#include <array>

#define MIN_FREQUENCY 20.f
#define MAX_FREQUENCY 20000.f
#define NEGATIVE_INFINITY -72.f
#define MAX_DECIBELS 12.f
#define MIN_THREASHOLD -60.f

template<typename T>
struct Fifo
{
    void prepare(int numChannels, int numSamples)
    {
        static_assert(std::is_same_v<T, juce::AudioBuffer<float>>,
            "prepare(numChannels, numSamples) should only be used when the Fifo is holding juce::AudioBuffer<float>");
        for (auto& buffer : buffers)
        {
            buffer.setSize(numChannels,
                numSamples,
                false,
                true,
                true);
            buffer.clear();
        }
    }

    void prepare(size_t numElements)
    {
        static_assert(std::is_same_v<T, std::vector<float>>,
            "prepare(numElements) should only be used when the Fifo is holding std::vector<float>");
        for (auto& buffer : buffers)
        {
            buffer.clear();
            buffer.resize(numElements, 0);
        }
    }

    bool push(const T& t)
    {
        auto write = fifo.write(1);
        if (write.blockSize1 > 0)
        {
            buffers[write.startIndex1] = t;
            return true;
        }

        return false;
    }

    bool pull(T& t)
    {
        auto read = fifo.read(1);
        if (read.blockSize1 > 0)
        {
            t = buffers[read.startIndex1];
            return true;
        }

        return false;
    }

    int getNumAvailableForReading() const
    {
        return fifo.getNumReady();
    }
private:
    static constexpr int Capacity = 30;
    std::array<T, Capacity> buffers;
    juce::AbstractFifo fifo{ Capacity };
};

enum Channel
{
    Right,
    Left
};

template<typename BlockType>
struct SingleChannelSampleFifo
{
    SingleChannelSampleFifo(Channel ch) : channelToUse(ch)
    {
        prepared.set(false);
    }

    void update(const BlockType& buffer)
    {
        jassert(prepared.get());
        jassert(buffer.getNumChannels() > channelToUse);
        auto* channelPtr = buffer.getReadPointer(channelToUse);

        for (int i = 0; i < buffer.getNumSamples(); ++i)
        {
            pushNextSampleIntoFifo(channelPtr[i]);
        }
    }

    void prepare(int bufferSize)
    {
        prepared.set(false);
        size.set(bufferSize);

        bufferToFill.setSize(1,
            bufferSize,
            false,
            true,
            true);
        audioBufferFifo.prepare(1, bufferSize);
        fifoIndex = 0;
        prepared.set(true);
    }
    //==============================================================================
    int getNumCompleteBuffersAvailable() const { return audioBufferFifo.getNumAvailableForReading(); }
    bool isPrepared() const { return prepared.get(); }
    int getSize() const { return size.get(); }
    //==============================================================================
    bool getAudioBuffer(BlockType& buf) { return audioBufferFifo.pull(buf); }
private:
    Channel channelToUse;
    int fifoIndex = 0;
    Fifo<BlockType> audioBufferFifo;
    BlockType bufferToFill;
    juce::Atomic<bool> prepared = false;
    juce::Atomic<int> size = 0;

    void pushNextSampleIntoFifo(float sample)
    {
        if (fifoIndex == bufferToFill.getNumSamples())
        {
            auto ok = audioBufferFifo.push(bufferToFill);

            juce::ignoreUnused(ok);

            fifoIndex = 0;
        }

        bufferToFill.setSample(0, fifoIndex, sample);
        ++fifoIndex;
    }
};

namespace Params
{
    enum Names
    {
        Low_Mid_Crossover_Freq,
        Mid_High_Crossover_Freq,

        Threashold_Low_Band,
        Threashold_Mid_Band,
        Threashold_High_Band,

        Attack_Low_Band,
        Attack_Mid_Band,
        Attack_High_Band,

        Release_Low_Band,
        Release_Mid_Band,
        Release_High_Band,

        Ratio_Low_Band,
        Ratio_Mid_Band,
        Ratio_High_Band,

        Bypassed_Low_Band,
        Bypassed_Mid_Band,
        Bypassed_High_Band,

        Mute_Low_Band,
        Mute_Mid_Band,
        Mute_High_Band,

        Solo_Low_Band,
        Solo_Mid_Band,
        Solo_High_Band,

        Gain_In,
        Gain_Out,
    };

    inline const std::map<Names, juce::String>& GetParams()
    {
        static std::map<Names, juce::String> params = 
        {
            {Low_Mid_Crossover_Freq,"Low-Mid Crossover Freq"},
            {Mid_High_Crossover_Freq,"Mid-High Crossover Freq"},
            {Threashold_Low_Band,"Threashold Low Band"},
            {Threashold_Mid_Band,"Threashold Mid Band"},
            {Threashold_High_Band,"Threashold High Band"},
            {Attack_Low_Band,"Attack Low Band"},
            {Attack_Mid_Band,"Attack Mid Band"},
            {Attack_High_Band,"Attack High Band"},
            {Release_Low_Band,"Release Low Band"},
            {Release_Mid_Band,"Release Mid Band"},
            {Release_High_Band,"Release High Band"},
            {Ratio_Low_Band,"Ratio Low Band"},
            {Ratio_Mid_Band,"Ratio Mid Band"},
            {Ratio_High_Band,"Ratio High Band"},
            {Bypassed_Low_Band,"Bypassed Low Band"},
            {Bypassed_Mid_Band,"Bypassed Mid Band"},
            {Bypassed_High_Band,"Bypassed High Band"},
            {Mute_Low_Band,"Mute Low Band"},
            {Mute_Mid_Band,"Mute Mid Band"},
            {Mute_High_Band,"Mute High Band"},
            {Solo_Low_Band,"Solo Low Band"},
            {Solo_Mid_Band,"Solo Mid Band"},
            {Solo_High_Band,"Solo High Band"},
            {Gain_In,"Gain In"},
            {Gain_Out,"Gain Out"},
        };

        return params;
    }
}

struct CompressorBand
{
    juce::AudioParameterFloat* attack{ nullptr };
    juce::AudioParameterFloat* release{ nullptr };
    juce::AudioParameterFloat* threashold{ nullptr };
    juce::AudioParameterChoice* ratio{ nullptr };
    juce::AudioParameterBool* bypassed{ nullptr };
    juce::AudioParameterBool* mute{ nullptr };
    juce::AudioParameterBool* solo{ nullptr };

    void prepare(const juce::dsp::ProcessSpec& spec)
    {
        compressor.prepare(spec);
    }
    void updateCompressorSettings()
    {
        compressor.setAttack(attack->get());
        compressor.setRelease(release->get());
        compressor.setThreshold(threashold->get());
        compressor.setRatio(ratio->getCurrentChoiceName().getFloatValue());
    }
    void process(juce::AudioBuffer<float>& buffer)
    {
        auto preRMS = computeRMSLevel(buffer);
        auto block = juce::dsp::AudioBlock<float>(buffer);
        auto context = juce::dsp::ProcessContextReplacing<float>(block);

        context.isBypassed = bypassed->get();

        compressor.process(context);

        auto postRMS = computeRMSLevel(buffer);

        auto convertToDb = [](auto input)
            {
                return juce::Decibels::gainToDecibels(input);
            };

        rmsInputLevelDb.store(convertToDb(preRMS));
        rmsOutputLevelDb.store(convertToDb(postRMS));
    }

    float getRMSInputLevelDb() const { return rmsInputLevelDb; }
    float getRMSOutputLevelDb() const { return rmsOutputLevelDb; }

private:
    juce::dsp::Compressor<float> compressor;

    std::atomic<float> rmsInputLevelDb{ NEGATIVE_INFINITY };
    std::atomic<float> rmsOutputLevelDb{ NEGATIVE_INFINITY };

    template<typename T>
    float computeRMSLevel(const T& buffer)
    {
        int numChannels = static_cast<int>(buffer.getNumChannels());
        int numSamples = static_cast<int>(buffer.getNumSamples());
        auto rms = 0.f;
        for (int chan = 0; chan < numChannels; ++chan)
        {
            rms += buffer.getRMSLevel(chan, 0, numSamples);
        }

        rms /= static_cast<float>(numChannels);
        return rms;
    }
};

//==============================================================================
/**
*/
class MultibandAudioCompressorAudioProcessor  : public juce::AudioProcessor
{
public:
    //==============================================================================
    MultibandAudioCompressorAudioProcessor();
    ~MultibandAudioCompressorAudioProcessor() override;

    //==============================================================================
    void prepareToPlay (double sampleRate, int samplesPerBlock) override;
    void releaseResources() override;

   #ifndef JucePlugin_PreferredChannelConfigurations
    bool isBusesLayoutSupported (const BusesLayout& layouts) const override;
   #endif

    void processBlock (juce::AudioBuffer<float>&, juce::MidiBuffer&) override;

    //==============================================================================
    juce::AudioProcessorEditor* createEditor() override;
    bool hasEditor() const override;

    //==============================================================================
    const juce::String getName() const override;

    bool acceptsMidi() const override;
    bool producesMidi() const override;
    bool isMidiEffect() const override;
    double getTailLengthSeconds() const override;

    //==============================================================================
    int getNumPrograms() override;
    int getCurrentProgram() override;
    void setCurrentProgram (int index) override;
    const juce::String getProgramName (int index) override;
    void changeProgramName (int index, const juce::String& newName) override;

    //==============================================================================
    void getStateInformation (juce::MemoryBlock& destData) override;
    void setStateInformation (const void* data, int sizeInBytes) override;

    using APVTS = juce::AudioProcessorValueTreeState;
    static APVTS::ParameterLayout createParamaterLayout();

    APVTS apvts{ *this, nullptr, "Paramaters", createParamaterLayout() };
    using BlockType = juce::AudioBuffer<float>;
    SingleChannelSampleFifo<BlockType> leftChannelFifo{ Channel::Left };
    SingleChannelSampleFifo<BlockType> rightChannelFifo{ Channel::Right };

    std::array<CompressorBand, 3> compressors;
    CompressorBand& lowBandComp = compressors[0];
    CompressorBand& midBandComp = compressors[1];
    CompressorBand& highBandComp = compressors[2];

private:
    using Filter = juce::dsp::LinkwitzRileyFilter<float>;
    Filter LP1, AP2, HP1, LP2, HP2;
    juce::AudioParameterFloat* lowMidCrossover { nullptr };
    juce::AudioParameterFloat* midHighCrossover{ nullptr };
    std::array<juce::AudioBuffer<float>, 3> filterBuffers;

    juce::dsp::Gain<float> inputGain, outputGain;
    juce::AudioParameterFloat* inputGainParam{ nullptr };
    juce::AudioParameterFloat* outputGainParam{ nullptr };

    template <typename T, typename U>
    void applyGain(T& buffer, U& gain)
    {
        auto block = juce::dsp::AudioBlock<float>(buffer);
        auto context = juce::dsp::ProcessContextReplacing<float>(block);
        gain.process(context);
    }
    void updateState();
    void splitBands(const juce::AudioBuffer<float>& inputBuffer);
    //==============================================================================
    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (MultibandAudioCompressorAudioProcessor)
};
