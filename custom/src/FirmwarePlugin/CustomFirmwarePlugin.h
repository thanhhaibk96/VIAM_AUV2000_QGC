#pragma once

#include "APMFirmwarePlugin.h"

class CustomFirmwarePlugin : public APMFirmwarePlugin
{
  Q_OBJECT
public:
  CustomFirmwarePlugin();

  AutoPilotPlugin* autopilotPlugin(Vehicle* vehicle) override;

private:
  QString _getLatestVersionFileUrl(Vehicle* vehicle) override;
};
