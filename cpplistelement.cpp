#include "cpplistelement.h"

CPPListElement::CPPListElement(QObject *parent) : QObject(parent), m_expanded(false), m_subItems(nullptr)
{

}

QString CPPListElement::getItemName()
{
    return m_itemName;
}

void CPPListElement::setItemName(const QString &name)
{
    m_itemName = name;
}

bool CPPListElement::getExpanded()
{
    return m_expanded;
}

void CPPListElement::setExpanded(bool b)
{
    m_expanded = b;
}

QObjectList *CPPListElement::getSubItems()
{
    return m_subItems;
}

void CPPListElement::setSubItems(QObjectList *l)
{
    m_subItems = l;
}
