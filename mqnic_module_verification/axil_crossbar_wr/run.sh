#!/bin/bash

while getopts f flag
do
    case "${flag}" in
	f) rm -rf axil_crossbar_wr; echo "cleaning up run folder";;
    esac
done

source ../hash_defs.sh

#copy files
git checkout $MQ_PATCH_HASH -- ../../fpga/lib/axi/rtl/axil_crossbar_wr.v
cp "../../fpga/lib/axi/rtl/axil_crossbar_wr.v" axil_crossbar_wr_patched.v

git checkout $MQ_ORIGIN_HASH -- ../../fpga/lib/axi/rtl/axil_crossbar_wr.v
cp "../../fpga/lib/axi/rtl/axil_crossbar_wr.v" .

git reset -- ../../fpga/lib/axi/rtl/axil_crossbar_wr.v
git checkout -- ../../fpga/lib/axi/rtl/axil_crossbar_wr.v

cp "../../fpga/lib/axi/rtl/axil_register_wr.v" .
cp "../../fpga/lib/axi/rtl/arbiter.v" .
cp "../../fpga/lib/axi/rtl/arbiter.v" .
cp "../../fpga/lib/axi/rtl/axil_crossbar_addr.v" .
cp "../../fpga/lib/axi/rtl/priority_encoder.v" .

diff axil_crossbar_wr_patched.v axil_crossbar_wr.v

#rename patched module
sed -i 's/axil_crossbar_wr/axil_crossbar_wr_patched/g' axil_crossbar_wr_patched.v

#remove incompatible display string(not accepted by yosys)
sed -i 's/display("%2d (%2d): %x \/ %02d -- %x-%x"/display("replaced"/g' axil_crossbar_addr.v

#execute formal verification
sby axil_crossbar_wr.sby
