#ifndef BOOKS_H
#define BOOKS_H

#include <qstring.h>


class books
{
private:
    int recId;
    QString recTitle;
    QString recAuthor;
    QString recYear;
    QString dataBaseName;
public:
    books();
    void add(int _id, QString _recTitle, QString _recAuthor, QString _recYear);
    void set(QString _recTitle, QString _recAuthor, QString _recYear);
    void del();
    void prev();
    void next();
};

#endif // BOOKS_H
