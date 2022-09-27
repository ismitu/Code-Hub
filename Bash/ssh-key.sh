#!/usr/bin/env bash
#PS：禁用Root账户登录并使用SSH-KEY密钥进行配对登录
#Time：2021-10-06

#测试环境：Debian & Centos

#定义公钥
ssh_key="ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAYEAv8ySwgI+z3KNAz/CanO3g/1fh+RjyfKQMpqv2Yrym08Dkm3qfWJVU5Hr2mOvMoSioR/CQOCu8wKpFOCp7c7C9brmS8bTwjSUCEmSGLc2FDweK6yRknzw/6d8gTjdCG/JPGUD2Q8ENzdcAqQRRFN3frTpRSB4aH+Cr1fqeu8g5ZkK43fW16ZxrT1HoF1e4pUmpM8xIpMHncsS3prsKTqdQ0bSUZ77i8BFcDXvqv8waRQNgoCksiESTPR7BUZ9lWMT8RS0VYYXrl8SodpkBPvqaz5w9xTe3h9/vcSAdwwejrHymD91pHMbt0eypMd0GAkald0fzW7LdfLNtbbIPB/CEue6Hc3kDseopft8uOLsPWrR2I+sQ+RXIn2SOTXYTM4X+XBCcxf3mrjktQVYAd+/gHZU2NUCVv01fx5Jo3rQ+tZ5L3khPfsVMOBiwNTK+bNwGdAMi8Y+Sz+z17CXOKxiPS91mDUa1JfiTm3fFxtLbWIAyiLi0wDszUU0agQLHm1h"

#更新源并安装依赖
#apt-get update &> /dev/null
#apt-get install curl -y

#下载 Github 上存储的SSH-密钥
mkdir ~/.ssh
chmod 700 ~/.ssh
echo $ssh_key > ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

#禁用Root账号并开启SSH-KEY密钥登录
cd /etc/ssh/
sed -i "/PasswordAuthentication no/c PasswordAuthentication no" sshd_config
sed -i "/RSAAuthentication no/c RSAAuthentication yes" sshd_config
sed -i "/PubkeyAuthentication no/c PubkeyAuthentication yes" sshd_config
sed -i "/PasswordAuthentication yes/c PasswordAuthentication no" sshd_config
sed -i "/RSAAuthentication yes/c RSAAuthentication yes" sshd_config
sed -i "/PubkeyAuthentication yes/c PubkeyAuthentication yes" sshd_config
service sshd restart
service ssh restart
systemctl restart sshd