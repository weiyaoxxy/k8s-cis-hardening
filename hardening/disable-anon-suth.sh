#!/bin/bash
# Fix CIS 1.2.1: Disable anonymous auth in API Server

if ! grep -q "anonymous-auth=false" /etc/kubernetes/manifests/kube-apiserver.yaml; then
  sudo sed -i "/- kube-apiserver/a\    - --anonymous-auth=false" /etc/kubernetes/manifests/kube-apiserver.yaml
  echo "🔄 API Server restarting..."
  sleep 30
fi

# Verify
if kubectl get --raw='/metrics' 2>/dev/null; then
  echo "❌ FAIL: Anonymous access still allowed!"
  exit 1
else
  echo "✅ PASS: Anonymous access disabled."
fi

