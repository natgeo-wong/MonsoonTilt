# **<div align="center">MonsoonTilt: Investigating parameters affecting Monsoon Transitions across Hemispheres using simple Aquaplanet Models</div>**

This repository contains the analysis scripts and output for the **MonsoonTilt** project, which aims to investigate how parameters such as axial tilt/obliquity affects the abruptness of the Monsoon Transition.

**Created/Mantained By:** Nathanael Wong (nathanaelwong@fas.harvard.edu)
> In this project, I run Aquaplanet GCM simulations with varying axial tilt and ocean slab depth to investigate the dependence of monsoon dynamics and the transition of the Hadley Cell between the equinoctal (eddy-momentum dependent) and soltitial (angular-momentum-conserving) regimes states, and replicate some of the work that was done by Bordoni and Schneider [2008]. We find that regime transitions occur when the slab-ocean heat capacity is low [Geen et al., 2019] and axial-tilt is ≳ 10° [Geen et al., 2020]. Using ITCZ metrics from Adam et al. [2016], we then attempt to characterize the decoupling of the precipitation maximum from the dividing streamline (i.e. the mid-tropospheric zero contour of the streamfunction).

## Progress
**Isca Experiments**
* [x] Create experiments (vary axial tilt)
* [x] Compile Isca model for Aquaplanets

**Experiments**
* [x] **Control (CON):** Default Earth axial tilt
* [x] **Axial (AXT-xx):** Vary the axial tilt / obliquity
* [x] **Slab Depth (SLB-xx):** Vary the depth of the ocean slab / heat capacity

**Reanalysis**
* [x] Download ERA5 data for Asian Summer Monsoon Region (70-100ºE,40ºS-40ºN)
  * [x] Precipitation
  * [x] Sea-Level Air Temperature
* [x] Replicate Figure 1 in Bordoni and Schneider (2008)

**Analysis**
* [x] Prelimiary analysis:
  * [x] Zonal-mean analysis of precipitation data
  * [x] Calculate streamfunction
  * [x] Time-series raw plot of precipitation and streamfunction
* [x] Centroid and Maximum Latitudes (similar to Adams et al. [2016])
  * [x] Calculation of centroid and maximum latitudes
  * [x] Plot gradient of pentad against pentad (similar to Geen at al. [2019])
* [ ] More in-depth analysis:
  * [ ] Characterize double rainfall peak in early period of monsoon
  * [ ] Scaling relationship between intensity of both rainfall peaks with axial tilt / slab depth
  * [ ] Scaling relationship between location of minor rainfall peak with axial tilt

## 0. Motivation

About a decade ago, Schneider and Bordoni [2008] showed that monsoons can occur in a spatially homogeneous Aquaplanet slab/swamp ocean (Fig. 1). Although the dynamics of monsoon systems on Earth are inevitably modified by regional topography and inhomogeneity, they are not truly necessary for monsoons to occur. Instead, it was proposed in Bordoni and Schneider [2008] that monsoons are eddy-mediated transitions between two atmospheric regime states: (1) an **equinoctal regime** where the Hadley circulation is controlled by eddy momentum fluxes, which in turn respond to thermal forcing, and (2) a **solstitial regime** where the Hadley circulation approaches the angular-momentum-conserving limit and therefore its strength directly responds to thermal forcing.

The behaviour of the ITCZ relative to the divid- ing streamline that denotes the boundary between the winter and summer Hadley Cells is also different in both regimes. In the equinoctal regime, the ITCZ is co-located with the dividing streamline. However, in the solstitial regime, the ITCZ gradually decouples from the dividing streamline and is found slightly equatorward, as illustrated in Fig. 2 (see also Geen et al. [2020]). In a method similar to Geen et al. [2019], I aim to investigate parameters in Aquaplanet GCMs, specifically axial tilt and slab-depth, that can affect the transition of idealised Hadley cells from the equinoctal regime to the solstitial regime.

## 1. Isca GCM Experiments

## Installation

To (locally) reproduce this project, do the following:

0. Download this code base. Notice that raw data are typically not included in the
   git-history and may need to be downloaded independently.
1. Open a Julia console and do:
   ```
   julia> ] activate .
    Activating environment at `~/Projects/TropicalRCE/Project.toml`

   (TropicalRCE) pkg> instantiate
   (TropicalRCE) pkg> add GeoRegions#master SAMTools#master
   ```

This will install all necessary packages for you to be able to run the scripts and
everything should work out of the box.

## **Other Acknowledgements**
> Project Repository Template generated using [DrWatson.jl](https://github.com/JuliaDynamics/DrWatson.jl) created by George Datseris.
