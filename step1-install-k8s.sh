#! /bin/bash

echo "脚本执行开始："

# 设置语言、时区等
# echo "LANG=\"en_US.UTF-8\"" > /etc/locale.conf 
# cat /etc/locale.conf
# source /etc/locale.conf
# locale

# 拷贝k8s安装资源
cp /vagrant/k8s /root -rf
chmod +x /root/k8s/sealos && mv /root/k8s/sealos /usr/bin 
echo "完成k8s资源拷贝和授权。"

# 建议分步安装，避免单点故障导致整体回退
# 1.安装master
sealos init --master 192.168.56.101 \
    --version v1.17.6 \
    --pkg-url /root/k8s/kube1.17.6.tar.gz
echo "完成k8s master安装。"

# 2.安装、添加node
sealos join --node 192.168.56.102
sealos join --node 192.168.56.103
echo "完成k8s nodes安装。"

# 查看pod
kubectl get pod --all-namespaces

# 安装k8s dashboard
# 访问地址：https://192.168.56.101:32000
sealos install --pkg-url /root/k8s/dashboard.tar
echo "完成k8s dashboard安装。"

# 获取token
echo "获取kubectl token"
kubectl get secret -nkubernetes-dashboard \
		$(kubectl get secret -n kubernetes-dashboard|grep dashboard-token |awk '{print $1}') \
		-o jsonpath='{.data.token}'  | base64 --decode

echo ""
echo "脚本执行完成！"