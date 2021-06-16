#include "apmcontrolcomponent.h"
#include "ParameterManager.h"

APMControlComponent::APMControlComponent(Vehicle* vehicle, AutoPilotPlugin* autopilot, QObject* parent)
    : VehicleComponent(vehicle, autopilot, parent)
    , _name(tr("AUV Control"))
{
}

QString APMControlComponent::name(void) const
{
    return _name;
}

QString APMControlComponent::description(void) const
{
    return tr("Control characteristics of the Vehicle.");
}

QString APMControlComponent::iconResource(void) const
{
    return QStringLiteral("qrc:/qmlimages/src/AutoPilotPlugins/PX4/Images/auv_control.png");
}

bool APMControlComponent::requiresSetup(void) const
{
    return false;
}

bool APMControlComponent::setupComplete(void) const
{
    return true;
}

QStringList APMControlComponent::setupCompleteChangedTriggerList(void) const
{
    return QStringList();
}

QUrl APMControlComponent::setupSource(void) const
{
    QString qmlFile;
    switch (_vehicle->vehicleType()) {
//        case MAV_TYPE_QUADROTOR:
//        case MAV_TYPE_COAXIAL:
//        case MAV_TYPE_HELICOPTER:
//        case MAV_TYPE_HEXAROTOR:
//        case MAV_TYPE_OCTOROTOR:
//        case MAV_TYPE_TRICOPTER:
//            // Older firmwares do not have CH9_OPT, we don't support Tuning on older firmwares
//            if (_vehicle->parameterManager()->parameterExists(-1, QStringLiteral("CH9_OPT"))) {
//                qmlFile = QStringLiteral("qrc:/qml/APMTuningComponentCopter.qml");
//            }
//            break;
        case MAV_TYPE_SUBMARINE:
            qmlFile = QStringLiteral("qrc:/APMControlComponentSub.qml");
            break;
        default:
            // No tuning panel
            break;
    }
    return QUrl::fromUserInput(qmlFile);
}

QUrl APMControlComponent::summaryQmlSource(void) const
{
    return QUrl();
}
