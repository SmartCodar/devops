#!/bin/bash

# Function to install kubectl
install_kubectl() {
    echo "Installing kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x ./kubectl
    mv ./kubectl /usr/local/bin/kubectl
    echo "kubectl installed successfully."
}

# Function to install kubens and kubectx
install_kubens() {
    echo "Installing kubens and kubectx..."
    git clone https://github.com/ahmetb/kubectx.git ~/.kubectx
    sudo ln -s ~/.kubectx/kubectx /usr/local/bin/kubectx
    sudo ln -s ~/.kubectx/kubens /usr/local/bin/kubens
    echo "kubens and kubectx installed successfully."
}

# Function to install helm
install_helm() {
    echo "Installing Helm..."
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    echo "Helm installed successfully."
}

# Function to install eksctl
install_eksctl() {
    echo "Installing eksctl..."
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    sudo mv /tmp/eksctl /usr/local/bin
    echo "eksctl installed successfully."
}

# Reinstall kubectl if it exists
if kubectl version --client; then
    echo "kubectl is already installed. Uninstalling..."
    sudo rm -f /usr/local/bin/kubectl
    install_kubectl
else
    install_kubectl
fi

# Reinstall kubens if it exists
if [ -x "$(command -v kubens)" ]; then
    echo "kubens is already installed. Uninstalling..."
    sudo rm -f /usr/local/bin/kubectx /usr/local/bin/kubens
    rm -rf ~/.kubectx
    install_kubens
else
    install_kubens
fi

# Reinstall Helm if it exists
if helm version; then
    echo "Helm is already installed. Uninstalling..."
    sudo rm -f /usr/local/bin/helm
    install_helm
else
    install_helm
fi

# Reinstall eksctl if it exists
if eksctl version; then
    echo "eksctl is already installed. Uninstalling..."
    sudo rm -f /usr/local/bin/eksctl
    install_eksctl
else
    install_eksctl
fi
