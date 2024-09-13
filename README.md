# Automated macOS installer ~ Hackintosh 🔥

This tool help you cut the hectic procedure to flash the DMG/ISO for every updates or clean install. this tool will automate the process of burning DMG/ISO files into the USB and also create it Bootable by copying essential files and EFI. 

  ![abc_2-removebg-preview](https://github.com/user-attachments/assets/78b29f06-2dcd-4b26-b078-dfd5e4d23638) 


## SUPPORT:
Any MacOS Version from
MacOS Mojave (10.14) ➡ MacOS Sonoma (14.0)
## NOTE, before proceeding:
- `This tool will only work on Linux & macOS. For Windows, please use Linux-VM, NO WSL!`

- `Works on any Linux-Distro`

- `Tool provides Generic EFI folder, but you may use custom EFI folder`
## Requirements
Make sure you have pre-installed all of this in order for this tool to work;
- USB (16 gb or more)
- Mid-End / High-End Machine (Recommended min 6 cores),as tool uses heavy **CPU resources.**
 
~ if running on `Linux` (~ Debian Recommended)
- Hfsprogs ➡  For partitioning of USB in hfs+
- fdisk ➡  For disk/USB operations 
- Peazip (https://peazip.github.io/peazip-64bit.html)  ➡ For extraction and decompression 
________
### Note : The process of Installing above requisites is different in different linux distros, Kindly follow your steps to install it and come back after doing so.

~ if running on `MacOS`
- no prerequisites 


## Running this tool

Dividing this section as per OS;

- **MacOS** 

If you are lucky to have a friend with macOS , you may directly run the `macos_installer.command` script from  [releases](https://github.com/Cdude1909/Automated-MacOS-Installer/releases/). 

simply,  

```
chmod +x /path/to/macos-installer.command
sudo /path/to/macos-installer.command
```
- **Linux**

In order to run this tool , make sure **you have installed the requirements.**
Now lets get started,

### Step 1) Downlaod `main_files.arc` from [releases](https://github.com/Cdude1909/Automated-MacOS-Installer/releases/)
 Using `Peazip` extract the `main_files.arc` (Have some ☕️, it will take time!)
### Step 2) Make script executable and run it
Note: 
***Make sure not to alter the file structure downloaded from 
[releases](https://github.com/Cdude1909/Automated-MacOS-Installer/releases/), as tool is dependent upon those files.***


```
cd /path/to/installer.sh
sudo chmod +x installer.sh
sudo sh ./installer.sh
```
### Step 3) Provide input accordingly
 Now you need to provide **Input** such as  `USB DEVICE` ,`DMG/ISO Location`
### Step 4) Selection for EFI 
 Finally , it will ask for **CUSTOM EFI** or **GENERIC EFI** ,
 you can opt accordingly.
 for GENERIC EFI , you need to know your `CPU NAME`, don't worry i've got you covered! 
 #### CPU Model Names (**INTEL**)

| CPU             | Name                                                                |
| ----------------- | ------------------------------------------------------------------ |
| 2nd GEN| Sandy-Bridge|
| 3rd GEN| Ivy-Bridge|
| 4th GEN| Haswell|
| 5th GEN| Broadwell|
| 6th GEN| SkyLake |
| 7th GEN| KabyLake|
| 8th GEN| CoffeeLake|
| 9th GEN| CoffeeLake-Refresh|
| 10th GEN| CometLake|
|11th GEN| TigerLake|
|12th GEN| AlderLake|
|13th GEN| RaptorLake|
|14th GEN| MeteorLake|

#### For `AMD` Users, Generic EFI folder is available for 
- THREADRIPPER
- Ryzen
- Jaguar
- BullDozer 

### Step 5) Wuhu! its done 🎊
Now the flashing process will start. you may again have some ☕️.

Finalization: The script will get completed and    
VOILA! you now have a **MacOS Bootable USB** for Non-Apple Devices.🔥

**Now just reboot device and Select USB from boot-menu and OC will boot!**


## Screenshots

TESTED ON LINUX MINT CINNAMON :   
 
 **WORKING of script**
 
![vid1](https://github.com/user-attachments/assets/811d7c26-ba81-4529-84c5-11cd66db36eb)  

 **CPU selection for EFI**    
![img1](https://github.com/user-attachments/assets/916cd511-e037-4b12-9b96-db4eea9c70d1)         

**Selection of USB for flashing**
![img2](https://github.com/user-attachments/assets/bbcf7e72-3684-45d0-ac89-d488d40b0e37)


## QUERY
- if there's any issue, you may pull an issue with the screenshot.
- the Generic EFI Provided will be able to boot most of all devices. if it doesn't boot ,you need to do advanced troubleshooting.
- visit forums like [olarila.com](https://olarila.com),[dortania-opencore](https://dortania.github.io/OpenCore-Install-Guide/troubleshooting/troubleshooting.html),[tonymacx86](https://www.tonymacx86.com) for booting related issues.
