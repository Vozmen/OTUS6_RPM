yum install -y \
redhat-lsb-core \
wget \
rpmdevtools \
rpm-build \
createrepo \
yum-utils \
gcc
wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.14.1-1.el7_4.ngx.src.rpm -O /root/nginx-1.14.1-1.el7_4.ngx.src.rpm
rpm -i /root/nginx-1.14.1-1.el7_4.ngx.src.rpm
wget --no-check-certificate https://www.openssl.org/source/openssl-1.1.1o.tar.gz -O /root/openssl-1.1.1o.tar.gz
tar -xvf /root/openssl-1.1.1o.tar.gz --directory=/root
yum-builddep /root/rpmbuild/SPECS/nginx.spec -y
rm rpmbuild/SPECS/nginx.spec --force
wget https://raw.githubusercontent.com/Vozmen/OTUS6_RPM/main/nginx.spec -O /root/rpmbuild/SPECS/nginx.spec
rpmbuild -bb /root/rpmbuild/SPECS/nginx.spec
yum localinstall /root/rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm -y
yum localinstall rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm -y
systemctl start nginx
mkdir /usr/share/nginx/html/repo
cp /root/rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm /usr/share/nginx/html/repo/
wget https://downloads.percona.com/downloads/percona-release/percona-release-1.0-9/redhat/percona-release-1.0-9.noarch.rpm -O /usr/share/nginx/html/repo/percona-release-1.0-9.noarch.rpm
createrepo /usr/share/nginx/html/repo/
rm /etc/nginx/conf.d/default.conf --force
wget https://raw.githubusercontent.com/Vozmen/OTUS6_RPM/main/default.conf -O /etc/nginx/conf.d/default.conf
nginx -s reload
cat >> /etc/yum.repos.d/otus.repo << EOF
[otus]
name=otus-linux
baseurl=http://localhost/repo
gpgcheck=0
enabled=1
EOF