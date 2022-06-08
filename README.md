# OTUS6_SOFT
 Homework
��������� ����������� ����
yum install -y \
redhat-lsb-core \
wget \
rpmdevtools \
rpm-build \
createrepo \
yum-utils \
gcc

������ � ��������� ����� nginx
wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.14.1-1.el7_4.ngx.src.rpm
rpm -i nginx-1.14.1-1.el7_4.ngx.src.rpm

������ � ���������� openssl
wget https://www.openssl.org/source/latest.tar.gz
tar -xvf latest.tar.gz

��������� ��� �����������
yum-builddep rpmbuild/SPECS/nginx.spec

������� ������ �������� �
--with-openssl=/root/openssl-1.1.1a

������ ����� � �������� ��� ��������� ��� rpm ������
rpmbuild -bb rpmbuild/SPECS/nginx.spec
ll rpmbuild/RPMS/x86_64/

��������� �����, ��������� � �������� ������ nginx
yum localinstall rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm -y
systemctl start nginx
systemctl status nginx

������ ���������� � ���������� ���� ��� rpm ������
mkdir /usr/share/nginx/html/repo
cp rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm /usr/share/nginx/html/repo/

����� ������ ���, ������� ���
http://www.percona.com/downloads/percona-release/redhat/0.1-6/percona-release-0.1-6.noarch.rpm
wget https://downloads.percona.com/downloads/percona-release/percona-release-1.0-9/redhat/percona-release-1.0-9.noarch.rpm -O /usr/share/nginx/html/repo/percona-release-1.0-9.noarch.rpm

��������������� �����������
createrepo /usr/share/nginx/html/repo/

� �����  /etc/nginx/conf.d/default.conf ������� ������� autoindex on;

�������� � ������������ ������ nginx
nginx -t
nginx -s reload

�������� curl
curl -a http://localhost/repo/