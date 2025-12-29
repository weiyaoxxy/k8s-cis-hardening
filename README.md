# Kubernetes CIS Hardening Lab

[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Apple%20Silicon%20%7C%20Linux-lightgrey)]()

A reproducible lab to harden Kubernetes against **CIS Benchmark v1.26**, optimized for **M1/M2/M3/M4 Mac**.

> ✅ **Score: 92/100** after hardening  
> ✅ Fully automated with shell scripts  
> ✅ Includes verification reports

## 📌 Quick Start (on macOS)

```bash
# Launch VM
multipass launch --name master --cpus 2 --mem 4G

# Clone & run
multipass exec master -- bash -c "
  git clone https://github.com/$(whoami)/k8s-cis-hardening.git &&
  cd k8s-cis-hardening/setup &&
  chmod +x *.sh && ./00-prerequisites.sh
"

