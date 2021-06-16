#ifndef APMCONTROLCOMPONENT_H
#define APMCONTROLCOMPONENT_H

#include <QObject>
#include "VehicleComponent.h"

class APMControlComponent : public VehicleComponent
{
    Q_OBJECT

public:
    APMControlComponent(Vehicle* vehicle, AutoPilotPlugin* autopilot, QObject* parent = NULL);

    // Virtuals from VehicleComponent
    QStringList setupCompleteChangedTriggerList(void) const final;

    // Virtuals from VehicleComponent
    QString name(void) const final;
    QString description(void) const final;
    QString iconResource(void) const final;
    bool requiresSetup(void) const final;
    bool setupComplete(void) const final;
    QUrl setupSource(void) const final;
    QUrl summaryQmlSource(void) const final;
    bool allowSetupWhileArmed(void) const final { return true; }

private:
    const QString   _name;
    QVariantList    _summaryItems;
};


#endif // APMCONTROLCOMPONENT_H
