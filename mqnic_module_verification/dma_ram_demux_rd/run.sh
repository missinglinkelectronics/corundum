#!/bin/bash

while getopts f flag
do
    case "${flag}" in
	f) rm -rf dma_ram_demux_rd_tb; echo "cleaning up run folder";;
    esac
done


source ../hash_defs.sh

#copy files
git checkout $MQ_PATCH_HASH -- ../../fpga/lib/pcie/rtl/dma_ram_demux_rd.v
cp "../../fpga/lib/pcie/rtl/dma_ram_demux_rd.v" dma_ram_demux_rd_patched.v

git checkout $MQ_ORIGIN_HASH -- ../../fpga/lib/pcie/rtl/dma_ram_demux_rd.v
cp "../../fpga/lib/pcie/rtl/dma_ram_demux_rd.v" .

git reset -- ../../fpga/lib/pcie/rtl/dma_ram_demux_rd.v
git checkout -- ../../fpga/lib/pcie/rtl/dma_ram_demux_rd.v

#rename patched module
sed -i 's/dma_ram_demux_rd/dma_ram_demux_rd_patched/g' dma_ram_demux_rd_patched.v

diff dma_ram_demux_rd_patched.v dma_ram_demux_rd.v

#execute formal verification
sby dma_ram_demux_rd_tb.sby
