#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlComponent>
#include "cpplistelement.h"
#include "cpplistmodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<CPPListElement>("CPPListElement", 1, 0,
                                                "CPPListElement");
    qmlRegisterType<CPPListModel>("CPPListModel", 1, 0,
                                                "CPPListModel");
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    auto * rootModel = new CPPListModel(); // содержит список корневых узлов
    auto * root1 = rootModel->addSubItem("Root1");
    auto * a1 = root1->getSubItems()->addSubItem("A1");
    a1->getSubItems()->addSubItem("DD");
    a1->getSubItems()->addSubItem("DCD")->getSubItems()->addSubItem("Cccdc");
    engine.rootContext()->setContextProperty("treeModel", rootModel);
    engine.load(url);

    return app.exec();
}
