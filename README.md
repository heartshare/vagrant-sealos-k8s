# 说明

基于vbox使用vagrant快速搭建vm集群，集群配置详见Vagrantfile配置文件（默认3台vm，可酌情增加）。

基于vm集群，使用sealos安装k8s master、node以及dashboard等。

在PC机（i5/32G/HDD/Windows 10 pro）环境下测试，搭建vm集群耗时5分钟，sealos搭建k8s集群耗时7分钟。

**相关资源**

vagrant docs：https://www.vagrantup.com/docs/cli

sealos docs：https://sealyun.com/docs/

# 环境准备

## 1 搭建vm集群

### 配置说明

- CPU

  不低于2核。

- 内存

  不低于4G。

- 网络

  nat模式：vagrant默认配置。

  host-only模式：用以node节点通讯。

  - gateway ip：192.168.56.1
  - vm ip：192.168.56.101/102/103

  bridged模式：用以vm互联网通讯。

- ssh

  各vm共享root用户密玥对，实现互免密访问。

### 操作步骤

1. 下载、安装vbox：https://www.virtualbox.org/wiki/Downloads

   检查宿主机host-only网卡ip是否为192.168.56.1（或者在vbox图形界面配置查看：管理 -> 主机网络管理器）

2. 下载、安装vagrant（支持Windows/Linux）：https://www.vagrantup.com/downloads

3. 下载、配置vagrant box（虚拟机镜像，本地化与之后可提速启动）：http://cloud.centos.org/centos/7/vagrant/x86_64/images/

   1. 添加box至本地：vagrant add centos7.1905_01 [box文件本机路径]
   2. 查看box列表：vagrant box list 

4. 可选：安装vbox虚拟机插件（用于同步宿主机目录等高级特性，需要【翻墙】）：vagrant plugin install vagrant-vbguest

5. 检出源代码：git clone url

6. 在源代码跟路径下，启动vm集群，运行：vagrant up

7. 登录验证vm可用性
- 方式1：通过vagrant ssh 指令（该指令默认使用vagrant用户登录，该用户由vagrant自动分配公私钥对，用以ssh免密登录），vagrant ssh kn1
- 方式2：root用户可使用终端工具（默认密码vagrant）


## 2. 搭建k8s集群
### 配置说明

- k8s version 17.1.6

- k8s dashborad version v2.0.0-bata5.2

- sealos [安装条件](https://sealyun.com/docs/tutorial.html#前提条件) | [安装指令](https://sealyun.com/docs/tutorial.html#安装教程) 

### 操作步骤

1. 登录master

   ```powershell
   vagrant ssh kn1
   ```

2. master内执行

   ```bash
   sudo -i
   cp /vagrant/step1-install-k8s.sh /root/ -f
   chmod 700 /root/step1-install-k8s.sh & sh /root/step1-install-k8s.sh
   ```

3. 安装个人应用。
