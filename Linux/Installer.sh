#!/bin/bash

# Function to prompt the user for input with drag-and-drop support
prompt_user_input() {
    echo "$1"
    read user_input
    echo "${user_input//\'/}" # Remove single quotes if present in drag-and-drop paths
}

# Function to validate user inputs
validate_input() {
    if [ ! -f "$INSTALLER_DMG" ]; then
        echo "Error: macOS installer file not found at $INSTALLER_DMG"
        exit 1
    fi
    
    if [ ! -d "$EFI_FOLDER" ]; then
        echo "Error: EFI folder not found at $EFI_FOLDER"
        exit 1
    fi
    
    if [ ! -d "$MACOS_VERSIONS_FOLDER" ]; then
        echo "Error: macOS versions folder not found at $MACOS_VERSIONS_FOLDER"
        exit 1
    fi
    
    if [ ! -b "$USB_DEVICE" ]; then
        echo "Error: USB device not found at $USB_DEVICE"
        exit 1
    fi
}

# Function to clean up mounted partitions
cleanup() {
    sudo umount /mnt/usb_efi 2>/dev/null || true
    sudo umount /mnt/usb_hfs 2>/dev/null || true
    rm -rf /tmp/macos_installer_extracted
    sudo rm -rf /mnt/usb_efi
    sudo rm -rf /mnt/usb_hfs
}

# Trap to clean up in case of an exit
trap cleanup EXIT

# Display ASCII art (optional)
clear
echo "\033[48;5;15m\033[30m"
cd "$(dirname "$0")"
printf "\033[8;40;100t"
cat lion.txt
echo;

# Prompt for user inputs with drag-and-drop support
echo "Drag and drop the macOS installer DMG/ISO file here: "
read INSTALLER_DMG
INSTALLER_DMG=$(echo "$INSTALLER_DMG" | sed "s/'//g")

MACOS_VERSIONS_FOLDER="./Essential_files"

# Function to list available USB devices
list_usb_devices() {
    echo "Available storage devices:"
    lsblk -dpno NAME,SIZE | grep -E "/dev/sd|/dev/nvme|/dev/mmcblk"
}

# Function to select USB device with live refresh
select_usb_device() {
    while true; do
        clear
        list_usb_devices
        echo "Enter the USB device path (e.g., /dev/sdb) or 'r' to refresh the list:"
        read -r USB_DEVICE

        if [ "$USB_DEVICE" == "r" ]; then
            continue  # Refresh the list by looping again
        elif [ -b "$USB_DEVICE" ]; then
            echo "Selected USB device: $USB_DEVICE"
            break
        else
            echo "Invalid device. Please try again."
        fi
    done
}

# Call the function to select the USB device
select_usb_device


# Function to handle copying custom EFI folder
copy_custom_efi() {
    echo "Drag and drop the custom EFI folder here: "
    read EFI_FOLDER
    EFI_FOLDER=$(echo "$EFI_FOLDER" | sed "s/'//g")

    validate_input
}

# Function to handle copying generic EFI folder
copy_generic_efi() {
    clear
    echo "Please select your CPU and hardware generation from the list below:"
    echo "1) Intel - 2nd Gen (Sandy Bridge) DESKTOP"
    echo "2) Intel - 2nd Gen (Sandy Bridge) NOTEBOOK"
    echo "3) Intel - 3rd Gen (Ivy Brige) DESKTOP"
    echo "4) Intel - 3rd Gen (Ivy Bridge) NOTEBOOK"
    echo "5) Intel - 4th Gen (Haswell) DESKTOP"
    echo "6) Intel - 4th Gen (Haswell) NOTEBOOK"
    echo "7) Intel - 5th Gen (Broadwell) DESKTOP"
    echo "8) Intel - 5th Gen (Broadwell) NOTEBOOK"
    echo "9) Intel - 6th Gen (SkyLake) DESKTOP"
    echo "10) Intel - 6th Gen (SkyLake) NOTEBOOK"
    echo "11) Intel - 6th Gen (SkyLake) NOTEBOOK *VENTURA SPECIFIC*"
    echo "12) Intel - 7th Gen (KabyLake) DESKTOP"
    echo "13) Intel - 7th Gen (KabyLake) NOTEBOOK"
    echo "14) Intel - 8th Gen / 9th Gen (CoffeeLake) DESKTOP"
    echo "15) Intel - 8th Gen (CoffeeLake / WhiskeyLake) NOTEBOOK"
    echo "16) Intel - 9th Gen (CoffeeLake Refresh) NOTEBOOK"
    echo "17) Intel - 10th Gen (CometLake / IceLake) DESKTOP"
    echo "18) Intel - 10th Gen (CometLake / IceLake) NOTEBOOK"
    echo "19) Intel - 11th Gen (RocketLake) DESKTOP"
    echo "20) Intel - 11th Gen (TigerLake) NOTEBOOK"
    echo "21) Intel - 12th/13th/14th Gen DESKTOP"
    echo "22) Intel - 12th/13th/14th Gen NOTEBOOK"
    echo "23) [HEDT] Intel SandyBridge-E/IvyBridge-E DESKTOP"
    echo "24) [HEDT] Intel Haswell-E DESKTOP"
    echo "25) [HEDT] Intel Broadwell-E DESKTOP"
    echo "26) [HEDT] Intel SkyLake-XW/CascadeLake-XW DESKTOP"
    echo "27) AMD MOBILE"
    echo "28) AMD BULLDOZER/JAGUAR/THREADRIPPER/RYZEN DESKTOP"
    read -p "Enter the number corresponding to your hardware: " cpu_choice

    case $cpu_choice in
        1) EFI_FOLDER="./EFI/Sandy/EFI.OpenCore.Desktop.SandyBridge.MOD/EFI";;
        2) EFI_FOLDER="./EFI/Sandy/EFI.OpenCore.NoteBook.SandyBridge.MOD/EFI";;
        3) EFI_FOLDER="./EFI/Ivy/EFI.OpenCore.Desktop.IvyBridge.MOD/EFI";;
        4) EFI_FOLDER="./EFI/Ivy/EFI.OpenCore.NoteBook.IvyBridge.MOD/EFI";;
        5) EFI_FOLDER="./EFI/Haswell&Broadwell/EFI.Opencore.Desktop.Haswell.Broadwell.MOD/EFI";;
        6) EFI_FOLDER="./EFI/Haswell&Broadwell/EFI.Opencore.NoteBook.Haswell.MOD/EFI";;
        7) EFI_FOLDER="./EFI/Haswell&Broadwell/EFI.Opencore.Desktop.Haswell.Broadwell.MOD/EFI";;
        8) EFI_FOLDER="./EFI/Haswell&Broadwell/EFI.Opencore.NoteBook.Broadwell.MOD/EFI";;
        9) EFI_FOLDER="./EFI/SkyLake/EFI.Opencore.Desktop.SkyLake.MOD/EFI";;
        10) EFI_FOLDER="./EFI/SkyLake/EFI.Opencore.NoteBook.SkyLake.MOD/EFI";;
        11) EFI_FOLDER="./EFI/SkyLake/EFI.Opencore.NoteBook.SkyLake.Ventura.MOD/EFI";;
        12) EFI_FOLDER="./EFI/KabyLake/EFI.Opencore.Desktop.KabyLake.MOD/EFI";;
        13) EFI_FOLDER="./EFI/KabyLake/EFI.Opencore.NoteBook.KabyLake.MOD/EFI";;
        14) EFI_FOLDER="./EFI/CoffeeLake&WhiskeyLake/EFI.Opencore.Desktop.CoffeeLake.MOD/EFI";;
        15) EFI_FOLDER="./EFI/CoffeeLake&WhiskeyLake/EFI.Opencore.NoteBook.Coffee.Lake.Whiskey.Lake.MOD/EFI";;
        16) EFI_FOLDER="./EFI/CoffeeLake Refresh/EFI.OpenCore.NoteBook.Coffee.Lake.Plus.Comet.Lake.MOD/EFI";;
        17) EFI_FOLDER="./EFI/CometLake & IceLake/EFI.Opencore.Desktop.CometLake.MOD/EFI";;
        18) EFI_FOLDER="./EFI/CometLake & IceLake/EFI.Opencore.NoteBook.IceLake.MOD/EFI";;
        19) EFI_FOLDER="./EFI/TigerLake&RocketLake/EFI.Opencore.Desktop.RocketLake.MOD/EFI";;
        20) EFI_FOLDER="./EFI/TigerLake&RocketLake/EFI.Opencore.NoteBook.TigerLake.MOD/EFI";;
        21) EFI_FOLDER="./EFI/12,13,14/EFI.OpenCore.Alder.Raptor.Lake.MOD/EFI";;
        22) EFI_FOLDER="./EFI/12,13,14/EFI.Opencore.NoteBook.12.13.14.Gen.MOD/EFI";;
        23) EFI_FOLDER="./EFI/HEDT/EFI.Opencore.Desktop.HEDT.Sandy.Bridge-E.Ivy.Bridge-E.MOD/EFI";;
        24) EFI_FOLDER="./EFI/HEDT/EFI.Opencore.Desktop.HEDT.Haswell-E.MOD/EFI";;
        25) EFI_FOLDER="./EFI/HEDT/EFI.Opencore.Desktop.HEDT.Broadwell-E.MOD/EFI";;
        26) EFI_FOLDER="./EFI/HEDT/EFI.Opencore.Desktop.HEDT.Skylake-XW.Cascade.Lake-XW.MOD/EFI";;
        27) EFI_FOLDER="./EFI/AMD/EFI.AMD.Mobile.MOD/EFI";;
        28) EFI_FOLDER="./EFI/AMD/EFI.OpenCore.Desktop.Bulldozer.Jaguar.Ryzen.Threadripper.MOD/EFI";;
        *) echo "Invalid option selected. Exiting..."; exit 1;;
    esac

    if [ ! -d "$EFI_FOLDER" ]; then
        echo "Error: EFI folder not found at $EFI_FOLDER"
        exit 1
    fi
}

# Menu-driven interface
clear
echo "Please choose an option:"
echo "1) Use custom EFI folder"
echo "2) Use generic EFI folder based on CPU"

read -p "Enter your choice: " choice

case $choice in
    1) copy_custom_efi;;
    2) copy_generic_efi;;
    *) echo "Invalid option selected. Exiting..."; exit 1;;
esac

# Confirm user input
clear
echo "You have selected the following:"
echo "macOS Installer: $INSTALLER_DMG"
echo "USB Device: $USB_DEVICE"
read -p "Are these correct? (y/n): " confirm

if [ "$confirm" != "y" ]; then
    echo "User canceled the operation."
    exit 1
fi

# Validate user inputs
validate_input

# Define partition sizes
EFI_SIZE_MB=200
HFS_VOLUME_NAME="Install macOS"

# Unmount all partitions on the USB device
echo "Unmounting all partitions on the USB device..."
sudo umount "${USB_DEVICE}"* 2>/dev/null

# Create GPT partition table
echo "Creating GPT partition table on the USB device..."
(
echo g      # Create a new empty GPT partition table
echo n      # Add a new partition
echo 1      # Partition number 1 (EFI)
echo        # First sector (Accept default: 2048)
echo +200M  # Last sector (+200M size)
echo t      # Change partition type
echo 1      # Partition type for partition 1
echo ef     # EFI System
echo n      # Add a new partition
echo 2      # Partition number 2 (APFS)
echo        # First sector (Accept default)
echo        # Last sector (Accept default: rest of the disk)
echo t      # Change partition type
echo 2      # Select partition 2
echo 48465300-0000-11AA-AA11-00306543ECAC     # Set partition type to AF00 (Apple APFS)
echo w      # Write changes
) | sudo fdisk "$USB_DEVICE"

clear
echo "\033[30m"
echo;
printf "\033[107m"
# Format the partitions
echo "Formatting EFI partition as FAT32..."
sudo mkfs.vfat -F32 -n EFI "${USB_DEVICE}1"

echo "Formatting HFS+ partition..."
sudo mkfs.hfsplus -v "$HFS_VOLUME_NAME" "${USB_DEVICE}2"

# Mount the partitions
echo "Mounting the EFI partition..."
sudo mkdir -p /mnt/usb_efi
sudo mount "${USB_DEVICE}1" /mnt/usb_efi

echo "Mounting the HFS+ partition..."
sudo mkdir -p /mnt/usb_hfs
sudo mount "${USB_DEVICE}2" /mnt/usb_hfs

# Copy EFI folder content
echo "Copying EFI folder content to EFI partition..."
sudo cp -r "$EFI_FOLDER/" /mnt/usb_efi/EFI/

# Extract the macOS installer
echo "Extracting macOS installer..."
mkdir -p /tmp/macos_installer_extracted
'/usr/lib/peazip/res/bin/7z/7z' x -aos '-o/tmp/macos_installer_extracted' -bb0 -bse0 -bsp2 -sccUTF-8 "$INSTALLER_DMG"

# Locate the Install macOS .app directory within the extracted files
MACOS_APP_PATH=$(find /tmp/macos_installer_extracted -name "Install macOS*.app" -type d | head -n 1)

if [ -z "$MACOS_APP_PATH" ]; then
    echo "Error: Could not find the Install macOS .app in the extracted contents. Make sure the .dmg is properly structured."
    exit 1
fi
INFO_PLIST="$MACOS_APP_PATH/Contents/Info.plist"

if [ ! -f "$INFO_PLIST" ]; then
    echo "Error: Info.plist not found in $MACOS_APP_PATH"
    exit 1
fi

# Extract macOS version using grep and awk
MACOS_VERSION=$(grep -A1 '<key>CFBundleDisplayName</key>' "$INFO_PLIST" | awk -F'<|>' '/string/{print $3}')

if [ -z "$MACOS_VERSION" ]; then
    echo "Error: Could not detect macOS version from the .app bundle."
    exit 1
fi

echo "Detected macOS version: $MACOS_VERSION"
# Check if a folder exists for this macOS version
if [ -d "$MACOS_VERSIONS_FOLDER/$MACOS_VERSION" ]; then
    echo "Found matching folder for macOS version: $MACOS_VERSION"
    
    # Copy the contents from the matched folder to the EFI partition
    echo "Copying essential macOS version files to HFS+ partition..."
    sudo rsync -rh --info=progress2 --no-i-r --include='[^.]*' "$MACOS_VERSIONS_FOLDER/$MACOS_VERSION/"* "/mnt/usb_hfs/"
    sudo cp "$MACOS_VERSIONS_FOLDER/$MACOS_VERSION/.IAPhysicalMedia" "/mnt/usb_hfs"
    sudo cp "$MACOS_VERSIONS_FOLDER/$MACOS_VERSION/.metadata_never_index" "/mnt/usb_hfs"
    sudo cp "$MACOS_VERSIONS_FOLDER/$MACOS_VERSION/.VolumeIcon.icns" "/mnt/usb_hfs"
else
    echo "No matching folder found for macOS version: $MACOS_VERSION"
    echo "Proceeding without additional files."
fi

# Copy macOS installer to the HFS+ partition
echo "Copying macOS installer to the HFS+ partition..."
sudo rsync -ah --info=progress2 --no-i-r "$MACOS_APP_PATH" /mnt/usb_hfs/

# Cleanup and unmount partitions
echo "Cleaning up, It may take a while..."
cleanup

echo "macOS bootable USB creation complete."

