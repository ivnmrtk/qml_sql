#ifndef CDATABASE_H
#define CDATABASE_H

#include <QObject>
#include <qsqldatabase.h>
#include <QSqlQuery>
#include <QVariant>
#include <QDebug>
#include <QSqlError>

class CDataBase : public QObject
{
    Q_OBJECT
    //База данных
    QSqlDatabase fDB;
    //Имя БД
    QString fDBName;
    //Указатель на запрос, через который просматриваем БД
    QSqlQuery *fSelQuery;
    //Текущая позиция в БД
    int fPos;
    //Метод для подсчета записей в БД
    int Count();
    //Метод для подсчета записей в запросе, в качестве параметра
    //  передается ссылка на запрос
    int Calc(QSqlQuery &Query);
    //Метод для проверки уникальности идентификатора, в качестве
    //  параметра передается идентификатор, если такой есть в БД
    // тогда метод возвращает true, если нет, тогда false
    bool CheckID(int Id);
    //Метод, обновляющий свойства класса, в качестве параметра
    //  передается позиция записи в БД
    void Refresh(int Pos);

public:
    explicit CDataBase(QObject *parent = nullptr);
    //Деструктор
    ~CDataBase();
    //Свойство, хранящее имя БД. Свойство на запись можно использовать
    //  только один раз
    Q_PROPERTY(QString dataBaseName READ dataBaseName
      WRITE setDataBaseName NOTIFY dataBaseNameChanged)
    //Метод-чтения, возвращающий значение свойства
    QString dataBaseName();
    //Метод-записи, устанавливающий значение свойства и открывающий БД
    void setDataBaseName(QString dataBaseName);
    //Свойство для отображения поля id текущей записи.
    //  Свойство только на чтение
    Q_PROPERTY(int recId READ recId NOTIFY recIdChanged)
    //Метод-чтения
    int recId();
    //Свойство для отображения поля recFIO текущей записи.
    //  Свойство только на чтение
    Q_PROPERTY(QString recTitle READ recTitle NOTIFY recTitleChanged)
    //Метод-чтения
    QString recTitle();
    //Свойство для отображения поля recTel текущей записи.
    //  Свойство только на чтение
    Q_PROPERTY(QString recAuthor READ recAuthor NOTIFY recAuthorChanged)
    //Метод-чтения
    QString recAuthor();
    //Свойство для отображения поля recAdr текущей записи.
    //  Свойство только на чтение
    Q_PROPERTY(QString recPublisher READ recPublisher NOTIFY recPublisherChanged)
    //Метод-чтения
    QString recPublisher();
    //Метод для добавления новой записи в БД, в качестве параметров
    //  передаются значения полей: id, fio, tel и adr после добавления
    //  текущей становится добавленная запись
    Q_INVOKABLE void add(int Id, QString recTitle, QString recAuthor, QString recPublisher);
    //Метод для изменения значения текущей записи, в качестве параметров
    //  передаются значения полей: fio, tel и adr,
    Q_INVOKABLE void set(QString recTitle, QString recAuthor, QString recPublisher);
    //Метод для удаления текущей записи. После удаления текущей
    //  становится следующая запись, если удалялась последняя запись,
    //  тогда текущей становится предыдущая запись
    Q_INVOKABLE void del();
    //Метод для перехода на предыдущую запись, если текущая запись была
    //  первой, то переходит на последнюю
    Q_INVOKABLE void prev();
    //Метод для перехода на следующую запись, если текущая запись была
    //  последней, то переходит на первую
    Q_INVOKABLE void next();

  signals:
    //Сигнал, возникающий при изменении значения свойства dataBaseName
    void dataBaseNameChanged(QString DBName);
    //Сигнал, возникающий при изменении значения свойства recId
    void recIdChanged(int Id);
    //Сигнал, возникающий при изменении значения свойства recFIO
    void recTitleChanged(QString title);
    //Сигнал, возникающий при изменении значения свойства recTel
    void recAuthorChanged(QString author);
    //Сигнал, возникающий при изменении значения свойства recAdr
    void recPublisherChanged(QString publisher);
  public slots:
  };


#endif // CDATABASE_H
