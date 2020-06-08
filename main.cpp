#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlComponent>
#include "cpplistelement.h"
#include "cpplistmodel.h"
#include <memory>

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
    std::unique_ptr<CPPListModel> rootModel(new CPPListModel()); // список корневых узлов
    auto * root1 = rootModel->addSubItem("Root1");
    auto * a1 = root1->getSubItems()->addSubItem("A1");
    a1->getSubItems()->addSubItem("B1");
    a1->getSubItems()->addSubItem("C1")->getSubItems()->addSubItem("D1");
    auto * root2 = rootModel->addSubItem("Root2");
    root2->getSubItems()->addSubItem("B2")->getSubItems()->addSubItem("C2");
    rootModel->addSubItem("Root3");
    engine.rootContext()->setContextProperty("treeModel", rootModel.get());
    engine.load(url);
    return app.exec();
}
