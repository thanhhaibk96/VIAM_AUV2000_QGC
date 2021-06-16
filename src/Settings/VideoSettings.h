/****************************************************************************
 *
 *   (c) 2009-2016 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

#ifndef VideoSettings_H
#define VideoSettings_H

#include "SettingsGroup.h"

class VideoSettings : public SettingsGroup
{
    Q_OBJECT

public:
    VideoSettings(QObject* parent = nullptr);
    DEFINE_SETTING_NAME_GROUP()

    DEFINE_SETTINGFACT(videoSource)
    DEFINE_SETTINGFACT(udpPort)
    DEFINE_SETTINGFACT(tcpUrl)
    DEFINE_SETTINGFACT(webServerUrl)
    DEFINE_SETTINGFACT(rtspUrl)
    DEFINE_SETTINGFACT(aspectRatio)
    DEFINE_SETTINGFACT(videoFit)
    DEFINE_SETTINGFACT(gridLines)
    DEFINE_SETTINGFACT(showRecControl)
    DEFINE_SETTINGFACT(recordingFormat)
    DEFINE_SETTINGFACT(maxVideoSize)
    DEFINE_SETTINGFACT(enableStorageLimit)
    DEFINE_SETTINGFACT(rtspTimeout)
    DEFINE_SETTINGFACT(streamEnabled)
    DEFINE_SETTINGFACT(disableWhenDisarmed)

    Q_PROPERTY(bool     streamConfigured        READ streamConfigured       NOTIFY streamConfiguredChanged)
    Q_PROPERTY(QString  rtspVideoSource         READ rtspVideoSource        CONSTANT)
    Q_PROPERTY(QString  udpVideoSource          READ udpVideoSource         CONSTANT)
    Q_PROPERTY(QString  tcpVideoSource          READ tcpVideoSource         CONSTANT)
    Q_PROPERTY(QString  mpegtsVideoSource       READ mpegtsVideoSource      CONSTANT)
    Q_PROPERTY(QString  disabledVideoSource     READ disabledVideoSource      CONSTANT)
    Q_PROPERTY(QString  webServerVideoSource     READ webServerVideoSource      CONSTANT)

    Q_PROPERTY(QString webServerVideoHttp    READ    webServerVideoHttp    NOTIFY webServerVideoHttpChanged)

    Q_INVOKABLE void setWebServerVideoHttp(QString _httpWebServer);;

    bool     streamConfigured       ();
    QString  rtspVideoSource        () { return videoSourceRTSP; }
    QString  udpVideoSource         () { return videoSourceUDP; }
    QString  tcpVideoSource         () { return videoSourceTCP; }
    QString  mpegtsVideoSource      () { return videoSourceMPEGTS; }
    QString  disabledVideoSource    () { return videoDisabled; }
    QString  webServerVideoSource    () { return videoSourceWebServer; }

    static const char* videoSourceNoVideo;
    static const char* videoDisabled;
    static const char* videoSourceUDP;
    static const char* videoSourceRTSP;
    static const char* videoSourceTCP;
    static const char* videoSourceMPEGTS;
    // Streaming Video from websocket http//:
    static const char* videoSourceWebServer;

signals:
    void streamConfiguredChanged    ();
    void webServerVideoHttpChanged (QString _httpWebServer);

private slots:
    void _configChanged             (QVariant value);

private:
    void _setDefaults               ();

    QString webServerVideoHttp(void) { return _webServerVideoHttp; }
private:
    bool _noVideo = false;

    QString _webServerVideoHttp = "";
};

#endif
