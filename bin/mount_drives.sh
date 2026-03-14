#!/bin/bash

# Check if script is run as root (sudo)
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root (use sudo)."
  exit 1
fi

# Create mount directories
echo "Creating mount directories..."
mkdir -p /mnt/storage
mkdir -p /mnt/linux
mkdir -p /mnt/cos
mkdir -p /mnt/efi
mkdir -p /mnt/ssd

# Update /etc/fstab with UUIDs
echo "Updating /etc/fstab..."

# Get UUIDs for all relevant partitions
UUID_SDA2=$(blkid -s UUID -o value /dev/sda2)
UUID_SDB1=$(blkid -s UUID -o value /dev/sdb1)
UUID_SDC1=$(blkid -s UUID -o value /dev/sdc1)
UUID_SDD1=$(blkid -s UUID -o value /dev/sdd1)
UUID_SDD2=$(blkid -s UUID -o value /dev/sdd2)
UUID_NVME0N2=$(blkid -s UUID -o value /dev/nvme0n1p2)

# Backup /etc/fstab before editing
cp /etc/fstab /etc/fstab.bak

# Add entries for all partitions in /etc/fstab
cat <<EOF >>/etc/fstab

# Mount NTFS partitions
UUID=$UUID_SDA2  /mnt/big        ntfs-3g  defaults  0  0
UUID=$UUID_SDB1  /mnt/storage    ntfs-3g  defaults  0  0
UUID=$UUID_SDC1  /mnt/linux      ntfs-3g  defaults  0  0

# Mount ISO and EFI partitions
UUID=$UUID_SDD1  /mnt/cos        iso9660  defaults  0  0
UUID=$UUID_SDD2  /mnt/efi        vfat     defaults  0  0

# Mount NTFS SSD partition
UUID=$UUID_NVME0N2 /mnt/ssd      ntfs-3g  defaults  0  0
EOF

# Test mount all filesystems
echo "Testing mount of all filesystems..."
mount -a

# Verify mounts
echo "Verifying mounts..."
ls /mnt/storage /mnt/linux /mnt/cos /mnt/efi /mnt/ssd

echo "Script completed successfully."
