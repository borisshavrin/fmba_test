<h1 align="center">FMBA Test</h1>

<p align="center">
  Task_1: Необходимо вывести самую популярную категорию товаров
</p>  

#### Для начала выполним конфигурацию Docker, где запустим БД PostgreSQL.  

> Перед созданием контейнера (назовем его pg-docker), проверим не занято ли это имя  

```
  docker container ls
```  
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
  <img src="https://github.com/borisshavrin/sms_activate_bot/blob/master/static/github/img/titleBot.jpg" width=250px>
</p>  


В PyCharm подключение к созданному серверу выглядит следующим образом:  
<p align="center">
  <img src="https://github.com/borisshavrin/sms_activate_bot/blob/master/static/github/img/titleBot.jpg" width=250px>
</p>  


Существует второй способ запуска контейнера с БД - [конфигурационный файл][1] в формате yaml


[1]: https://github.com/borisshavrin/fmba_test/blob/master/docker-compose.yaml
