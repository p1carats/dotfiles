#!/bin/sh

echo "Picarats's config installer"
echo "Config will be installed on : $HOSTNAME"

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root (sudo)"
    exit 1
fi

# Config pacman
echo "Configuring pacman..."
sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/g' /etc/pacman.conf
sudo sed -i 's/#Color/Color/g' /etc/pacman.conf
sudo sed -i 's/#ILoveCandy/ILoveCandy/g' /etc/pacman.conf

# Update system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install paru
echo "Installing paru..."
sudo pacman -S git base-devel --noconfirm
git clone https://aur.archlinux.org/paru.git && cd paru
makepkg -si --noconfirm
cd ..
rm -rf paru # Clean up

# Config shell
echo "Switching to zsh..."
sudo paru -S zsh --noconfirm
chsh -s /bin/zsh
echo "Installing oh-my-zsh and plugins..."
sudo paru -S oh-my-zsh-git zsh-fast-syntax-highlighting zsh-autosuggestions --noconfirm
echo "Installing starship..."
sudo paru -S starship --noconfirm
echo "eval \"\$(starship init zsh)\"" >> ~/.zshrc

# Install needed packages
echo "Installing needed packages..."
sudo paru -S hyprland-git waybar-hyprland-git swww wofi mako wlogout swaylock-effects brightnessctl hyprpicker kitty nwg-look --noconfirm

# Install fonts and themes
echo "Installing fonts and themes..."
sudo paru -S ttf-jetbrains-mono-nerd noto-fonts-emoji papirus-icon-theme --noconfirm

# Install applications
echo "Installing user applications..."
sudo paru -S brave-bin visual-studio-code-bin webcord spotify-launcher spicetify --noconfirm 

# Setting up a greeter
echo "Setting up greetd..."
sudo paru -S greetd --noconfirm
sudo systemctl enable greetd

# Setting up Hyprland
echo "Setting up Hyprland..."
ln -s hyprland "$dist_dir"
ln -s wrappedhl ~/.local/bin

# config waybar
echo "Configuring waybar..."
ln -s waybar "$dist_dir"

# config mako
echo "Configuring mako..."
ln -s mako "$dist_dir"

# config wofi
echo "Configuring wofi..."
ln -s wofi "$dist_dir"

# config wlogout
echo "Configuring wlogout..."
ln -s wlogout "$dist_dir"

# config kitty
echo "Configuring kitty..."
ln -s kitty "$dist_dir"

# Config grub theme
# WIP

# Enable electron flags
echo "Enabling Wayland electron flags..."
cp electron-flags.conf ~/.config/electron-flags.conf
cp electron-flags.conf ~/.config/code-flags.conf

# WebCord catppuccin theming
echo "Configuring WebCord..."
# WIP

# Spotify theming
echo "Configuring Spotify using Spicetify..."
# WIP

# Done
exit 0