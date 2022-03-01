#!/bin/bash

while getopts f flag
do
    case "${flag}" in
	f) rm -rf queue_manager; echo "cleaning up run folder";;
    esac
done


source ../hash_defs.sh

#copy files
git checkout $MQ_PATCH_HASH -- ../../fpga/common/rtl/queue_manager.v
cp "../../fpga/common/rtl/queue_manager.v" queue_manager_patched.v

git checkout $MQ_ORIGIN_HASH -- ../../fpga/common/rtl/queue_manager.v
cp "../../fpga/common/rtl/queue_manager.v" .

git reset -- ../../fpga/common/rtl/queue_manager.v
git checkout -- ../../fpga/common/rtl/queue_manager.v

#rename patched module
sed -i 's/queue_manager/queue_manager_patched/g' queue_manager_patched.v

#yosys seems to have trouble with the way the memory is initialized - zero it out using the reset
sed -i 's/if (rst) begin/if (rst) begin\n        for (i = 0; i < QUEUE_COUNT; i = i + 1) queue_ram\[i\] = 0;/g' queue_manager_patched.v
sed -i 's/if (rst) begin/if (rst) begin\n        for (i = 0; i < QUEUE_COUNT; i = i + 1) queue_ram\[i\] = 0;/g' queue_manager.v

diff queue_manager_patched.v queue_manager.v

#execute formal verification
sby queue_manager.sby
