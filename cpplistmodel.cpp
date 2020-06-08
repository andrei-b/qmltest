#include "cpplistmodel.h"

CPPListModel::CPPListModel(QObject *parent) : QAbstractListModel(parent)
{
}

int CPPListModel::rowCount(const QModelIndex &parent) const
{
    return m_elements.count();
}

QVariant CPPListModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() > m_elements.count())
          return QVariant();
      auto &element = m_elements[index.row()];
      if (role == NameRole)
          return element->getItemName();
      else if (role == ExpandedRole)
          return element->getExpanded();
      else if (role == ExpandedRole)
      {
          QObjectList l;
          for (auto * item : m_elements)
              l.append(item);
          return QVariant::fromValue(l);
      }
      return QVariant();
}

QHash<int, QByteArray> CPPListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "itemName";
    roles[ExpandedRole] = "expanded";
    roles[SubItemsRole] = "subItems";
    return roles;
}

bool CPPListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (index.row() < 0 || index.row() > m_elements.count())
          return false;
    if (role == ExpandedRole)
    {
        m_elements[index.row()]->setExpanded(value.toBool());
    }
    return true;
}

CPPListElement *CPPListModel::addSubItem(const QString &itemName)
{
    auto * result = new CPPListElement(this);
    result->setItemName(itemName);
    m_elements.append(result);
    return result;
}

CPPListModel  *CPPListModel::subItems(int id)
{
    return m_elements[id]->getSubItems();
}

