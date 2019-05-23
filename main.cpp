#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <cdatabase.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    //Регистрируем в QML описанный выше класс CDataBase под именем
    //  DataBase
    qmlRegisterType<CDataBase>("Sab.DataBase", 1, 0, "DataBase");


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
