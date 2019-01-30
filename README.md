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
  --metadata-from-file startup-script=startup.sh \ 
  --restart-on-failure
```

# Создание правила firewall разрешающее порт 9292
```
gcloud compute firewall-rules create default-puma-server \
--allow=TCP:9292 \
--source-tags=puma-server \
--source-ranges=0.0.0.0/0
```
    
# Создание образа через packer  
- Был разработан шаблон для создания виртуальной машины с предустановлеными сервисами для reddit-app
- Был разработан шаблон для создания уже готовой виртуальной машины с установленной и запущенной на ней приложении  
- Основные Настройки для сбоки находяться в файле variables.json  
- Пользовательские настройки находяться в файле шаблона сборки ubuntu16.json   
- Аналогично и для сборки BAKE образа immutable.json  

Для сборки базового образа используются скрипты packer/scripts/install_mongodb.sh packer/scripts/install_ruby.sh  
`Название скриптов соотвествует их задаче`  
immutable.json использует из packer/scripts/deploy.sh - развертывание приложения и packer/scripts/settings_systemd.sh - Для настройки systemd демона для старта приложения после создания виртуальной машины

### Для сборки образа без приложения
Для сборки нужно выполнить следующую комманду
```
packer build --var-file=ВАШ_VARFILE  ubuntu16.json
```
Справидливо для создания bake образа меняем название шаблона на immutable.json  
Для равертывания виртуальной машины модно использовать скрипт из дирректории  config-scripts/create-reddit-vm.sh NAME_VM (передав название виртуальной машины в качетве аргумента скрипту)

# Terraform  

При попытке добавить в мета больше одного средствами terraform публичного ключа terrafform отрабатывает успешно 
```
      metadata.ssh-keys:                                   "appuser:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDddP77E1K71wx8tzGWmZNYQGyVx4cPGsU0t8qrJBDSTW4vMlXlLRczEjohJG3K7tumsMrbvOhq7QSqlYxtdFiHtVDVaAZ1dGHgNTuChDMWgn0KT0fcYEfY1q9xh6yfHqVwdgo/YakhlgXFMtm1Knmr/YrEoFinqyu39Avm1lQx/H3eIQsxBek0vuK9GDZ8+Fd7bTrIeUy4dx7xPqLTZmw1ffIyBNNIPwfKy59QRpeiXjtuZ080CjF2RCCd9k6eNwISGS6AX4P1c6cJEcEMbCm/1l9/wxas7bv00PMOpia3H2sJp7+y6D/wSpp5XopBBrIR1lxnl6Rd06WBzr4ZaHvH appuser\nappuser1:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDddP77E1K71wx8tzGWmZNYQGyVx4cPGsU0t8qrJBDSTW4vMlXlLRczEjohJG3K7tumsMrbvOhq7QSqlYxtdFiHtVDVaAZ1dGHgNTuChDMWgn0KT0fcYEfY1q9xh6yfHqVwdgo/YakhlgXFMtm1Knmr/YrEoFinqyu39Avm1lQx/H3eIQsxBek0vuK9GDZ8+Fd7bTrIeUy4dx7xPqLTZmw1ffIyBNNIPwfKy59QRpeiXjtuZ080CjF2RCCd9k6eNwISGS6AX4P1c6cJEcEMbCm/1l9/wxas7bv00PMOpia3H2sJp7+y6D/wSpp5XopBBrIR1lxnl6Rd06WBzr4ZaHvH appuser\n" => "appuser:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDddP77E1K71wx8tzGWmZNYQGyVx4cPGsU0t8qrJBDSTW4vMlXlLRczEjohJG3K7tumsMrbvOhq7QSqlYxtdFiHtVDVaAZ1dGHgNTuChDMWgn0KT0fcYEfY1q9xh6yfHqVwdgo/YakhlgXFMtm1Knmr/YrEoFinqyu39Avm1lQx/H3eIQsxBek0vuK9GDZ8+Fd7bTrIeUy4dx7xPqLTZmw1ffIyBNNIPwfKy59QRpeiXjtuZ080CjF2RCCd9k6eNwISGS6AX4P1c6cJEcEMbCm/1l9/wxas7bv00PMOpia3H2sJp7+y6D/wSpp5XopBBrIR1lxnl6Rd06WBzr4ZaHvH appuser\nappuser1:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDddP77E1K71wx8tzGWmZNYQGyVx4cPGsU0t8qrJBDSTW4vMlXlLRczEjohJG3K7tumsMrbvOhq7QSqlYxtdFiHtVDVaAZ1dGHgNTuChDMWgn0KT0fcYEfY1q9xh6yfHqVwdgo/YakhlgXFMtm1Knmr/YrEoFinqyu39Avm1lQx/H3eIQsxBek0vuK9GDZ8+Fd7bTrIeUy4dx7xPqLTZmw1ffIyBNNIPwfKy59QRpeiXjtuZ080CjF2RCCd9k6eNwISGS6AX4P1c6cJEcEMbCm/1l9/wxas7bv00PMOpia3H2sJp7+y6D/wSpp5XopBBrIR1lxnl6Rd06WBzr4ZaHvH appuser\nappuser2:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDddP77E1K71wx8tzGWmZNYQGyVx4cPGsU0t8qrJBDSTW4vMlXlLRczEjohJG3K7tumsMrbvOhq7QSqlYxtdFiHtVDVaAZ1dGHgNTuChDMWgn0KT0fcYEfY1q9xh6yfHqVwdgo/YakhlgXFMtm1Knmr/YrEoFinqyu39Avm1lQx/H3eIQsxBek0vuK9GDZ8+Fd7bTrIeUy4dx7xPqLTZmw1ffIyBNNIPwfKy59QRpeiXjtuZ080CjF2RCCd9k6eNwISGS6AX4P1c6cJEcEMbCm/1l9/wxas7bv00PMOpia3H2sJp7+y6D/wSpp5XopBBrIR1lxnl6Rd06WBzr4ZaHvH appuser\n"
```

После добавления ключа в metadata и запуска terraform отработал успешно

# Terraform-2
Было выполнено разделение main.tf на несколько модулей app и db было вынесено в параметизированы некоторые свойства модулей ip,firewall,disk_image and etc  
Было разделено по окружением вызов модулей (prod,stage)
Были созданы storage  gcp для хранения state file terraform при помощи подключения модуля из репозитория terraform  
Попробывал вынести tfstate в хранилище gcp

#Ansible-1
После выполнения ansible app -m command -a 'rm -rf ~/reddit' и повторного выполнения ansible-playbook clone.yml change стал 1 так как изменилась файловая структура на сервере при повторном выполнении change 0
Добавлен dynamic inventory inv.sh
