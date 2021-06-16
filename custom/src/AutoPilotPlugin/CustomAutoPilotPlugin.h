#pragma once

#include "APMAutoPilotPlugin.h"
#include "Vehicle.h"

class CustomAutoPilotPlugin : public APMAutoPilotPlugin
{
  Q_OBJECT
public:
  CustomAutoPilotPlugin(Vehicle* vehicle, QObject* parent = nullptr);
};
