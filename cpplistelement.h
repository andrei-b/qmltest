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
    Q_PROPERTY(bool expanded READ getExpanded WRITE setExpanded)
    Q_PROPERTY(QObjectList * subItems READ getSubItems WRITE setSubItems)
    //QML_ELEMENT - fuck!

public:
    explicit CPPListElement(QObject *parent = nullptr);
    QString getItemName();
    void setItemName(const QString & name);
    bool getExpanded();
    void setExpanded(bool b);
    QObjectList * getSubItems();
    void setSubItems(QObjectList * l);
signals:

public slots:
    private:
    QString m_itemName;
    bool m_expanded;
    QObjectList * m_subItems;
};

#endif // CPPLISTELEMENT_H
