#pragma once
#include <QQmlApplicationEngine>
#include <QQuickItem>
#include <QQuickView>
#include <QQmlApplicationEngine>

#include "QGCApplication.h"
#include "QGCCorePlugin.h"
#include "QGCLoggingCategory.h"
#include "QGCOptions.h"
#include "QmlComponentInfo.h"

#include "VehicleComponent.h"

Q_DECLARE_LOGGING_CATEGORY(CustomLog)

class CustomPlugin;

class CustomOptions : public QGCOptions
{
public:
  CustomOptions(CustomPlugin*, QObject* parent = nullptr);
};

class CustomPlugin : public QGCCorePlugin
{
  Q_OBJECT
public:
  CustomPlugin();
  CustomPlugin(QGCApplication* app, QGCToolbox* toolbox);
  ~CustomPlugin();

  QVariantList& settingsPages() final;
  QGCOptions* options() final;
  QmlObjectListModel* customMapItems(void) final;

  static void buttonClicked();
  static void btnSendClicked(float _value);
  static void slideBoxTest(float _value);

  Q_PROPERTY(bool enableCusCheckBox    READ    enableCusCheckBox    WRITE setEnableCusCheckBox   NOTIFY enableCusCheckBoxChanged)

  bool enableCusCheckBox     () { return _enableCusCheckBox; }
  void setEnableCusCheckBox (bool enable);

private:
  bool _enableCusCheckBox;

  CustomOptions* _pOptions;
  QVariantList _customSettingsList;
  QmlObjectListModel _customMapItems;

  void addSettingsEntry(const QString& title, const char* qmlFile,
                        const char* iconFile = nullptr);
signals:
  void enableCusCheckBoxChanged();

};
