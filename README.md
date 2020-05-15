# **<div align="center">MonsoonTilt: Investigating parameters affecting Monsoon Transitions across Hemispheres using simple Aquaplanet Models</div>**

This repository contains the analysis scripts and output for the **MonsoonTilt** project, which aims to investigate how parameters such as axial tilt/obliquity affects the abruptness of the Monsoon Transition.

**Created/Mantained By:** Nathanael Wong (nathanaelwong@fas.harvard.edu)
> Introductory Text Here.

## Current Status

**Isca Experiments**
* [x] Create experiments (vary axial tilt)
* [x] Compile Isca model for Aquaplanets

**Experiments**
* [x] **Control (CON):** Default Earth axial tilt
* [x] **Axial (AXT-xx):** Vary the axial tilt / obliquity
* [x] **Slab Depth (SLB-xx):** Vary the depth of the ocean slab / heat capacity

**Reanalysis**
* [ ] Download ERA5 data for Asian Summer Monsoon Region (70-100ºE,40ºS-40ºN)
  * [ ] Precipitation
  * [ ] Sea-Level Air Temperature
* [ ] Replicate Figure 1 in Bordoni and Schneider (2008)

**Analysis**
* [x] Prelimiary analysis:
  * [x] Zonal-mean analysis of precipitation data
  * [x] Calculate streamfunction
  * [x] Time-series raw plot of precipitation and streamfunction
* [ ] More in-depth analysis:
  * [ ] Characterize double rainfall peak in early period of monsoon
  * [ ] Scaling relationship between intensity of both rainfall peaks with axial tilt / slab depth
  * [ ] Scaling relationship between location of minor rainfall peak with axial tilt

## Project Setup

In order to obtain the relevant data, please follow the instructions listed below:

### 1) Required Julia Dependencies

The entire codebase of this project (except for the Isca model) is written in Julia.  If the data files are downloaded, you should be able to produce my results in their entirety.  The following are the most important Julia packages that were used in this project:
* NetCDF Data Handling: `NCDatasets.jl`
* Isca Output Data Handling: `IscaTools.jl`

In order to reproduce the results, first you have to clone the repository, and instantiate the project environment in the Julia REPL in order to install the required packages:
```
git clone https://github.com/natgeo-wong/MonsoonTilt.git
] activate .
instantiate
```

### 2) Required Python Dependencies

I generally use either the `Seaborn` or `ProPlot` `python` packages to plot my results.  Julia has a native wrapper for `Seaborn`, `Seaborn.jl`.  In this project I mainly use `ProPlot`, which can be installed for the Julia environment using `Conda.jl` and called using `PyCall.jl`.  See the GitHub repositories for `Conda.jl`, `PyCall.jl`, `Seaborn.jl`, and `ProPlot` respectively for more details.
```
using Conda
Conda.add("Proplot",channel="conda-forge")

using PyCall
using LaTeXStrings
pplt = pyimport("proplot");
```

### 3) Data Files

You can generate the data output files for this project by running the `Isca` GCM using the experimental setups found in `exp`.  Remember to set the `GFDL_DATA` directory to `$(prjdir)/data/raw` where `$(prjdir)` is where you have placed the current project repository.

## **Other Acknowledgements**
> Project Repository Template generated using [DrWatson.jl](https://github.com/JuliaDynamics/DrWatson.jl) created by George Datseris.
