#!/usr/bin/env bash
echo -e "\033[48;5;15m\033[30m"
cd "$(dirname "$0")"
printf "\033[8;40;100t"
cat lion.txt
echo;
echo "Enter your Password for future root needs!"
sudo echo;
echo Press Enter key to continue...
read inp
clear
echo -e "\033[30m"
list_usb_drives() {	
    echo "Available USB drives:"
    diskutil list | grep "external, physical"
}


select_usb_drive() {
    list_usb_drives
    echo ""
    read -p "Enter the identifier of the USB drive (e.g., disk2): " usb_drive
    echo "You selected: $usb_drive"
}

select_dmg_file() {
    echo ""
    read -p "Enter the full path to the macOS .dmg file: " dmg_file
    echo "You selected: $dmg_file"
    
}

create_bootable_usb() {
    echo ""
    echo "Creating bootable USB drive..."
    hdiutil attach "$dmg_file" -mountpoint /Volumes/InstallDMG -nobrowse -noverify
    createInstallMediaPath=$(find /Volumes/InstallDMG -name createinstallmedia -type f)
    diskutil eraseDisk HFS+ USB /dev/$usb_drive
    echo "it may take a while, verifying .dmg file"
    sudo "$createInstallMediaPath" --volume "/Volumes/USB" --nointeraction
    hdiutil detach "$dmg_file" -quiet
    echo "Now Placing EFI files..."
    diskutil eraseVolume "MS-DOS FAT32" "EFI_USB" /dev/${usb_drive}s1
    sudo cp -rv EFI /Volumes/EFI_USB
    echo "EFI files successfully placed!"
}
echo "Welcome to the macOS Bootable USB Creator Script"
echo ""

select_usb_drive
select_dmg_file
create_bootable_usb

echo ""
echo "Done! You can now use the USB drive to install macOS."
