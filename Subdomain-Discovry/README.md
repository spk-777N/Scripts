# Subdomain-Discovery Script

## Description

This script is designed for subdomain discovery through various reconnaissance tools. It provides an interactive menu where the user can:

1. Choose a wildcard domain (target for subdomain discovery).
2. Select from a set of tools to run for subdomain enumeration, including:
   - **assetfinder**
   - **crt.sh**
   - **findomain**
   - **knockpy**
   - **subfinder**
   - **sublist3r**

The user can run all tools at once or select specific tools. The results of the subdomain discovery are saved into separate files for each tool, such as `assetfinder-subdomains`, `crt-subdomains`, etc.

The script allows the user to change the wildcard, rerun tools, or exit at any point. It's a useful tool for performing subdomain enumeration in penetration testing and OSINT (Open Source Intelligence) gathering.

## Installation

1. Install The requirements file:

```
git clone https://github.com/spk-777N/Scripts.git
```

## Run Script

1. Install the requirements file:

```
sudo chmod +x requirements.sh
sudo ./requirements.sh
```

2. Run the script:

```
sudo chmod +x subs-discovery.sh
sudo ./subs-discovery.sh
```
