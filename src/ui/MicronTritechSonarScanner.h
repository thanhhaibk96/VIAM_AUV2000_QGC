#ifndef MICRONTRITECHSONARSCANNER_H
#define MICRONTRITECHSONARSCANNER_H

#include <QWidget>
#include <QMap>
#include <QTimer>
#include <QDebug>
#include <QImage>
#include <QPixmap>
#include <QPainter>
#include <QColor>
#include <QNetworkAccessManager>
#include <QUrl>
#include <QBuffer>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QObject>

#include "QGCDockWidget.h"
#include "MAVLinkProtocol.h"
#include "Vehicle.h"

namespace Ui {
class MicronTritechSonarScanner;
}

class QTreeWidgetItem;
class UASInterface;

class MicronTritechSonarScanner : public QGCDockWidget
{
    Q_OBJECT

public:
    explicit MicronTritechSonarScanner(const QString& title, QAction* action, MAVLinkProtocol* protocol, QWidget *parent = 0);
    ~MicronTritechSonarScanner();
    QNetworkAccessManager* networkSonar;

public slots:
    void finishedSlot(QNetworkReply* reply);
    void captureImgSonar();

protected:
    MAVLinkProtocol *_protocol;     ///< MAVLink instance
    int selectedSystemID;          ///< Currently selected system
    int selectedComponentID;       ///< Currently selected component

private slots:
    void on_btnConnect_clicked();

private:
    Ui::MicronTritechSonarScanner *ui;
//    QImage *imgSonar = nullptr;
//    QUrl urlSonar;
//    QNetworkRequest request;

//    QThread* threadCaptureImg;
//    QTimer* timerCaptureImg;

};

#endif // MICRONTRITECHSONARSCANNER_H
