#ifndef CPPLISTELEMENT_H
#define CPPLISTELEMENT_H

#include <QObject>
#include <QString>
#include <QObjectList>
#include <qqml.h>
#include <QQmlTypeInfo>

class CPPListElement : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString itemName READ getItemName WRITE setItemName)
    //QML_ELEMENT - fuck!

public:
    explicit CPPListElement(QObject *parent = nullptr);
    QString getItemName();
    QString setItemName(const QString & name);
signals:

public slots:
    private:
    QString m_itemName;
};

#endif // CPPLISTELEMENT_H
