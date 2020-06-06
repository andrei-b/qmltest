#include "cpplistelement.h"
#include "cpplistmodel.h"

CPPListElement::CPPListElement(QObject *parent) : QObject(parent), m_expanded(true), m_subItems(new CPPListModel(this))
{

}


QString CPPListElement::getItemName() const
{
    return m_itemName;
}

void CPPListElement::setItemName(const QString &name)
{
    m_itemName = name;
    emit itemNameChanged();
}

bool CPPListElement::getExpanded() const
{
    return m_expanded;
}

void CPPListElement::setExpanded(bool b)
{
    m_expanded = b;
    emit expandedChanged();
}

CPPListModel * CPPListElement::getSubItems()
{
    return m_subItems;
}
