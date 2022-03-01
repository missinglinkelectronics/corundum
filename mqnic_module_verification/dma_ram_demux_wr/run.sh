#!/bin/bash

while getopts f flag
do
    case "${flag}" in
	f) rm -rf dma_ram_demux_wr_tb; echo "cleaning up run folder";;
    esac
done

source ../hash_defs.sh

#copy files
git checkout $MQ_PATCH_HASH -- ../../fpga/lib/pcie/rtl/dma_ram_demux_wr.v
cp "../../fpga/lib/pcie/rtl/dma_ram_demux_wr.v" dma_ram_demux_wr_patched.v

git checkout $MQ_ORIGIN_HASH -- ../../fpga/lib/pcie/rtl/dma_ram_demux_wr.v
cp "../../fpga/lib/pcie/rtl/dma_ram_demux_wr.v" .

git reset -- ../../fpga/lib/pcie/rtl/dma_ram_demux_wr.v
git checkout -- ../../fpga/lib/pcie/rtl/dma_ram_demux_wr.v

#rename patched module
sed -i 's/dma_ram_demux_wr/dma_ram_demux_wr_patched/g' dma_ram_demux_wr_patched.v

diff dma_ram_demux_wr_patched.v dma_ram_demux_wr.v

#execute formal verification
sby dma_ram_demux_wr_tb.sby
