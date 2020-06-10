#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "src/device.h"
#include "src/client.h"

int main(int argc, char *argv[])
{
    qmlRegisterType<Device>("harbour.koronako.koronascan", 1, 0, "Koronascan");
    qmlRegisterType<Client>("harbour.koronako.koronaclient", 1, 0, "Koronaclient");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
