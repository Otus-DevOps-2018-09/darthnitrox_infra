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

# cloud-testapp
testapp_IP = 35.198.167.169
testapp_port = 9292 
    
