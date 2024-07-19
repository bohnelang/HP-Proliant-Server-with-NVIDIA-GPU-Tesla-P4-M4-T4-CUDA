# A craft project: Building a small GPU server with a HP Proliant and passively cooled NVIDIA Tesla cards like M4, P4 or T4 

## Installing NVIDIA driver (on Ubuntu Linux 24 LTS)
**First remove NVIDIA distro packages:**

```
apt-get remove --purge '^nvidia-.*' --yes
apt-get remove --purge '^libnvidia-.*' --yes
apt-get remove --purge '^cuda-.*' --yes
apt autoremove --yes

# Important:
reboot

# Now no NVIDIA modules and packages should be in the system:
lsmod | grep nvidia

# maybe you need to remove some packages manually
dpkg -l | grep -i nvidia 
```
**Then:**
**Edit**/etc/modprobe.d/blacklist-nvidia.conf and add this lines:
```
blacklist vga16fb
blacklist rivafb
blacklist nvidiafb
blacklist rivatv
blacklist nouveau
options nouveau modeset=0
options nvidia NVreg_EnableGPUFirmware=0**
```

Then run **update-initramfs -u**

and **reboot**

**Ubuntu only: Add a meta repository with NVIDIA drivers:**
```
add-apt-repository ppa:graphics-drivers/ppa --yes
apt update
```


**With there two packages I could interface the two Tesla cards:**
```
apt-cache search ^nvidia |  grep -i metapackage 

apt-get install nvidia-headless-550
apt-get install nvidia-utils-550
```


(Other ways:  https://linuxconfig.org/how-to-install-nvidia-drivers-on-ubuntu-24-04)


**Test driver installation:**
```
# This command should work 
nvidia-smi 
```
If you have a working configuration you maybe want to forbid the automatic update of this package:
```
apt-mark hold nvidia-headless-550
apt-mark hold nvidia-utils-550
apt-mark hold nvidia-dkms-550
```

**Trouble shooting:**
```
Mixing driver packages causes this:
> nvidia-smi 
Failed to initialize NVML: Driver/library version mismatch

Check:
cat /proc/driver/nvidia/version

cat /var/log/dpkg.log|grep nvidia

And start again from zero ...
```
