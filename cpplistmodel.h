#ifndef CPPLISTMODEL_H
#define CPPLISTMODEL_H

#include "cpplistelement.h"
#include <QObject>
#include <QAbstractListModel>
#include <QList>

class CPPListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ItemRoles {
         NameRole = Qt::UserRole + 1,
         ExpandedRole
     };
    CPPListModel(QObject * parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int,QByteArray> roleNames() const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    CPPListElement * addSubItem(const QString & itemName);
    //CPPListElement * get(const QModelIndex & index);
    //void setProperty(const QModelIndex & index, const QString & name, const QVariant &value);
private:
    QList<CPPListElement*> m_elements;
};

#endif // CPPLISTMODEL_H
