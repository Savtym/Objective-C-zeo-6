# Objective-C-zeo-6

exercise 5

1. Создаём новый проект Cocoa Application.
2. В xib-е MainWindow отключаем Autolayout.
3. Главное окно должно иметь такой вид:
￼
В окне есть чат. У чата два участника - Алиса и Боб. Для каждого из участников есть своё поле для ввода (NSTextField) нового сообщения, своя кнопка "Submit". Ещё есть большое нередактируемое поле (NSTextView), где отображается история переписки.
4. Каждое сообщение должно отображаться в формате: "hh:mm:ss [nickname]:".
5. При закрытии окна, должна завершаться работа приложения.

exercise 6
1. Копируем проект из задания Exeresice5.
2. Выделяем сущность ModelController:
	- Сущность ответственна за хранение модели;
	- Интерфейс должен предоставлять инструменты для добавления сообщения, просмотра существующих сообщений, сохранения модели в файл, восстановления модели из файла.
3. Выделяем сущность ViewControler:
	- Сущность ответственна за отображение, представление UI для редактирования;
	- ViewController дложен "знать" о "ModelController"-e, изменять его данные (добавлять сообщения)
4. В пользовательский интерфейс добавляем два checkbox-a:
	- "Discard Style", активированный checkbox изменяет отображение чата. При отображении игнорируются настройки цвета сообщений, всё отображается черным.
	- "Show Date", деактивированный checkbox изменяет отображение чата. Не отображаются даты сообщения.
5. Основной объект приложения должен инизиализировать ModelController, ViewControler, встраивать view из ViewController в окно.
