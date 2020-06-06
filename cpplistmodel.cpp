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
      return QVariant();
}

QHash<int, QByteArray> CPPListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "itemName";
    roles[ExpandedRole] = "expanded";
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

/*CPPListElement *CPPListModel::get(const QModelIndex &index)
{
    if (index.row() < 0 || index.row() > m_elements.count())
          return nullptr;
    return m_elements[index.row()];
}

void CPPListModel::setProperty(const QModelIndex &index, const QString &name, const QVariant &value)
{
    if (index.row() < 0 || index.row() > m_elements.count())
          return;
    m_elements[index.row()]->setProperty(name.toLocal8Bit(), value);
}*/
