#include "CustomFirmwarePlugin.h"
#include "CustomAutoPilotPlugin.h"

#include "ArduCopterFirmwarePlugin.h"
#include "ArduPlaneFirmwarePlugin.h"
#include "CustomArduSubFirmwarePlugin.h"
#include "CustomArduRoverFirmwarePlugin.h"

#include <iostream>

CustomFirmwarePlugin::CustomFirmwarePlugin() : APMFirmwarePlugin() {}

AutoPilotPlugin* CustomFirmwarePlugin::autopilotPlugin(Vehicle* vehicle)
{
  return new CustomAutoPilotPlugin(vehicle, vehicle);
}

QString CustomFirmwarePlugin::_getLatestVersionFileUrl(Vehicle* vehicle)
{
  const static QString baseUrl(
      "http://firmware.ardupilot.org/%1/stable/PX4/git-version.txt");

  if (qobject_cast<ArduPlaneFirmwarePlugin*>(vehicle->firmwarePlugin()))
  {
    return baseUrl.arg("Plane");
  }
  else if (qobject_cast<CustomArduRoverFirmwarePlugin*>(
               vehicle->firmwarePlugin()))
  {
    return baseUrl.arg("Rover");
  }
  else if (qobject_cast<CustomArduSubFirmwarePlugin*>(vehicle->firmwarePlugin()))
  {
    return baseUrl.arg("Sub");
  }
  else if (qobject_cast<ArduCopterFirmwarePlugin*>(vehicle->firmwarePlugin()))
  {
    return baseUrl.arg("Copter");
  }
  else
  {
    qWarning() << "APMFirmwarePlugin::_getLatestVersionFileUrl Unknown vehicle "
                  "firmware type"
               << vehicle->vehicleType();
    return QString();
  }
}
