#!/bin/bash
# 在 Ubuntu ARM64 上准备 K8s 环境（满足 CIS 基础要求）

set -e

echo "🔧 关闭 swap..."
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

echo "📦 安装 containerd..."
sudo apt-get update
sudo apt-get install -y containerd.io

echo "⚙️ 配置 containerd 使用 systemd cgroup..."
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd

echo "🔌 加载内核模块..."
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter

echo "🌐 配置 sysctl..."
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sudo sysctl --system

echo "✅ 系统初始化完成！"

