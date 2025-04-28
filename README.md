# TOOLSI A CTF Tool Installation Script

![0xJellyBean Logo](https://via.placeholder.com/150x50?text=0xJellyBean)  
*A comprehensive interactive tool installation script for CTF players and security professionals*

## Table of Contents
- [Description](#description)
- [Features](#features)
- [Categories](#categories)
- [CTF Domains](#ctf-domains)
- [Installation](#installation)
- [Usage](#usage)
- [Screenshots](#screenshots)
- [Requirements](#requirements)
- [Contributing](#contributing)
- [License](#license)
- [Author](#author)
- [Disclaimer](#disclaimer)

## Description

This bash script provides an interactive menu-driven interface to install various tools useful for Capture The Flag (CTF) competitions and security research. The script features:

- Organized tool categories (Networking, Security, Forensics, etc.)
- Special CTF domain sections (Web, Crypto, Binary, etc.)
- Package manager detection (supports apt, dnf, yum)
- Docker and container tool installation
- ASCII art banner

## Features

- **Interactive Menu System**: Easy navigation through categories and tools
- **Comprehensive Tool Coverage**: 100+ tools across multiple categories
- **Smart Installation**: Checks if tools are already installed
- **CTF-Focused**: Special sections for CTF-specific tools
- **Cross-Distribution**: Works on Debian/Ubuntu (apt) and RHEL/Fedora (dnf/yum) systems
- **Container Support**: Installs Docker, Docker Compose, and kubectl
- **Package Manager Detection**: Automatically detects and uses the appropriate package manager

## Categories

### 1. Networking Tools
- curl
- wget
- netcat
- nmap
- tcpdump
- traceroute
- mtr
- iftop
- iptraf-ng
- ipcalc
- dig
- nslookup

### 2. System Monitoring Tools
- htop
- atop
- iotop
- dstat
- nmon
- glances
- ncdu
- tree
- lsof

### 3. Development Tools
- git
- make
- gcc
- g++
- python3
- pip
- python

### 4. Text Processing Tools
- vim
- nano
- emacs
- jq
- awk
- sed
- grep

### 5. Compression Tools
- zip
- unzip
- gzip
- bzip2
- xz-utils
- p7zip-full
- rar

### 6. Miscellaneous Utilities
- tmux
- screen
- rsync
- ssh
- sshfs
- openssh-client
- openssh-server
- sudo
- bc
- telnet
- lynx
- w3m
- aria2
- axel
- mediainfo
- ffmpeg
- imagemagick

### 7. Security Tools
- fail2ban
- clamav
- rkhunter
- chkrootkit

### 8. Container Tools
- docker
- docker-compose
- kubectl

### 9. CTF Tools
(See [CTF Domains](#ctf-domains) section below)

### 10. All Categories
Install all available tools from all categories

## CTF Domains

### 1. Web Exploitation
- sqlmap
- burpsuite
- nikto
- dirb
- gobuster

### 2. Cryptography
- john
- hashcat
- fcrackzip
- openssl

### 3. Binary Exploitation
- gdb
- pwntools
- checksec
- ropgadget

### 4. Reverse Engineering
- radare2
- ghidra
- cutter
- strace

### 5. Forensics
- binwalk
- foremost
- steghide
- exiftool

### 6. All CTF Tools
Install all CTF-related tools from all domains

## Installation

1. Download the script:
   ```bash
   curl -O https://raw.githubusercontent.com/yourusername/ctf-tool-installer/main/ctf-tool-installer.sh
