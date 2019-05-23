import QtQuick 2.12
import QtQuick.Window 2.12
//Подключаем библиотеку с компоновщиками
import QtQuick.Layouts 1.1
//Подключаем библиотеку с элементами управления
import QtQuick.Controls 1.4
//Подключаем библиотеку с диалоговыми окнами
import QtQuick.Dialogs 1.2
//Подключаем библиотеку с нашим классом для работы с БД
import Sab.DataBase 1.0
//Основное окно программы


Window {
    visible: true
    width: 400
      //Свойство, через которое получаем состояние диалогового окна
      //  Добавления или Редактирования записи, свойство может принимать
      //  следующие значения:
      //  0 - диалоговое окно отображается в текущий момент
      //  -1 - диалоговое окно закрыто нажатием на кнопку Cancel
      //  1 - диалоговое окно закрыто нажатием на кнопку Ok при
      //    добавление записи
      //  2 - диалоговое окно закрыто нажатием на кнопку Ok при
      //    редактировании записи
      //  свойство связываем с аналогичным диалогового окна dlgAddEdit
      property int stateDlg: dlgAddEdit.stateDlg
      //Объявляем элемент для работы с БД
      DataBase {
        //Определяем идентификатор
        id: dataBase
        //Задаем имя БД
        dataBaseName: "C:/SQLight/mybd.db"
      }
      //Объявляем табличный компоновщик
      GridLayout {
        //  размером в 6 строк и 2 столбца
        rows: 6; columns: 2;
        //Определяем метку
        Text {
          // в ячейке 1, 1
          Layout.row: 1; Layout.column: 1
          //Задаем текст метки
          text: "id:"
        }
        //Определяем прямоугольник
        Rectangle {
          //  в ячейке 1, 2
          Layout.row: 1; Layout.column: 2
          //Задаем размеры прямоугольника
          width: 300; height: 20
          //Задаем цвет прямоугольника
          color: "grey"
          //Помещаем в прямоугольник метку, в которой будет отображаться
          //  информация из поля id текущей записи
          Text {
            //Выравниваем метку по вертикали относительно центра
            //  прямоугольника
            anchors.verticalCenter: parent.verticalCenter
            //Связываем свойство text метки со свойством recId элемента
            //  dataBase, через который получаем данные из БД
            text: dataBase.recId
          }
        }
        //Далее, по аналогии описываем другие элементы для вывода
        //  информации из текущей записи БД
        Text {
          Layout.row: 2; Layout.column: 1
          text: "ФИО:"
        }
        Rectangle {
          Layout.row: 2; Layout.column: 2
          width: 300; height: 20
          color: "grey"
          Text {
            anchors.verticalCenter: parent.verticalCenter
            text: dataBase.recFIO
          }
        }
        Text {
          Layout.row: 3; Layout.column: 1
          text: "Телефон:"
        }
        Rectangle {
          Layout.row: 3; Layout.column: 2
          width: 300; height: 20
          color: "grey"
          Text {
            anchors.verticalCenter: parent.verticalCenter
            text: dataBase.recTel
          }
        }
        Text {
          Layout.row: 4; Layout.column: 1
          text: "Адрес:"
        }
        Rectangle {
          Layout.row: 4; Layout.column: 2
          width: 300; height: 20
          color: "grey"
          Text {
            anchors.verticalCenter: parent.verticalCenter
            text: dataBase.recAdr
          }
        }
        //Описываем кнопку "<" для перемещения к предыдущей записи
        Button {
          //  в ячейке 5, 1
          Layout.row: 5; Layout.column: 1
          //Устанавливаем надпись на кнопку
          text: "<"
          //Описываем обработчик сигнала clicked()
          onClicked: {
            //Вызываем метод prev() элемента dataBase, который выполняет
            //  перемещение к предыдущей записи
            dataBase.prev()
          }
        }
        //Описываем кнопку ">" для перемещения к следующей записи
        Button {
          //  в ячейке 5, 2
          Layout.row: 5; Layout.column: 2
          text: ">"
          onClicked: {
            //Вызываем метод next() элемента dataBase, который выполняем
            //  перемещение к следующей записи
            dataBase.next()
          }
        }
        //Описываем компоновщик для размещения оставшихся кнопок
        //  в одну строку
        Row {
          //Компоновщик помещаем в ячейку 6,1
          Layout.row: 6; Layout.column: 1
          //  и он будет захватывать две ячейки
          Layout.columnSpan: 2
          //Описываем кнопку "Добавить" для добавления новой записи
          Button {
            text: "Добавить"
            onClicked: {
              //Вызываем диалоговое окно, в которое будут вводиться
              //  данные новой записи
              dlgAddEdit.add()
            }
          }
          //Описываем кнопку "Редактировать" для редактирования
          //  текущей записи
          Button {
            text: "Редактировать"
            onClicked: {
              //Вызываем диалоговое окно, в котором будет редактироваться
              //  текущая запись, в метод edit передаем данные текущей
              //  записи, полученные через элемент dtatBase
              dlgAddEdit.edit(dataBase.recId, dataBase.recFIO,
                dataBase.recTel, dataBase.recAdr)
            }
          }
          //Описываем кнопку "Удалить" для удаления текущей записи
          Button {
            text: "Удалить"
            onClicked: {
              //Вызываем метод del() элемента dataBase, который выполняет
              //  удаление текущей записи
              dataBase.del();
            }
          }
        }
      }
      //Описываем обработчик сигнала, возникающего при изменении свойства
      //  stateDlg. Это делается по той причине, что при вызове
      //  диалогового окна не происходит остановка программы до тех пор
      //  пока окно не закроется, поэтому состояние окна отслеживаем
      //  через специальное свойство
      onStateDlgChanged: {
        //Если свойство имеет значение 1
        if (stateDlg === 1)
          //  значит окно закрылось нажатием на кнопку "Ok"
          //  и было в режиме добавления
          //Добавляем новую запись вызовом метода add() элемента dataBase,
          //  в метод передаем данные из соответствующих свойств
          //  диалогового окна dlgAddEdit
          dataBase.add(dlgAddEdit.recId, dlgAddEdit.recFIO,
            dlgAddEdit.recTel, dlgAddEdit.recAdr)
          //Если свойство имеет значение 2
        if (stateDlg === 2)
          //  значит окно закрылось нажатием на кнопку "Ok" и было в
          //  режиме редактирования
          //Редактируем текущую запись вызовом метода set()
          //  элемента dataBase
          dataBase.set(dlgAddEdit.recFIO, dlgAddEdit.recTel,
            dlgAddEdit.recAdr)
      }
      //Описываем диалоговое окно Добавления/Редактирования записи. Окно
      //  может открываться в одном из двух режимов: Добавления - в этом
      //  случае полях ввода пустые и есть возможность ввода
      //  идентификатора, Редактирования - в полях ввода отображаются
      //  данные текущей записи, поле идентификатора заблокировано
      Dialog {
        //Определяем идентификатор окна
        id: dlgAddEdit
        //Определяем ширину окна
        width: 200
        //Описываем свойства, через которые передаем информацию из окна
        property int recId: -1
        property string recFIO: ""
        property string recTel: ""
        property string recAdr: ""
        //Описываем свойство, хранящее состояние окна
        property int stateDlg: 0
        //Описываем вспомогательное свойство
        property int st
        //Описываем функцию add(), которая открывает окно
        //  в режиме добавления
        function add() {
          //Меняем заголовок окна
          title = "Добавление"
          //Разблокируем поле ввода tfId для ввода идентификатора
          tfId.enabled = true
          //Очищаем поля ввода
          tfId.text = ""
          tfFIO.text = ""
          tfTel.text = ""
          tfAdr.text = ""
          //Открываем диалоговое окно
          this.open()
          //Задаем состояние окна - открытое
          stateDlg = 0
          //Указываем, что окно открыто в режиме добавления
          st = 1
        }
        //Описываем функцию edit(), которая открывает окно в режиме
        //  редактирования, в функцию передаются данные текущей записи
        function edit(num, fio, tel, adr) {
          //Меняем заголовок окна
          title = "Редактирование"
          //Блокируем поле ввода tfId, т.к. идентификатор изменять нельзя
          tfId.enabled = false
          //Остальным полям ввода присваиваем данные текущей записи
          tfId.text = num
          tfFIO.text = fio
          tfTel.text = tel
          tfAdr.text = adr
          //Открываем диалоговое окно
          this.open()
          //Задаем состояние окна - открытое
          stateDlg = 0
          //Указываем, что окно открыто в режиме редактирования
          st = 2
        }
        //Описываем кнопки, отображаемые в окне Ok и Cancel
        standardButtons: StandardButton.Ok | StandardButton.Cancel
        //В диалоговом окне размещаем табличный компоновщик
        GridLayout {
          //  размером в 4 строки и 2 столбца
          rows: 4; columns: 2;
          //Определяем метку
          Text {
            // в ячейке 1, 1
            Layout.row: 1; Layout.column: 1
            //Задаем текст метки
            text: "id:"
          }
          //Описываем поле ввода
          TextField {
            // в ячейке 1, 2
            Layout.row: 1; Layout.column: 2
            //Определяем идентификатор поля
            id: tfId
            //Описываем замещающий текст
            placeholderText: "Введите id"
          }
          //Далее, по аналогии описываем другие элементы для
          //  ввода информации
          Text {
            Layout.row: 2; Layout.column: 1
            text: "ФИО:"
          }
          TextField {
            id: tfFIO
            Layout.row: 2; Layout.column: 2
            placeholderText: "Введите ФИО"
          }
          Text {
            Layout.row: 3; Layout.column: 1
            text: "Телефон:"
          }
          TextField {
            id: tfTel
            Layout.row: 3; Layout.column: 2
            placeholderText: "Введите телефон"
          }
          Text {
            Layout.row: 4; Layout.column: 1
            text: "Адрес:"
          }
          TextField {
            id: tfAdr
            Layout.row: 4; Layout.column: 2
            placeholderText: "Введите адрес"
          }
        }
        //Описываем обработчик сигнала accepted(), возникающего
        //  при нажатии на кнопку Ok
        onAccepted: {
          //Передаем значения полей ввода в соответствующие свойства
          //  диалогового окна
          recId = Number(tfId.text)
          recFIO = tfFIO.text
          recTel = tfTel.text
          recAdr = tfAdr.text
          //Передаем в свойство stateDlg состояние окна:
          //  1 – добавление или 2 - редактирование
          stateDlg = st
        }
        //Описываем обработчик сигнала rejected(), возникающего
        //  при нажатии на кнопку Cancel
        onRejected: {
          //Передаем в свойство stateDlg состояние окна:
          //  -1 - закрыто нажатием на кнопку Cancel
          stateDlg = -1
        }
      }
    }
