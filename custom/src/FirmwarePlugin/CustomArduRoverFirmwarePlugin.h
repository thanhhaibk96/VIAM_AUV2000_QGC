#ifndef CustomArduRoverFirmwarePlugin_H
#define CustomArduRoverFirmwarePlugin_H

#include "CustomFirmwarePlugin.h"

class CustomAPMRoverMode : public APMCustomMode
{
public:
  enum Mode
  {
    MANUAL = 0,
    ACRO = 1,
    STEERING = 3,
    HOLD = 4,
    LOITER = 5,
    FOLLOW = 6,
    SIMPLE = 7,
    AUTO = 10,
    RTL = 11,
    SMART_RTL = 12,
    GUIDED = 15,
    INITIALIZING = 16,
    OBSTACLE = 17,
  };

  CustomAPMRoverMode(uint32_t mode, bool settable);
};

class CustomArduRoverFirmwarePlugin : public CustomFirmwarePlugin
{
  Q_OBJECT

public:
  CustomArduRoverFirmwarePlugin(void);

  // Overrides from FirmwarePlugin
  QString pauseFlightMode(void) const override
  {
    return QStringLiteral("Hold");
  }
  void guidedModeChangeAltitude(Vehicle* vehicle, double altitudeChange) final;
  int remapParamNameHigestMinorVersionNumber(
      int majorVersionNumber) const final;
  const FirmwarePlugin::remapParamNameMajorVersionMap_t&
  paramNameRemapMajorVersionMap(void) const final
  {
    return _remapParamName;
  }
  bool supportsNegativeThrust(void) final;
  const QVariantList& toolBarIndicators(const Vehicle* vehicle) final;

private:
  QVariantList _toolBarIndicators;
  static bool _remapParamNameIntialized;
  static FirmwarePlugin::remapParamNameMajorVersionMap_t _remapParamName;
};

#endif
