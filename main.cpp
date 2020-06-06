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
    CPPListElement e1;
    CPPListElement e2;
    e1.setItemName("EE1");
    e2.setItemName("EE2");
    auto * e3 = e1.getSubItems()->addSubItem("EE3");
    auto * e4 = e1.getSubItems()->addSubItem("EE4");
    e4->getSubItems()->addSubItem("DD");
    e4->getSubItems()->addSubItem("DCD")->getSubItems()->addSubItem("Cccdc");
    auto * e5 = e2.getSubItems()->addSubItem("E5");
    QObjectList treeModel;
    treeModel << &e1 << &e2;
    engine.rootContext()->setContextProperty("treeModel", QVariant::fromValue(treeModel));
    engine.load(url);

    return app.exec();
}
