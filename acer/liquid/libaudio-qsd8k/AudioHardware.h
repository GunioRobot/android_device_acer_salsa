/*
** Copyright 2008, The Android Open-Source Project
**
** Licensed under the Apache License, Version 2.0 (the "License");
** you may not use this file except in compliance with the License.
** You may obtain a copy of the License at
**
**     http://www.apache.org/licenses/LICENSE-2.0
**
** Unless required by applicable law or agreed to in writing, software
** distributed under the License is distributed on an "AS IS" BASIS,
** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
** See the License for the specific language governing permissions and
** limitations under the License.
*/

#ifndef ANDROID_AUDIO_HARDWARE_H
#define ANDROID_AUDIO_HARDWARE_H

#include <stdint.h>
#include <sys/types.h>

#include <utils/threads.h>
#include <utils/SortedVector.h>

#include <hardware_legacy/AudioHardwareBase.h>

extern "C" {
#include <linux/msm_audio.h>
#include <linux/msm_audio_qcp.h>
#include <linux/msm_audio_aac.h>
#include <linux/msm_audio_amrnb.h>
}


namespace android {

// ----------------------------------------------------------------------------
// Kernel driver interface
//
/* Source (TX) devices */
#define ADSP_AUDIO_DEVICE_ID_HANDSET_MIC	0x107ac8d
#define ADSP_AUDIO_DEVICE_ID_HEADSET_MIC	0x1081510
#define ADSP_AUDIO_DEVICE_ID_SPKR_PHONE_MIC	0x1081512
#define ADSP_AUDIO_DEVICE_ID_BT_SCO_MIC		0x1081518
#define ADSP_AUDIO_DEVICE_ID_TTY_HEADSET_MIC	0x108151b
#define ADSP_AUDIO_DEVICE_ID_I2S_MIC		0x1089bf3
#define ADSP_AUDIO_DEVICE_ID_HANDSET_DUAL_MIC     0x108f9c3
#define ADSP_AUDIO_DEVICE_ID_SPKR_PHONE_DUAL_MIC  0x108f9c5

/* Special loopback pseudo device to be paired with an RX device */
/* with usage ADSP_AUDIO_DEVICE_USAGE_MIXED_PCM_LOOPBACK */
#define ADSP_AUDIO_DEVICE_ID_MIXED_PCM_LOOPBACK_TX	0x1089bf2

/* Sink (RX) devices */
#define ADSP_AUDIO_DEVICE_ID_HANDSET_SPKR			0x107ac88
#define ADSP_AUDIO_DEVICE_ID_HEADSET_SPKR_MONO			0x1081511
#define ADSP_AUDIO_DEVICE_ID_HEADSET_SPKR_STEREO		0x107ac8a
#define ADSP_AUDIO_DEVICE_ID_SPKR_PHONE_MONO			0x1081513
#define ADSP_AUDIO_DEVICE_ID_SPKR_PHONE_MONO_W_MONO_HEADSET     0x108c508
#define ADSP_AUDIO_DEVICE_ID_SPKR_PHONE_MONO_W_STEREO_HEADSET   0x108c894
#define ADSP_AUDIO_DEVICE_ID_SPKR_PHONE_STEREO			0x1081514
#define ADSP_AUDIO_DEVICE_ID_SPKR_PHONE_STEREO_W_MONO_HEADSET   0x108c895
#define ADSP_AUDIO_DEVICE_ID_SPKR_PHONE_STEREO_W_STEREO_HEADSET	0x108c509
#define ADSP_AUDIO_DEVICE_ID_BT_SCO_SPKR			0x1081519
#define ADSP_AUDIO_DEVICE_ID_TTY_HEADSET_SPKR			0x108151c
#define ADSP_AUDIO_DEVICE_ID_I2S_SPKR				0x1089bf4

#define HANDSET_MIC                ADSP_AUDIO_DEVICE_ID_HANDSET_MIC
#define HANDSET_SPKR               ADSP_AUDIO_DEVICE_ID_HANDSET_SPKR
#define HEADSET_MIC                ADSP_AUDIO_DEVICE_ID_HEADSET_MIC
#define HEADSET_SPKR_MONO          ADSP_AUDIO_DEVICE_ID_HEADSET_SPKR_MONO
#define HEADSET_SPKR_STEREO        ADSP_AUDIO_DEVICE_ID_HEADSET_SPKR_STEREO
#define SPKR_PHONE_MIC             ADSP_AUDIO_DEVICE_ID_SPKR_PHONE_MIC
#define SPKR_PHONE_MONO            ADSP_AUDIO_DEVICE_ID_SPKR_PHONE_MONO
#define SPKR_PHONE_STEREO          ADSP_AUDIO_DEVICE_ID_SPKR_PHONE_STEREO
#define BT_A2DP_SPKR               ADSP_AUDIO_DEVICE_ID_BT_A2DP_SPKR
#define BT_SCO_MIC                 ADSP_AUDIO_DEVICE_ID_BT_SCO_MIC
#define BT_SCO_SPKR                ADSP_AUDIO_DEVICE_ID_BT_SCO_SPKR
#define TTY_HEADSET_MIC            ADSP_AUDIO_DEVICE_ID_TTY_HEADSET_MIC
#define TTY_HEADSET_SPKR           ADSP_AUDIO_DEVICE_ID_TTY_HEADSET_SPKR
#define FM_HEADSET                 ADSP_AUDIO_DEVICE_ID_HEADSET_SPKR_STEREO
#define FM_SPKR	                   ADSP_AUDIO_DEVICE_ID_SPKR_PHONE_MONO
#define SPKR_PHONE_HEADSET_STEREO  ADSP_AUDIO_DEVICE_ID_SPKR_PHONE_MONO_W_MONO_HEADSET
#define HANDSET_DUALMIC            ADSP_AUDIO_DEVICE_ID_HANDSET_DUAL_MIC
#define SPKR_DUALMIC               ADSP_AUDIO_DEVICE_ID_SPKR_PHONE_DUAL_MIC

#define ACDB_ID_EXT_MIC_REC 307
#define ACDB_ID_HEADSET_PLAYBACK 407
#define ACDB_ID_HEADSET_RINGTONE_PLAYBACK 408
#define ACDB_ID_INT_MIC_REC 507
#define ACDB_ID_CAMCORDER   508
#define ACDB_ID_INT_MIC_VR  509
#define ACDB_ID_SPKR_PLAYBACK 607

#define SAMP_RATE_INDX_8000	0
#define SAMP_RATE_INDX_11025	1
#define SAMP_RATE_INDX_12000	2
#define SAMP_RATE_INDX_16000	3
#define SAMP_RATE_INDX_22050	4
#define SAMP_RATE_INDX_24000	5
#define SAMP_RATE_INDX_32000	6
#define SAMP_RATE_INDX_44100	7
#define SAMP_RATE_INDX_48000	8

#define EQ_MAX_BAND_NUM 12

#define ADRC_ENABLE  0x0001
#define ADRC_DISABLE 0x0000
#define EQ_ENABLE    0x0002
#define EQ_DISABLE   0x0000
#define RX_IIR_ENABLE   0x0004
#define RX_IIR_DISABLE  0x0000
#define CAD_HW_DEVICE_ID_SPKR_PHONE_DUAL_MIC_BROADSIDE      0x2B
#define CAD_HW_DEVICE_ID_SPKR_PHONE_DUAL_MIC_ENDFIRE        0x2D
#define CAD_HW_DEVICE_ID_HANDSET_DUAL_MIC_BROADSIDE         0x2C
#define CAD_HW_DEVICE_ID_HANDSET_DUAL_MIC_ENDFIRE           0x2E
struct msm_bt_endpoint {
    int tx;
    int rx;
    char name[64];
};

struct eq_filter_type {
    int16_t gain;
    uint16_t freq;
    uint16_t type;
    uint16_t qf;
};

struct eqalizer {
    uint16_t bands;
    uint16_t params[132];
};

struct rx_iir_filter {
    uint16_t num_bands;
    uint16_t iir_params[48];
};

enum tty_modes {
    TTY_OFF = 0,
    TTY_VCO = 1,
    TTY_HCO = 2,
    TTY_FULL = 3
};

#define CODEC_TYPE_PCM 0
#define PCM_FILL_BUFFER_COUNT 1
#define AUDIO_HW_NUM_OUT_BUF 2  // Number of buffers in audio driver for output
// TODO: determine actual audio DSP and hardware latency
#define AUDIO_HW_OUT_LATENCY_MS 0  // Additionnal latency introduced by audio DSP and hardware in ms
#define AUDIO_HW_OUT_SAMPLERATE 44100 // Default audio output sample rate
#define AUDIO_HW_OUT_CHANNELS (AudioSystem::CHANNEL_OUT_STEREO) // Default audio output channel mask
#define AUDIO_HW_OUT_FORMAT (AudioSystem::PCM_16_BIT)  // Default audio output sample format
#define AUDIO_HW_OUT_BUFSZ 1024  // Default audio output buffer size

#define AUDIO_HW_IN_SAMPLERATE 8000                 // Default audio input sample rate
#define AUDIO_HW_IN_CHANNELS (AudioSystem::CHANNEL_IN_MONO) // Default audio input channel mask
#define AUDIO_HW_IN_BUFSZ 2048  // Default audio input buffer size
#define AUDIO_HW_IN_FORMAT (AudioSystem::PCM_16_BIT)  // Default audio input sample format

#define VOICE_VOLUME_MAX 5  // Maximum voice volume
#define AUDIO_IOCTL_MAGIC 'a'
#define AUDIO_START_FM       _IOW(AUDIO_IOCTL_MAGIC, 37, unsigned)
#define AUDIO_STOP_FM        _IOW(AUDIO_IOCTL_MAGIC, 38, unsigned)
// ----------------------------------------------------------------------------


class AudioHardware : public  AudioHardwareBase
{
    class AudioStreamOutMSM72xx;
    class AudioStreamInMSM72xx;

public:
                        AudioHardware();
    virtual             ~AudioHardware();
    virtual status_t    initCheck();

    virtual status_t    setVoiceVolume(float volume);
    virtual status_t    setMasterVolume(float volume);
    virtual status_t    setFmVolume(float volume);

    virtual status_t    setMode(int mode);

    // mic mute
    virtual status_t    setMicMute(bool state);
    virtual status_t    getMicMute(bool* state);

    virtual status_t    setParameters(const String8& keyValuePairs);
    virtual String8     getParameters(const String8& keys);

    // create I/O streams
    virtual AudioStreamOut* openOutputStream(
                                uint32_t devices,
                                int *format=0,
                                uint32_t *channels=0,
                                uint32_t *sampleRate=0,
                                status_t *status=0);

    virtual AudioStreamIn* openInputStream(

                                uint32_t devices,
                                int *format,
                                uint32_t *channels,
                                uint32_t *sampleRate,
                                status_t *status,
                                AudioSystem::audio_in_acoustics acoustics);

    virtual    void        closeOutputStream(AudioStreamOut* out);
    virtual    void        closeInputStream(AudioStreamIn* in);

    virtual size_t getInputBufferSize(uint32_t sampleRate, int format, int channelCount);

               void        clearCurDevice() { mCurSndDevice = -1; }

protected:
    virtual status_t    dump(int fd, const Vector<String16>& args);

private:

    status_t    doAudioRouteOrMute(uint32_t device);
    status_t    setMicMute_nosync(bool state);
    status_t    checkMicMute();
    status_t    dumpInternals(int fd, const Vector<String16>& args);
    uint32_t    getInputSampleRate(uint32_t sampleRate);
    bool        checkOutputStandby();
    status_t    get_mMode();
    status_t    get_mRoutes();
    status_t    set_mRecordState(bool onoff);
    status_t    get_snd_dev();
    status_t    doRouting(AudioStreamInMSM72xx *input);
    status_t    setFmOnOff(bool onoff);
    AudioStreamInMSM72xx*   getActiveInput_l();
    size_t      getBufferSize(uint32_t sampleRate, int channelCount);

    class AudioStreamOutMSM72xx : public AudioStreamOut {
    public:
                            AudioStreamOutMSM72xx();
        virtual             ~AudioStreamOutMSM72xx();
                status_t    set(AudioHardware* mHardware,
                                uint32_t devices,
                                int *pFormat,
                                uint32_t *pChannels,
                                uint32_t *pRate);
        virtual uint32_t    sampleRate() const { return mSampleRate; }
        // Changed to 1024 from 4800
        virtual size_t      bufferSize() const { return mBufferSize; }
        virtual uint32_t    channels() const { return mChannels; }
        virtual int         format() const { return AUDIO_HW_OUT_FORMAT; }
        virtual uint32_t    latency() const { return (1000*AUDIO_HW_NUM_OUT_BUF*(bufferSize()/frameSize()))/sampleRate()+AUDIO_HW_OUT_LATENCY_MS; }
        virtual status_t    setVolume(float left, float right) { return INVALID_OPERATION; }
        virtual ssize_t     write(const void* buffer, size_t bytes);
        virtual status_t    standby();
        virtual status_t    dump(int fd, const Vector<String16>& args);
                bool        checkStandby();
        virtual status_t    setParameters(const String8& keyValuePairs);
        virtual String8     getParameters(const String8& keys);
                uint32_t    devices() { return mDevices; }
        virtual status_t    getRenderPosition(uint32_t *dspFrames);
        virtual status_t    openDriver();

    private:
                AudioHardware* mHardware;
                int         mFd;
                int         mStartCount;
                int         mRetryCount;
                bool        mStandby;
                uint32_t    mDevices;
                uint32_t    mChannels;
                uint32_t    mSampleRate;
                size_t      mBufferSize;
    };

    class AudioStreamInMSM72xx : public AudioStreamIn {
    public:
        enum input_state {
            AUDIO_INPUT_CLOSED,
            AUDIO_INPUT_OPENED,
            AUDIO_INPUT_STARTED
        };

                            AudioStreamInMSM72xx();
        virtual             ~AudioStreamInMSM72xx();
                status_t    set(AudioHardware* mHardware,
                                uint32_t devices,
                                int *pFormat,
                                uint32_t *pChannels,
                                uint32_t *pRate,
                                AudioSystem::audio_in_acoustics acoustics);
        virtual size_t      bufferSize() const { return mBufferSize; }
        virtual uint32_t    channels() const { return mChannels; }
        virtual int         format() const { return mFormat; }
        virtual uint32_t    sampleRate() const { return mSampleRate; }
        virtual status_t    setGain(float gain) { return INVALID_OPERATION; }
        virtual ssize_t     read(void* buffer, ssize_t bytes);
        virtual status_t    dump(int fd, const Vector<String16>& args);
        virtual status_t    standby();
        virtual status_t    setParameters(const String8& keyValuePairs);
        virtual String8     getParameters(const String8& keys);
        virtual unsigned int  getInputFramesLost() const { return 0; }
                uint32_t    devices() { return mDevices; }
                int         state() const { return mState; }

    private:
                AudioHardware* mHardware;
                int         mFd;
                int         mState;
                int         mRetryCount;
                int         mFormat;
                uint32_t    mChannels;
                uint32_t    mSampleRate;
                size_t      mBufferSize;
                AudioSystem::audio_in_acoustics mAcoustics;
                uint32_t    mDevices;
                bool mFirstread;
    };

            static const uint32_t inputSamplingRates[];
            bool        mRecordState;
            bool        mInit;
            bool        mMicMute;
            bool        mBluetoothNrec;
            uint32_t    mBluetoothIdTx;
            uint32_t    mBluetoothIdRx;
            AudioStreamOutMSM72xx*  mOutput;
            SortedVector <AudioStreamInMSM72xx*>   mInputs;

            msm_bt_endpoint *mBTEndpoints;
            int mNumBTEndpoints;
            int mCurSndDevice;
            uint32_t mVoiceVolume;
            bool        mDualMicEnabled;
            int         mTtyMode;

     friend class AudioStreamInMSM72xx;
            Mutex       mLock;
            uint32_t        mRoutes[AudioSystem::NUM_MODES];
};

// ----------------------------------------------------------------------------

}; // namespace android

#endif // ANDROID_AUDIO_HARDWARE_MSM72XX_H
