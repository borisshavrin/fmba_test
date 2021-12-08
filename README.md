<h1 align="center">FMBA Test</h1>

<p align="center">
  Task_1: Необходимо вывести самую популярную категорию товаров.
</p>  

### Для начала выполним конфигурацию Docker, где запустим БД PostgreSQL  
#### Первый способ:

> Перед созданием контейнера (назовем его pg-docker), проверим не занято ли это имя  

```
  docker container ls
```  
<p align="center">
  <img src="https://github.com/borisshavrin/fmba_test/blob/master/img/docker%20container%20ls.png">
</p>  

> Видим, что контейнер с этим именем уже запущен. Так же, зная, что данный контейнер не используется, остановим и удалим его  
```
docker stop pg-docker
docker rm pg-docker
```

После успешной операции командная строка вернет имя освободившегося контейнера

> Теперь создадим том, где будут храниться данные нашей БД PostgreSQL:  
```
docker volume create --name vol_1
```

> После этого можно приступить к запуску контейнера:  
```
docker run --rm  --name pg-docker -e POSTGRES_PASSWORD=docker -d -p 5400:5432 -v vol_1:/var/lib/postgresql/data postgres
```
со следующими параметрами:  
**--rm** Удаляет промежуточные контейнеры после успешной сборки (по умолчанию == true);  
**--name** Задает имя контейнера;  
**-e** Пробрасывает переменные окружения внутрь контейнера;  
**-d** Запускает контейнер в фоновом режиме и выводит только id свежесозданного контейнера;  
**-p** Задает диапазон портов;  
**-v** Пробрасывает директорию файловой системы внутрь контейнера;  

После успешного запуска контейнера можно воспользоваться установленной программой pgAdmin и создать сервер test:  
<p align="center">
  <img src="https://github.com/borisshavrin/fmba_test/blob/master/img/pgadmin.png" width=840px>
</p>  


В PyCharm подключение к созданному серверу выглядит следующим образом:  
<p align="center">
  <img src="https://github.com/borisshavrin/fmba_test/blob/master/img/pycharm.png" width=840px>
</p>  

#### Второй способ запуска контейнера с БД:  

Второй способ заключается в создании [конфигурационного файла][1] в формате yaml.  
При таком подходе автоматически применяются все выбранные настройки, включая сервис администрирования БД Adminer (аналогичный pgadmin).  


#### Решение 1-й задачи в файле [sql.sql][2]:  
Для выполнения поставленной задачи было решено использовать Представления. Данное решение позволяет сократить код, повысить его читаемость и создать возможность неоднократно использовать созданное Представление.  

<hr>  

<p align="center">
  Task_2: Найти изображения, для которых есть метаданные (пары), и сформировать из них список для каждой папки.
</p>  

#### Решение 2-й задачи в файле [main.py][3]:
Для выполнения данной задачи используется библиотека glob с функцией glob(), определяющей путь до файла с указанным именеи и\или расширением. 



[1]: https://github.com/borisshavrin/fmba_test/blob/master/docker-compose.yaml  
[2]: https://github.com/borisshavrin/fmba_test/blob/master/sql.sql  
[3]: https://github.com/borisshavrin/fmba_test/blob/master/main.py
