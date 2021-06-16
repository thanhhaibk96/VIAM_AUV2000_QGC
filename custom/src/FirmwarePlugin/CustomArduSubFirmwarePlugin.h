#ifndef CustomArduSubFirmwarePlugin_H
#define CustomArduSubFirmwarePlugin_H

#include "CustomFirmwarePlugin.h"

class CustomAPMSubmarineFactGroup : public FactGroup
{
  Q_OBJECT

public:
  CustomAPMSubmarineFactGroup(QObject* parent = nullptr);

  Q_PROPERTY(Fact* camTilt READ camTilt CONSTANT)
  Q_PROPERTY(Fact* tetherTurns READ tetherTurns CONSTANT)
  Q_PROPERTY(Fact* lightsLevel1 READ lightsLevel1 CONSTANT)
  Q_PROPERTY(Fact* lightsLevel2 READ lightsLevel2 CONSTANT)
  Q_PROPERTY(Fact* pilotGain READ pilotGain CONSTANT)
  Q_PROPERTY(Fact* inputHold READ inputHold CONSTANT)
  Q_PROPERTY(Fact* rangefinderDistance READ rangefinderDistance CONSTANT)

  Fact* camTilt(void) { return &_camTiltFact; }
  Fact* tetherTurns(void) { return &_tetherTurnsFact; }
  Fact* lightsLevel1(void) { return &_lightsLevel1Fact; }
  Fact* lightsLevel2(void) { return &_lightsLevel2Fact; }
  Fact* pilotGain(void) { return &_pilotGainFact; }
  Fact* inputHold(void) { return &_inputHoldFact; }
  Fact* rangefinderDistance(void) { return &_rangefinderDistanceFact; }

  static const char* _camTiltFactName;
  static const char* _tetherTurnsFactName;
  static const char* _lightsLevel1FactName;
  static const char* _lightsLevel2FactName;
  static const char* _pilotGainFactName;
  static const char* _inputHoldFactName;
  static const char* _rangefinderDistanceFactName;

  static const char* _settingsGroup;

private:
  Fact _camTiltFact;
  Fact _tetherTurnsFact;
  Fact _lightsLevel1Fact;
  Fact _lightsLevel2Fact;
  Fact _pilotGainFact;
  Fact _inputHoldFact;
  Fact _rangefinderDistanceFact;
};

class CustomAPMSubMode : public APMCustomMode
{
public:
  enum Mode
  {
    STABILIZE = 0, // Hold level position
    ACRO = 1,      // Manual angular rate, throttle
    DEPTH_HOLD = 2,  // Depth hold
    AUTO = 3,      // Full auto to waypoint
    GUIDED = 4,    // Full auto to coordinate/direction
    RESERVED_5 = 5,
    RESERVED_6 = 6,
    CIRCLE = 7, // Auto circling
    RESERVED_8 = 8,
    SURFACE = 9, // Auto return to surface
    RESERVED_10 = 10,
    RESERVED_11 = 11,
    RESERVED_12 = 12,
    ROLL_STABILIZE = 13,
    SPEED_HOLD = 14,
    LINEOFSIGHT = 15,
    POSITION_HOLD = 16, // Hold position
    PITCH_HOLD = 17,
    HEADING_HOLD = 18,
    MANUAL = 19, // Manual control
    OBSTACLE = 20 // Obstacle avoidance
  };
  static const int modeCount = 20;

  CustomAPMSubMode(uint32_t mode, bool settable);
};

class CustomArduSubFirmwarePlugin : public CustomFirmwarePlugin
{
  Q_OBJECT

public:
  CustomArduSubFirmwarePlugin(void);

  QList<MAV_CMD> supportedMissionCommands(void) final;
  int defaultJoystickTXMode(void) final { return 3; }
  void initializeStreamRates(Vehicle* vehicle) override final;
  bool isCapable(const Vehicle* vehicle,
                 FirmwareCapabilities capabilities) final;
  bool supportsThrusterModeCenterZero(void) final;
  bool supportsRadio(void) final;
  bool supportsJSButton(void) final;
  bool supportsMotorInterference(void) final;
  virtual QString vehicleImageOpaque(const Vehicle* vehicle) const final;
  virtual QString vehicleImageOutline(const Vehicle* vehicle) const final;
  QString brandImageIndoor(const Vehicle* vehicle) const final
  {
    Q_UNUSED(vehicle);
    return QStringLiteral("/qmlimages/src/FirmwarePlugin/APM/APMBrandImageAUV2000.png");
  }
  QString brandImageOutdoor(const Vehicle* vehicle) const final
  {
    Q_UNUSED(vehicle);
    return QStringLiteral("/qmlimages/src/FirmwarePlugin/APM/APMBrandImageAUV2000.png");
  }
  const FirmwarePlugin::remapParamNameMajorVersionMap_t&
  paramNameRemapMajorVersionMap(void) const final
  {
    return _remapParamName;
  }
  int remapParamNameHigestMinorVersionNumber(
      int majorVersionNumber) const final;
  const QVariantList& toolBarIndicators(const Vehicle* vehicle) final;
  bool adjustIncomingMavlinkMessage(Vehicle* vehicle,
                                    mavlink_message_t* message) final;
  virtual QMap<QString, FactGroup*>* factGroups(void) final;
  void adjustMetaData(MAV_TYPE vehicleType,
                      FactMetaData* metaData) override final;

private:
  QVariantList _toolBarIndicators;
  static bool _remapParamNameIntialized;
  QMap<QString, QString> _factRenameMap;
  static FirmwarePlugin::remapParamNameMajorVersionMap_t _remapParamName;
  void _handleNamedValueFloat(mavlink_message_t* message);
  void _handleMavlinkMessage(mavlink_message_t* message);

  QMap<QString, FactGroup*> _nameToFactGroupMap;
  CustomAPMSubmarineFactGroup _infoFactGroup;
};

#endif
