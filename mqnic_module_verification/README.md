# Formal Verification for Intel MLAB Fixes

## Introduction

This folder adds the counterpart to our work which fixes the RTL structure for certain modules in order to implement RAM structures in MLABs on Intel chips. To make sure that we do not introduce logic errors into the project. We therefore use this method based on the Yosys toolchain to mathematically proof functional equivalence of the particular modules using formal verification.

Formal verification is available for all modules which we have patched:

* axil_crossbar_wr.v
* axil_crossbar_rd.v
* dma_ram_demux_wr.v
* dma_ram_demux_rd.v
* queue_manager.v
* cpl_queue_manager.v


## How-To

**ATTENTION**: The workflow uses Git in order to check out and compare two different versions of a particular file. The bash script 'hash_defs.sh' defines two different git hashs. MAKE SURE these hash values point to correct git states(before and after the changes). The following prerequisites have to be installed in order to execute formal verification (It's all open-source):

* Yosis (Open source FPGA toolchain for synthesis as well as formal verification)
* Symbiosis (Wrapper around Yosys which supports different methods of formal verification)
* Yices (A linear equation solver)

The formal verification in this repository has been succesfully executed using these exact versions(other combinations may work as well but no guarantee here):

* Yosys v.0.13
* Symbiosis - build version: v20220112-g02a5b71
* Yices 2.6.4

In order to execute formal verification for a particular module just go to the particular folder and execute run.sh (e.g you want to proof equivalence of the module axil_crossbar_wr.v, simply navigate to the folder axil_crossbar_wr and execute run.sh)
