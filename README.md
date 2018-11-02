# darthnitrox_infra
darthnitrox Infra repository

# Google Cloud Platform Bastion Host 

- Для подключения к хосту someinternalhost(с локальным ip адресом )  
Нужно добавить следующие строки в ~/.ssh/config  

```
Host bastion
  Hostname 35.211.203.150
  User appuser
  IdentityFile ~/.ssh/appuser

Host someinternalhost
  Hostname 10.156.0.2
  User appuser
  ProxyCommand ssh -W %h:%p bastion
  IdentityFile ~/.ssh/appuser

```
После этих настроек можно подключаться к someinternalhost введя одну комманду ssh someinternalhost

bastion_IP = 35.211.203.150  
someinternalhost_IP = 10.156.0.2  

testapp_IP = 35.234.87.56  
testapp_port = 9292  

# Команда для запуска инстанса с приложение (развернутым в процессе создания)
```
gcloud compute instances create reddit-app\ 
  --boot-disk-size=10GB \ 
  --image-family ubuntu-1604-lts \ 
  --image-project=ubuntu-os-cloud \ 
  --machine-type=g1-small \ 
  --tags puma-server \
  ----metadata-from-file startup-script=startup.sh \ 
  --restart-on-failure
```

# Создание правила firewall разрешающее порт 9292
```
gcloud compute firewall-rules create default-puma-server \
--allow=TCP:9292 \
--source-tags=puma-server \
--source-ranges=0.0.0.0/0
```
    
