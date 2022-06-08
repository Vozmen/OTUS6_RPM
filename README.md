# OTUS6_SOFT
 Homework
Установил необходимый софт
yum install -y \
redhat-lsb-core \
wget \
rpmdevtools \
rpm-build \
createrepo \
yum-utils \
gcc

Скачал и установил пакет nginx
wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.14.1-1.el7_4.ngx.src.rpm
rpm -i nginx-1.14.1-1.el7_4.ngx.src.rpm

Скачал и распаковал openssl
wget https://www.openssl.org/source/latest.tar.gz
tar -xvf latest.tar.gz

Установил все зависимости
yum-builddep rpmbuild/SPECS/nginx.spec

Добавил нужный параметр в
--with-openssl=/root/openssl-1.1.1a

Собрал пакет и убедился что создалось два rpm пакета
rpmbuild -bb rpmbuild/SPECS/nginx.spec
ll rpmbuild/RPMS/x86_64/

Установил пакет, стартанул и проверил службу nginx
yum localinstall rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm -y
systemctl start nginx
systemctl status nginx

Создал директорию и скопировал туда два rpm пакета
mkdir /usr/share/nginx/html/repo
cp rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm /usr/share/nginx/html/repo/

Этого пакета нет, заменил его
http://www.percona.com/downloads/percona-release/redhat/0.1-6/percona-release-0.1-6.noarch.rpm
wget https://downloads.percona.com/downloads/percona-release/percona-release-1.0-9/redhat/percona-release-1.0-9.noarch.rpm -O /usr/share/nginx/html/repo/percona-release-1.0-9.noarch.rpm

Инициализировал репозиторий
createrepo /usr/share/nginx/html/repo/

В файле  /etc/nginx/conf.d/default.conf добавил строчку autoindex on;

Проверил и перезапустил службу nginx
nginx -t
nginx -s reload

Проверил через curl
curl -a http://localhost/repo/

Добавил репозиторий в /etc/yum.repos.d/
cat >> /etc/yum.repos.d/otus.repo << EOF
[otus]
name=otus-linux
baseurl=http://localhost/repo
gpgcheck=0
enabled=1
EOF

Проверил подключение репозитория.
По второй команде вывод команды отличается от вывода в методичке
yum repolist enabled | grep otus
yum list | grep otus

[root@rpm ~]# yum repolist enabled | grep otus
otus                      otus-linux                                           2
[root@rpm ~]# yum list | grep otus
percona-release.noarch                      1.0-9                      @otus

Установил percona-release
yum install percona-release -y

После установки вывод команды yum list | grep otus не показывает ничего. Я попробовал удалить эту программу, после чего она вернулась в вывод. Установил заново, в выоде она осталась
Я так и не смог разобраться, почему nginx не выводится, как показано в методичке