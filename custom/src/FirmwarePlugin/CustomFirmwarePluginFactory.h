#pragma once

#include "FirmwarePlugin.h"

class ArduCopterFirmwarePlugin;
class ArduPlaneFirmwarePlugin;
class CustomArduRoverFirmwarePlugin;
class CustomArduSubFirmwarePlugin;

class CustomFirmwarePluginFactory : public FirmwarePluginFactory
{
  Q_OBJECT

public:
  CustomFirmwarePluginFactory(void);

  QList<MAV_AUTOPILOT> supportedFirmwareTypes(void) const final;
  FirmwarePlugin* firmwarePluginForAutopilot(MAV_AUTOPILOT autopilotType,
                                             MAV_TYPE vehicleType) final;

private:
  ArduCopterFirmwarePlugin* _arduCopterPluginInstance;
  ArduPlaneFirmwarePlugin* _arduPlanePluginInstance;
  CustomArduRoverFirmwarePlugin* _arduRoverPluginInstance;
  CustomArduSubFirmwarePlugin* _arduSubPluginInstance;
};
