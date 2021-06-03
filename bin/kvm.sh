#!/bin/bash

VM_NAME=$1

BASE_XML=/opt/kvm/xml/ovs-base.xml
VM_XML=/opt/vm/xml/$VM_NAME.xml

# create vm
qemu-img create -b /opt/vm/imgs/CentOS-7-x86_64-GenericCloud-2009.qcow2 -f qcow2 /opt/vm/disks/$VM_NAME.qcow2 100G

cp $BASE_XML $VM_XML

sed -i "s/base-vm/$VM_NAME/g" $VM_XML

virsh define  $VM_XML
virsh start $VM_NAME
