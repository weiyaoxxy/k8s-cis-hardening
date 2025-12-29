#!/bin/bash
set -e

echo "🔍 Running kube-bench for post-hardening verification..."

# 运行针对 master 节点的 CIS 检查（适用于控制平面）
sudo kube-bench run --targets master --json > /tmp/kube-bench-post.json 2>&1

# 或者直接输出文本报告
sudo kube-bench run --targets master > /tmp/kube-bench-post.txt 2>&1

# 复制到指定位置
mkdir -p verification
cp /tmp/kube-bench-post.txt /home/ubuntu/k8s-cis-hardening/verification/post-hardening-report.txt

echo "✅ Report saved to: verification/post-hardening-report.txt"
cat /home/ubuntu/k8s-cis-hardening/verification/post-hardening-report.txt

