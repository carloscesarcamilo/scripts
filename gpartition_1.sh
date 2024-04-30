#!/bin/sh
###
### particionar disco da0
###
efisize=260M
drive="da0"
gpartition="/sbin/gpart"
swapsize=4GB
  { $gpartition destroy -F $drive && $gpartition create -s gpt $drive; }

# particion de arranque efi
$gpartition add   -a 1M -s $efisize           -l efi0   -t efi $drive

# crear la swap si swapsize existe y es diferente de cero
[ -n "$swapsize" ] && [ "$swapsize" != "0" ] && \
  $gpartition add -a 1M -s $swapsize  -l swap0  -t freebsd-swap $drive

# resto del disto freebsd-zfs
$gpartition add   -a 1M               -l pool_0 -t freebsd-zfs  $drive
################################# EOF ################################
