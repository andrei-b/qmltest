#include "cpplistelement.h"

CPPListElement::CPPListElement(QObject *parent) : QObject(parent)
{

}

QString CPPListElement::getItemName()
{
    return m_itemName;
}

QString CPPListElement::setItemName(const QString &name)
{
    m_itemName = name;
}
