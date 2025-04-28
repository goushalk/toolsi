#!/bin/bash

# Interactive Tool Installation Script with CTF Category
# Featuring 0xJellyBean ASCII art

JELLYBEAN_ART='
_________ _______  _______  _        _______ _________
\__   __/(  ___  )(  ___  )( \      (  ____ \\__   __/
   ) (   | (   ) || (   ) || (      | (    \/   ) (   
   | |   | |   | || |   | || |      | (_____    | |   
   | |   | |   | || |   | || |      (_____  )   | |   
   | |   | |   | || |   | || |            ) |   | |   
   | |   | (___) || (___) || (____/\/\____) |___) (___
   )_(   (_______)(_______)(_______/\_______)\_______/
                                                      


'

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root or with sudo."
    exit 1
fi

# Detect package manager
if command -v apt-get &> /dev/null; then
    PKG_MANAGER="apt-get"
    UPDATE_CMD="apt-get update"
    INSTALL_CMD="apt-get install -y"
elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf"
    UPDATE_CMD="dnf check-update -y"
    INSTALL_CMD="dnf install -y"
elif command -v yum &> /dev/null; then
    PKG_MANAGER="yum"
    UPDATE_CMD="yum check-update -y"
    INSTALL_CMD="yum install -y"
else
    echo "Unsupported package manager. Exiting."
    exit 1
fi

# Update package lists
echo "Updating package lists..."
$UPDATE_CMD

# Function to install a tool if not already installed
install_tool() {
    local tool=$1
    local pkg_name=${2:-$tool}  # Use second argument as package name if provided
    
    if ! command -v "$tool" &> /dev/null; then
        echo "Installing $tool..."
        $INSTALL_CMD "$pkg_name"
    else
        echo "$tool is already installed."
    fi
}

# Category definitions
declare -A CATEGORIES=(
    [1]="Networking Tools"
    [2]="System Monitoring Tools"
    [3]="Development Tools"
    [4]="Text Processing Tools"
    [5]="Compression Tools"
    [6]="Miscellaneous Utilities"
    [7]="Security Tools"
    [8]="Container Tools"
    [9]="CTF Tools"
    [10]="All Categories"
    [0]="Exit"
)

# CTF Domain definitions
declare -A CTF_DOMAINS=(
    [1]="Web Exploitation"
    [2]="Cryptography"
    [3]="Binary Exploitation"
    [4]="Reverse Engineering"
    [5]="Forensics"
    [6]="All CTF Tools"
    [0]="Back"
)

# Tool definitions
declare -A TOOLS=(
    # Networking Tools
    [curl]="1 curl"
    [wget]="1 wget"
    [netcat]="1 netcat"
    [nmap]="1 nmap"
    [tcpdump]="1 tcpdump"
    [traceroute]="1 traceroute"
    [mtr]="1 mtr"
    [iftop]="1 iftop"
    [iptraf-ng]="1 iptraf-ng"
    [ipcalc]="1 ipcalc"
    [dig]="1 dnsutils dig"
    [nslookup]="1 dnsutils nslookup"
    
    # System Monitoring Tools
    [htop]="2 htop"
    [atop]="2 atop"
    [iotop]="2 iotop"
    [dstat]="2 dstat"
    [nmon]="2 nmon"
    [glances]="2 glances"
    [ncdu]="2 ncdu"
    [tree]="2 tree"
    [lsof]="2 lsof"
    
    # Development Tools
    [git]="3 git"
    [make]="3 make"
    [gcc]="3 gcc"
    [g++]="3 g++"
    [python3]="3 python3"
    [pip]="3 python3-pip pip"
    [python]="3 python-is-python3 python"
    
    # Text Processing Tools
    [vim]="4 vim"
    [nano]="4 nano"
    [emacs]="4 emacs"
    [jq]="4 jq"
    [awk]="4 gawk awk"
    [sed]="4 sed"
    [grep]="4 grep"
    
    # Compression Tools
    [zip]="5 zip"
    [unzip]="5 unzip"
    [gzip]="5 gzip"
    [bzip2]="5 bzip2"
    [xz-utils]="5 xz-utils"
    [p7zip-full]="5 p7zip-full"
    [rar]="5 unrar rar"
    
    # Miscellaneous Utilities
    [tmux]="6 tmux"
    [screen]="6 screen"
    [rsync]="6 rsync"
    [ssh]="6 ssh"
    [sshfs]="6 sshfs"
    [openssh-client]="6 openssh-client"
    [openssh-server]="6 openssh-server"
    [sudo]="6 sudo"
    [bc]="6 bc"
    [telnet]="6 telnet"
    [lynx]="6 lynx"
    [w3m]="6 w3m"
    [aria2]="6 aria2"
    [axel]="6 axel"
    [mediainfo]="6 mediainfo"
    [ffmpeg]="6 ffmpeg"
    [imagemagick]="6 imagemagick"
    
    # Security Tools
    [fail2ban]="7 fail2ban"
    [clamav]="7 clamav"
    [rkhunter]="7 rkhunter"
    [chkrootkit]="7 chkrootkit"
)

# CTF Tool definitions
declare -A CTF_TOOLS=(
    # Web Exploitation
    [sqlmap]="1 sqlmap"
    [burpsuite]="1 burpsuite"
    [nikto]="1 nikto"
    [dirb]="1 dirb"
    [gobuster]="1 gobuster"
    
    # Cryptography
    [john]="2 john"
    [hashcat]="2 hashcat"
    [fcrackzip]="2 fcrackzip"
    [openssl]="2 openssl"
    
    # Binary Exploitation
    [gdb]="3 gdb"
    [pwntools]="3 python3-pwntools"
    [checksec]="3 checksec"
    [ropgadget]="3 ropgadget"
    
    # Reverse Engineering
    [radare2]="4 radare2"
    [ghidra]="4 ghidra"
    [cutter]="4 cutter"
    [strace]="4 strace"
    
    # Forensics
    [binwalk]="5 binwalk"
    [foremost]="5 foremost"
    [steghide]="5 steghide"
    [exiftool]="5 exiftool"
)

# Container Tools (special handling)
CONTAINER_TOOLS=(
    "docker"
    "docker-compose"
    "kubectl"
)

# Display category menu
show_category_menu() {
    clear
    echo "$JELLYBEAN_ART"
    echo ""
    echo "Select which categories of tools to install:"
    for num in "${!CATEGORIES[@]}"; do
        echo "$num) ${CATEGORIES[$num]}"
    done | sort -n
    echo ""
}

# Display CTF domain menu
show_ctf_domains() {
    clear
    echo "$JELLYBEAN_ART"
    echo ""
    echo "Select CTF Domain:"
    for num in "${!CTF_DOMAINS[@]}"; do
        echo "$num) ${CTF_DOMAINS[$num]}"
    done | sort -n
    echo ""
}

# Display tools menu for selected categories
show_tools_menu() {
    local selected_categories=("$@")
    
    clear
    echo "$JELLYBEAN_ART"
    echo ""
    echo "Select tools to install (space separated):"
    echo "----------------------------------------"
    
    declare -A tools_in_categories
    
    # Get all tools in selected categories
    for category in "${selected_categories[@]}"; do
        if [ "$category" == "10" ]; then
            # All categories selected (except CTF which has its own menu)
            for tool in "${!TOOLS[@]}"; do
                tools_in_categories["$tool"]=1
            done
            break
        else
            for tool in "${!TOOLS[@]}"; do
                if [[ "${TOOLS[$tool]}" == "$category "* ]]; then
                    tools_in_categories["$tool"]=1
                fi
            done
        fi
    done
    
    # Add container tools if category 8 was selected
    if [[ " ${selected_categories[@]} " =~ " 8 " ]] || [[ " ${selected_categories[@]} " =~ " 10 " ]]; then
        for tool in "${CONTAINER_TOOLS[@]}"; do
            tools_in_categories["$tool"]=1
        done
    fi
    
    # Display tools with numbers
    local i=1
    local tool_numbers=()
    for tool in "${!tools_in_categories[@]}"; do
        echo "$i) $tool"
        tool_numbers[$i]="$tool"
        ((i++))
    done
    
    echo ""
    echo "$i) Install Selected Tools"
    ((i++))
    echo "$i) Back to Categories"
    echo ""
    
    read -p "Enter your choices (space separated): " tool_choices
    
    # Process tool selections
    IFS=' ' read -ra choices <<< "$tool_choices"
    
    for choice in "${choices[@]}"; do
        if [[ "$choice" == "$((i-1))" ]]; then
            # Install Selected Tools
            for tool in "${!tools_in_categories[@]}"; do
                if [[ "${TOOLS[$tool]}" != "" ]]; then
                    # Regular tool
                    IFS=' ' read -r category pkg_name tool_name <<< "${TOOLS[$tool]}"
                    install_tool "$tool_name" "$pkg_name"
                else
                    # Container tool
                    case "$tool" in
                        docker)
                            if ! command -v docker &> /dev/null; then
                                echo "Installing Docker..."
                                curl -fsSL https://get.docker.com | sh
                                systemctl enable docker
                                systemctl start docker
                                usermod -aG docker $(whoami)
                            else
                                echo "Docker is already installed."
                            fi
                            ;;
                        docker-compose)
                            if ! command -v docker-compose &> /dev/null; then
                                echo "Installing Docker Compose..."
                                curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                                chmod +x /usr/local/bin/docker-compose
                            else
                                echo "Docker Compose is already installed."
                            fi
                            ;;
                        kubectl)
                            if ! command -v kubectl &> /dev/null; then
                                echo "Installing kubectl..."
                                curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
                                install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
                                rm kubectl
                            else
                                echo "kubectl is already installed."
                            fi
                            ;;
                    esac
                fi
            done
            read -p "Press enter to continue..."
            return 1
        elif [[ "$choice" == "$i" ]]; then
            # Back to Categories
            return 1
        elif [[ "$choice" =~ ^[0-9]+$ ]] && [[ "$choice" -lt "$((i-1))" ]]; then
            # Toggle tool selection
            selected_tool="${tool_numbers[$choice]}"
            if [[ "${selected_tools[$selected_tool]}" == "1" ]]; then
                selected_tools["$selected_tool"]="0"
                echo "Unselected $selected_tool"
            else
                selected_tools["$selected_tool"]="1"
                echo "Selected $selected_tool"
            fi
        fi
    done
    
    return 0
}

# Display CTF tools menu for selected domain
show_ctf_tools_menu() {
    local domain=$1
    
    clear
    echo "$JELLYBEAN_ART"
    echo ""
    echo "Select CTF tools for ${CTF_DOMAINS[$domain]}:"
    echo "----------------------------------------"
    
    declare -A tools_in_domain
    
    # Get all tools in selected domain
    if [ "$domain" == "6" ]; then
        # All CTF tools selected
        for tool in "${!CTF_TOOLS[@]}"; do
            tools_in_domain["$tool"]=1
        done
    else
        # Specific domain selected
        for tool in "${!CTF_TOOLS[@]}"; do
            if [[ "${CTF_TOOLS[$tool]}" == "$domain "* ]]; then
                tools_in_domain["$tool"]=1
            fi
        done
    fi
    
    # Display tools with numbers
    local i=1
    local tool_numbers=()
    for tool in "${!tools_in_domain[@]}"; do
        echo "$i) $tool"
        tool_numbers[$i]="$tool"
        ((i++))
    done
    
    echo ""
    echo "$i) Install Selected Tools"
    ((i++))
    echo "$i) Back to CTF Domains"
    echo ""
    
    read -p "Enter your choices (space separated): " tool_choices
    
    # Process tool selections
    IFS=' ' read -ra choices <<< "$tool_choices"
    
    for choice in "${choices[@]}"; do
        if [[ "$choice" == "$((i-1))" ]]; then
            # Install Selected Tools
            for tool in "${!tools_in_domain[@]}"; do
                IFS=' ' read -r domain_num pkg_name tool_name <<< "${CTF_TOOLS[$tool]}"
                install_tool "$tool_name" "$pkg_name"
                
                # Special handling for pwntools
                if [ "$tool_name" == "pwntools" ]; then
                    echo "Installing pwntools Python package..."
                    pip install --upgrade pwntools
                fi
            done
            read -p "Press enter to continue..."
            return 1
        elif [[ "$choice" == "$i" ]]; then
            # Back to CTF Domains
            return 1
        elif [[ "$choice" =~ ^[0-9]+$ ]] && [[ "$choice" -lt "$((i-1))" ]]; then
            # Toggle tool selection
            selected_tool="${tool_numbers[$choice]}"
            echo "Selected $selected_tool for installation"
        fi
    done
    
    return 0
}

# Main loop
while true; do
    show_category_menu
    read -p "Enter numbers separated by spaces (e.g., '1 3 5'): " category_choices
    
    # Convert choices to array
    IFS=' ' read -ra selected_categories <<< "$category_choices"
    
    for category in "${selected_categories[@]}"; do
        case "$category" in
            0)
                echo "Exiting. Stay based!"
                exit 0
                ;;
            9)
                # CTF Tools menu
                while true; do
                    show_ctf_domains
                    read -p "Enter your CTF domain choice: " ctf_choice
                    
                    if [[ "$ctf_choice" == "0" ]]; then
                        break
                    elif [[ "$ctf_choice" =~ ^[1-6]$ ]]; then
                        while show_ctf_tools_menu "$ctf_choice"; do :; done
                    else
                        echo "Invalid choice, try again."
                        sleep 1
                    fi
                done
                ;;
            *)
                # General Tools menu
                while show_tools_menu "${selected_categories[@]}"; do :; done
                ;;
        esac
    done
done
