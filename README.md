# Alex's Dotfiles
My configuration environment for Linux Ubuntu 24.04.4 LTS

## Installation

### 1. Clone the Repository
```
git clone --recurse-submodules https://github.com/alexeum/dotfiles ~/.dotfiles
````

### 2. Clean Default Configs
Delete any default config files so symlinks can be created.
```
rm -rf ~/.zshrc
```

### 3. Run the Install Script
```
cd ~/.dotfiles
./install.sh
```

### Optional: Install Perf via kernel source

```
./install_perf.sh
```
