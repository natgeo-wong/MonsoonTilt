# **<div align="center">MonsoonTilt</div>**

This repository contains the analysis scripts and output for the **MonsoonTilt** project, which aims to investigate how the axial tilt/obliquity affects the abruptness of the Monsoon Transition.

**Created/Mantained By:** Nathanael Wong (nathanaelwong@fas.harvard.edu)
> Introductory Text Here.

## Current Status

**Isca Experiments**
* [ ] Create experiments (vary axial tilt)
* [ ] Compile Isca model for Aquaplanets

**Experiments**
* [ ] **Control (CON):** Default Earth axial tilt
* [ ] **Axial (AXT-xx):** Vary the axial tilt / obliquity
* [ ] **Slab Depth (SLB-xx):** Vary the depth of the ocean slab / heat capacity

## Project Setup

In order to obtain the relevant data, please follow the instructions listed below:

### 1) Required Julia Dependencies

The entire codebase of this project (except for the Isca model) is written in Julia.  If the data files are downloaded, you should be able to produce my results in their entirety.  The following are the most important Julia packages that were used in this project:
* NetCDF Data Handling: `NCDatasets.jl`
* Isca Output Data Handling: `ClimateIsca.jl`

In order to reproduce the results, first you have to clone the repository, and instantiate the project environment in the Julia REPL in order to install the required packages:
```
git clone https://github.com/natgeo-wong/MonsoonTilt.git
] activate .
instantiate
```

## **Other Acknowledgements**
> Project Repository Template generated using [DrWatson.jl](https://github.com/JuliaDynamics/DrWatson.jl) created by George Datseris.\
