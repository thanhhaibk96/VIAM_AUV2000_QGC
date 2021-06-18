#include "CustomPlugin.h"
#include "ParameterManager.h"

QGC_LOGGING_CATEGORY(CustomLog, "CustomLog")

CustomOptions::CustomOptions(CustomPlugin*, QObject* parent)
    : QGCOptions(parent)
{
}

CustomPlugin::CustomPlugin(QGCApplication* app, QGCToolbox* toolbox)
    : QGCCorePlugin(app, toolbox)
{

  _pOptions = new CustomOptions(this, this);
}

CustomPlugin::~CustomPlugin() {}

QVariantList& CustomPlugin::settingsPages()
{
  if (_customSettingsList.isEmpty())
  {
    addSettingsEntry(tr("General"), "qrc:/qml/GeneralSettings.qml",
                     "qrc:/res/gear-white.svg");
    addSettingsEntry(tr("Comm Links"), "qrc:/qml/LinkSettings.qml",
                     "qrc:/res/waves.svg");
    addSettingsEntry(tr("Offline Maps"), "qrc:/qml/OfflineMap.qml",
                     "qrc:/res/waves.svg");
    addSettingsEntry(tr("MAVLink"), "qrc:/qml/MavlinkSettings.qml",
                     "qrc:/res/waves.svg");
    addSettingsEntry(tr("Moclink"), "qrc:/qml/MockLink.qml",
                     "qrc:/res/waves.svg");
    addSettingsEntry(tr("Debug Window"), "qrc:/qml/DebugWindow.qml",
                     "qrc:/res/waves.svg");
    addSettingsEntry(tr("HelpSettings"), "qrc:/qml/HelpSettings.qml",
                     "qrc:/res/waves.svg");
    addSettingsEntry(tr("Console"),
                     "qrc:/qml/QGroundControl/Controls/AppMessages.qml");
    addSettingsEntry(tr("Information"),
                     "qrc:/QGCInformation.qml");
  }
  return _customSettingsList;
}

QGCOptions* CustomPlugin::options() { return _pOptions; }

void CustomPlugin::addSettingsEntry(const QString& title, const char* qmlFile,
                                    const char* iconFile)
{
  Q_CHECK_PTR(qmlFile);
  _customSettingsList.append(QVariant::fromValue(new QmlComponentInfo(
      title, QUrl::fromUserInput(qmlFile),
      iconFile == nullptr ? QUrl() : QUrl::fromUserInput(iconFile), this)));
}

QmlObjectListModel* CustomPlugin:: customMapItems(void)
{
    _customMapItems.append(new QmlComponentInfo(tr("Custom Mass-Shifter/Pistol/Roll"), QUrl::fromUserInput("qrc:/CustomSliderMassPistolRoll.qml"), QUrl(), this));
    _customMapItems.append(new QmlComponentInfo(tr("Custom Thruster"), QUrl::fromUserInput("qrc:/CustomThrusterFlightView.qml"), QUrl(), this));
    _customMapItems.append(new QmlComponentInfo(tr("Custom Rudder"), QUrl::fromUserInput("qrc:/CustomRudderStatus.qml"), QUrl(), this));
//    _customMapItems.append(new QmlComponentInfo(tr("Custom Camera"), QUrl::fromUserInput("qrc:/CustomCamera.qml"), QUrl(), this));

    return &_customMapItems;
}

void CustomPlugin::buttonClicked()
{
    qDebug() << "Qt Button Clicked!!!" << endl;
}

void CustomPlugin::btnSendClicked(float _value)
{
    qDebug() << "Qt Button Send Clicked: " + QString::number(_value) << endl;
}

void CustomPlugin::slideBoxTest(float _value)
{
    qDebug() << "Qt Slider Changed: " + QString::number(_value) << endl;
}

void CustomPlugin::setEnableCusCheckBox(bool enable)
{
    _enableCusCheckBox = enable;
    if(enable) qDebug() << "Qt CheckBox is Checked!!!" << endl;
    else qDebug() << "Qt CheckBox is unChecked!!!" << endl;
    emit enableCusCheckBoxChanged();
}

