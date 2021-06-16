message("Adding Custom Plugin")

#   Major and minor versions are defined here (manually)
CUSTOM_QGC_VERSION = 0.0.1
message(VIAM-AUV-GC Version: $${CUSTOM_QGC_VERSION})
DEFINES -= GIT_VERSION=\"\\\"$$GIT_VERSION\\\"\"
DEFINES += GIT_VERSION=\"\\\"$$CUSTOM_QGC_VERSION\\\"\"

# Build a custom APM flight stack by disabling PX4 support
CONFIG  += QGC_DISABLE_PX4_PLUGIN QGC_DISABLE_PX4_PLUGIN_FACTORY
CONFIG  += QGC_DISABLE_APM_PLUGIN_FACTORY

# Disable support for other stuffs
CONFIG  += QGC_DISABLE_BLUETOOTH
CONFIG  += QGC_DISABLE_NFC QGC_DISABLE_QTNFC QGC_DISABLE_QTNFC

# Branding
DEFINES += CUSTOMHEADER=\"\\\"CustomPlugin.h\\\"\"
DEFINES += CUSTOMCLASS=CustomPlugin

TARGET   = CustomQGC
DEFINES += QGC_APPLICATION_NAME=\"\\\"VIAM-AUV-GC\\\"\"

DEFINES += QGC_ORG_NAME=\"\\\"viamlab.com\\\"\"
DEFINES += QGC_ORG_DOMAIN=\"\\\"viamlab.com\\\"\"

QGC_APP_NAME        = "VIAM-AUV-GC"
QGC_BINARY_NAME     = "VIAM-AUV-GC"
QGC_ORG_NAME        = "ViamLab"
QGC_ORG_DOMAIN      = "viamlab.com"
QGC_APP_DESCRIPTION = "ViamLab QGC Ground Station"
QGC_APP_COPYRIGHT   = "Copyright (C) 2020 ViamLab Development Team. All rights reserved."

# Include headers and sources
INCLUDEPATH += \
    $$PWD/src \

HEADERS += \
    $$PWD/src/CustomPlugin.h \
    $$PWD/src/apmcontrolcomponent.h

SOURCES += \
    $$PWD/src/CustomPlugin.cc \
    $$PWD/src/apmcontrolcomponent.cpp

# Custom Firmware/AutoPilot Plugin
INCLUDEPATH += \
    $$QGCROOT/custom/src/FirmwarePlugin \
    $$QGCROOT/custom/src/AutoPilotPlugin

HEADERS+= \
    $$QGCROOT/custom/src/AutoPilotPlugin/CustomAutoPilotPlugin.h \
    $$QGCROOT/custom/src/FirmwarePlugin/CustomFirmwarePlugin.h \
    $$QGCROOT/custom/src/FirmwarePlugin/CustomArduRoverFirmwarePlugin.h \
    $$QGCROOT/custom/src/FirmwarePlugin/CustomArduSubFirmwarePlugin.h \
    $$QGCROOT/custom/src/FirmwarePlugin/CustomFirmwarePluginFactory.h

SOURCES += \
    $$QGCROOT/custom/src/AutoPilotPlugin/CustomAutoPilotPlugin.cc \
    $$QGCROOT/custom/src/FirmwarePlugin/CustomFirmwarePlugin.cc \
    $$QGCROOT/custom/src/FirmwarePlugin/CustomArduRoverFirmwarePlugin.cc \
    $$QGCROOT/custom/src/FirmwarePlugin/CustomArduSubFirmwarePlugin.cc \
    $$QGCROOT/custom/src/FirmwarePlugin/CustomFirmwarePluginFactory.cc

RESOURCES += \
    $$PWD/custom.qrc
