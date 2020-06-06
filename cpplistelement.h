#ifndef CPPLISTELEMENT_H
#define CPPLISTELEMENT_H

#include <QObject>
#include <QString>
#include <QObjectList>
#include <qqml.h>
#include <QQmlTypeInfo>

class CPPListModel;
class CPPListElement : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString itemName READ getItemName WRITE setItemName NOTIFY itemNameChanged)
    Q_PROPERTY(bool expanded READ getExpanded WRITE setExpanded NOTIFY expandedChanged)
    Q_PROPERTY(CPPListModel * subItems READ getSubItems CONSTANT)
    //QML_ELEMENT - fuck!

public:
    explicit CPPListElement(QObject *parent = nullptr);
    QString getItemName() const;
    void setItemName(const QString & name);
    bool getExpanded() const;
    void setExpanded(bool b);
    CPPListModel * getSubItems();
signals:
    void itemNameChanged();
    void expandedChanged();
    void subItemsChanged();
public slots:
    private:
    QString m_itemName;
    bool m_expanded;
    CPPListModel * m_subItems;
};

#endif // CPPLISTELEMENT_H
