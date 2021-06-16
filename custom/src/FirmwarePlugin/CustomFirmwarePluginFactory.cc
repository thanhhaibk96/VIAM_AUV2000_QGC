#include "CustomFirmwarePluginFactory.h"
#include "ArduCopterFirmwarePlugin.h"
#include "ArduPlaneFirmwarePlugin.h"
#include "CustomArduSubFirmwarePlugin.h"
#include "CustomArduRoverFirmwarePlugin.h"

CustomFirmwarePluginFactory CustomFirmwarePluginFactory;

CustomFirmwarePluginFactory::CustomFirmwarePluginFactory(void)
    : _arduCopterPluginInstance(nullptr), _arduPlanePluginInstance(nullptr),
      _arduRoverPluginInstance(nullptr), _arduSubPluginInstance(nullptr)
{
}

QList<MAV_AUTOPILOT>
CustomFirmwarePluginFactory::supportedFirmwareTypes(void) const
{
  QList<MAV_AUTOPILOT> list;

  list.append(MAV_AUTOPILOT_ARDUPILOTMEGA);
  return list;
}

FirmwarePlugin* CustomFirmwarePluginFactory::firmwarePluginForAutopilot(
    MAV_AUTOPILOT autopilotType, MAV_TYPE vehicleType)
{
  if (autopilotType == MAV_AUTOPILOT_ARDUPILOTMEGA)
  {
    switch (vehicleType)
    {
    case MAV_TYPE_QUADROTOR:
    case MAV_TYPE_HEXAROTOR:
    case MAV_TYPE_OCTOROTOR:
    case MAV_TYPE_TRICOPTER:
    case MAV_TYPE_COAXIAL:
    case MAV_TYPE_HELICOPTER:
      if (!_arduCopterPluginInstance)
      {
        _arduCopterPluginInstance = new ArduCopterFirmwarePlugin;
      }
      return _arduCopterPluginInstance;
    case MAV_TYPE_VTOL_DUOROTOR:
    case MAV_TYPE_VTOL_QUADROTOR:
    case MAV_TYPE_VTOL_TILTROTOR:
    case MAV_TYPE_VTOL_RESERVED2:
    case MAV_TYPE_VTOL_RESERVED3:
    case MAV_TYPE_VTOL_RESERVED4:
    case MAV_TYPE_VTOL_RESERVED5:
    case MAV_TYPE_FIXED_WING:
      if (!_arduPlanePluginInstance)
      {
        _arduPlanePluginInstance = new ArduPlaneFirmwarePlugin;
      }
      return _arduPlanePluginInstance;
    case MAV_TYPE_GROUND_ROVER:
    case MAV_TYPE_SURFACE_BOAT:
      if (!_arduRoverPluginInstance)
      {
        _arduRoverPluginInstance = new CustomArduRoverFirmwarePlugin;
      }
      return _arduRoverPluginInstance;
    case MAV_TYPE_SUBMARINE:
      if (!_arduSubPluginInstance)
      {
        _arduSubPluginInstance = new CustomArduSubFirmwarePlugin;
      }
      return _arduSubPluginInstance;
    default:
      break;
    }
  }

  return nullptr;
}
