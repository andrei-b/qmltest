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
         ExpandedRole,
         SubItemsRole
     };
    CPPListModel(QObject * parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int,QByteArray> roleNames() const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    //  добавить узел
    CPPListElement * addSubItem(const QString & itemName);
    // subItems(int id) врзвращает дочерние узлы узла id (0..rowCount()-1) для построения дерева (не смог сделать этот через data())
    Q_INVOKABLE CPPListModel *subItems(int id);
    Q_INVOKABLE CPPListElement *item(int id);
private:
    QList<CPPListElement*> m_elements;
};

#endif // CPPLISTMODEL_H
