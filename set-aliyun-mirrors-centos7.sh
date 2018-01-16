#!/bin/bash
#备份原有的
mv /etc/yum.repos.d/CentOS-Base.repo ./CentOS-Base.repo.bak
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum update
