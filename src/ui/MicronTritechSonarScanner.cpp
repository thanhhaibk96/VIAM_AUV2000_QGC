#include "MicronTritechSonarScanner.h"
#include "ui_MicronTritechSonarScanner.h"

QImage *imgSonar = nullptr;
QUrl urlSonar;
QNetworkRequest request;

QThread* threadCaptureImg;
QTimer* timerCaptureImg;

MicronTritechSonarScanner::MicronTritechSonarScanner(const QString& title, QAction* action, MAVLinkProtocol* protocol, QWidget *parent) :
    QGCDockWidget(title, action, parent),
    _protocol(protocol),
    selectedSystemID(0),
    selectedComponentID(0),
    ui(new Ui::MicronTritechSonarScanner)
{
    ui->setupUi(this);
    networkSonar = new QNetworkAccessManager(this);
    connect(networkSonar, SIGNAL(finished(QNetworkReply*)), this, SLOT(finishedSlot(QNetworkReply*)));

    threadCaptureImg = new QThread(this);
    timerCaptureImg = new QTimer(0);
    timerCaptureImg->setInterval(100);
    timerCaptureImg->moveToThread(threadCaptureImg);

    QObject::connect(threadCaptureImg, SIGNAL(started()), timerCaptureImg, SLOT(start()));
    QObject::connect(threadCaptureImg, SIGNAL(finished()), timerCaptureImg, SLOT(stop()));
    QObject::connect(timerCaptureImg, SIGNAL(timeout()), SLOT(captureImgSonar()), Qt::DirectConnection);
}

MicronTritechSonarScanner::~MicronTritechSonarScanner()
{
    delete ui;
}

void MicronTritechSonarScanner::finishedSlot(QNetworkReply *reply)
{
    if (reply->error() == QNetworkReply::NoError)
       {
           int _w = ui->imageSonar->width();
           int _h = ui->imageSonar->height();
           int _scalesize = 0;
           if(_w >=_h) _scalesize = _h;
           else _scalesize = _w;

           // read data from QNetworkReply here
           QByteArray bytes = reply->readAll();  // bytes
           if(bytes.length() != 0)
           {
               QPixmap pixmap;
               pixmap.loadFromData(bytes);
               ui->imageSonar->setPixmap(pixmap.scaled(_scalesize, _scalesize, Qt::KeepAspectRatio));
           }
           else
           {
                ui->imageSonar->setText("No Signal....");
           }
    }
}

void MicronTritechSonarScanner::captureImgSonar()
{
//    qDebug() << "Timer is running" << endl;
    try {
        request.setUrl(urlSonar);
        networkSonar->get(request);
    } catch (...) {
    }

}

void MicronTritechSonarScanner::on_btnConnect_clicked()
{
    urlSonar = QUrl(ui->txtHTTPLink->text());

    if (ui->btnConnect->text() == "Connect") {
//        timerCaptureImg->start();
        threadCaptureImg->start();
        ui->btnConnect->setText("Disconnect");
    }
    else
    {
//        timerCaptureImg->stop();
        threadCaptureImg->terminate();
        ui->btnConnect->setText("Connect");
    }
}
