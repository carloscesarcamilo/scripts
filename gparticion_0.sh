#!/bin/sh
###
### particionar dispositivo de almacenamiento da0
### Establecer variables
drive="da0"
gpartition="/sbin/gpart"
swapsize="4GB"
# elimiar tabla de particiones y crear esquema de particiones (gpt)
  { $gpartition destroy -F $drive && $gpartition create -s gpt $drive; }

$gpartition add   -a 1M -s 10M        -l efi   -t efi          $drive
[ -n "$swapsize" ] && [ "$swapsize" != "0" ] && \
  $gpartition add -a 1M -s $swapsize  -l swap0  -t freebsd-swap $drive
$gpartition add   -a 1M               -l pool_0 -t freebsd-zfs  $drive
############################# EOF ####################################
