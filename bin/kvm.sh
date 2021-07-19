#!/bin/bash

VM_NAME=$1

BASE_XML=/opt/kvm/xml/ovs-base.xml
VM_XML=/opt/vm/xml/$VM_NAME.xml

VM_IMG=/opt/vm/disks/$VM_NAME.qcow2

BASE_IMG=/opt/vm/imgs/rocky_x86_64.qcow2

CLOUD_INIT=/opt/vm/cloud-init/cloud-init.iso

# create vm
# qemu-img create -b /opt/vm/imgs/CentOS-7-x86_64-GenericCloud-2009.qcow2 -f qcow2 /opt/vm/disks/$VM_NAME.qcow2 100G
qemu-img create -b $BASE_IMG  -f qcow2 $VM_IMG 100G


cloud-localds -v --network-config=/opt/kvm/cloud-init/network_config_static.cfg $CLOUD_INIT   /opt/kvm/cloud-init/cloud.cfg

cp $BASE_XML $VM_XML

sed -i "s#vm-name#$VM_NAME#g" $VM_XML
sed -i "s#vm-img#$VM_IMG#g" $VM_XML
sed -i "s#base-img#$BASE_IMG#g" $VM_XML
sed -i "s#cloud-init#$CLOUD_INIT#g" $VM_XML

virsh define  $VM_XML
virsh start $VM_NAME
