#!/bin/bash
echo "Install Ruby"
sudo apt update && sudo apt install -y ruby-full ruby-bundler build-essential
echo "Добавляю ключ репозитория mongodb"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
echo "Устанавливаю mongodb"
sudo apt update && sudo apt install -y mongodb-org
echo "Запускаю mongodb"
sudo systemctl start mongod
echo "Добавляю в mongodb"
sudo systemctl enable mongod
echo "Клонирую репозиторий с приложением"
git clone -b monolith https://github.com/express42/reddit.git
echo "Устанавливаю зависимости приложения"
cd ~/reddit && bundle install
echo "Зупускаю приложение"
puma -d

