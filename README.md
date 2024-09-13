
# Automated macOS installer ~ Hackintosh 🔥


This tool help you cut the hectic procedure to flash the DMG/ISO for every updates or clean install. this tool will automate the process of burning DMG/ISO files into the USB and also create it Bootable by copying essential files and EFI. 

## SUPPORT:
Any MacOS Version from
MacOS Mojave (10.14) ➡ MacOS Sonoma (14.0)
## NOTE, before proceeding:
- `This tool will only work on Linux & macOS. For Windows, please use Linux-VM, NO WSL!`

- `Works on any Linux-Distro`

- `Tool provides Generic EFI fodler, but you may use custom EFI folder`
## Requirements
Make sure you have pre-installed all of this in order for this tool to work;
- USB (16 gb or more)
- Mid-End / High-End Machine (Recommended),as tool uses heavy **CPU resources.**
 
~ if running on `Linux`
- Hfsprogs ➡  For partitioning of USB in hfs+
- fdisk ➡  For disk/USB operations 
- Peazip (https://peazip.github.io/peazip-64bit.html)  ➡ For extraction and decompression 

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

### Step 1)
 Using `Peazip` extract the `main_files.arc` (Have some ☕️, it will take time!)
### Step 2)
Note: 
***Make sure not to alter the file structure downloaded from 
[releases](https://github.com/Cdude1909/Automated-MacOS-Installer/releases/), as tool is dependent upon those files.***


```
cd /path/to/installer.sh
sudo chmod +x installer.sh
sudo sh ./installer.sh
```
### Step 3)
 Now you need to provide **Input** such as  `USB DEVICE` ,`DMG/ISO Location`
### Step 4)
 Finally , it will ask for **CUSTOM EFI** or **GENERIC EFI** ,
 you can opt accordingly.
 for GENERIC EFI , you need to know your `CPU NAME`, don't worry i've got you covered! 
 ### CPU Model Names (**INTEL**)

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

### For `AMD` Users, Generic EFI folder is available for 
- THREADRIPPER
- Ryzen
- Jaguar
- BullDozer 

### Step 5)
Now the flashing process will start. you may again have some ☕️.

Finalization: The script will get completed and    
VOILA! you now have a **MacOS Bootable USB** for Non-Apple Devices.🔥


## Screenshots
 **WORKING**
 
https://github.com/user-attachments/assets/811d7c26-ba81-4529-84c5-11cd66db36eb

 **CPU SELECTION FOR EFI**    
![Screenshot_20240913_150730_Samsung Notes](https://github.com/user-attachments/assets/916cd511-e037-4b12-9b96-db4eea9c70d1)      
**Selection of USB for flashing**
![20240913_150801](https://github.com/user-attachments/assets/bbcf7e72-3684-45d0-ac89-d488d40b0e37)

 
