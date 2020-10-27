# **<div align="center">MonsoonTilt: Investigating parameters affecting Monsoon Transitions across Hemispheres using simple Aquaplanet Models</div>**

This repository contains the analysis scripts and output for the **MonsoonTilt** project, which aims to investigate how parameters such as axial tilt/obliquity affects the abruptness of the Monsoon Transition.

**Created/Mantained By:** Nathanael Wong (nathanaelwong@fas.harvard.edu)
> In this project, I run Aquaplanet GCM simulations with varying axial tilt and ocean slab depth to investigate the dependence of monsoon dynamics and the transition of the Hadley Cell between the equinoctal (eddy-momentum dependent) and soltitial (angular-momentum-conserving) regimes states, and replicate some of the work that was done by Bordoni and Schneider [2008]. We find that regime transitions occur when the slab-ocean heat capacity is low [Geen et al., 2019] and axial-tilt is ≳ 10° [Geen et al., 2020]. Using ITCZ metrics from Adam et al. [2016], we then attempt to characterize the decoupling of the precipitation maximum from the dividing streamline (i.e. the mid-tropospheric zero contour of the streamfunction).

A full writeup of the project in it's current state (as of July 2020) can be found in `papers/12810_finalreport_nathanaelwong.pdf`

## Progress
* [x] Isca Experiments**
  * [x] Compile Isca model for Aquaplanets
  * [x] **Control (CON):** Default Earth axial tilt
  * [x] **Axial (AXT-xx):** Vary the axial tilt / obliquity
  * [x] **Slab Depth (SLB-xx):** Vary the depth of the ocean slab / heat capacity

* [x] Download ERA5 data for Asian Summer Monsoon Region (70-100ºE,40ºS-40ºN)
  * [x] Precipitation
  * [x] Sea-Level Air Temperature
  * [x] Replicate Figure 1 in Bordoni and Schneider (2008)

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

About a decade ago, Schneider and Bordoni [2008] showed that monsoons can occur in a spatially homogeneous Aquaplanet slab/swamp ocean. Although the dynamics of monsoon systems on Earth are inevitably modified by regional topography and inhomogeneity, they are not truly necessary for monsoons to occur. Instead, it was proposed in Bordoni and Schneider [2008] that monsoons are eddy-mediated transitions between two atmospheric regime states: (1) an **equinoctal regime** where the Hadley circulation is controlled by eddy momentum fluxes, which in turn respond to thermal forcing, and (2) a **solstitial regime** where the Hadley circulation approaches the angular-momentum-conserving limit and therefore its strength directly responds to thermal forcing.

![ReanalysisvsIsca](figures/reanalysisvsisca.png)

The behaviour of the ITCZ relative to the dividing streamline that denotes the boundary between the winter and summer Hadley Cells is also different in both regimes. In the equinoctal regime, the ITCZ is co-located with the dividing streamline. However, in the solstitial regime, the ITCZ gradually decouples from the dividing streamline and is found slightly equatorward, as illustrated in Fig. 2 (see also Geen et al. [2020]). In a method similar to Geen et al. [2019], I aim to investigate parameters in Aquaplanet GCMs, specifically axial tilt and slab-depth, that can affect the transition of idealised Hadley cells from the equinoctal regime to the solstitial regime.

## 1. Methodology

### A. Isca GCM Experiments

The Isca GCM is built off the Flexible Modelling System (FMS) by GFDL.  Created and developed by the ExeClim Group from the University of Exeter, it aims allow people to easily create and run a hierarchy of models in order to better understand global climate.  More details on the Isca GCM can be found on the model [website](https://execlim.github.io/IscaWebsite/), [model development paper](https://gmd.copernicus.org/articles/11/843/2018/) and [GitHub](https://github.com/ExeClim/Isca).

In this project, I run the Isca model in Aquaplanet mode with 2-stream gray radiation at the T42 spectral resolution (128x64), with 25 vertical levels.  The model was run with slab ocean in order to close the energy budget, but ocean heat transport was not parameterized.  The model was run with the following configurations:
|    Variable    |  Configurations   |               Description                |
| :------------: | :---------------: | :--------------------------------------- |
| Axial Tilt / º | 5, 10, 15, 20, 25 | Changes axial tilt / planetary obliquity |
| Slab Depth / m |  1, 2, 5, 10, 20  | Changes mixed-layer ocean heat capacity  |

The control experiment run has 0º axial tilt.  Slab depth does not matter much for the control run as a result because there is no seasonal variability that would greatly impact the strength of the Hadley Cells once the model has equilibrated.

### B. Latitudes for Centroids and Maximums

In order to track the edges of the Hadley cells and the dividing streamline between the two hemispheres, we rely on a concept that is often used to study the ITCZ, known as the precipitation centroid.  This method was first introduced in [Frierson and Hwang [2012]](https://journals.ametsoc.org/jcli/article/25/2/720/33793/Extratropical-Influence-on-ITCZ-Shifts-in-Slab) as:

![FriersonCentroid](figures/friersoncentroid.png)

Later on, [Adam et al. [2016]](http://journals.ametsoc.org/doi/10.1175/JCLI-D-15-0710.1) defined the precipitation maximum latitude as

![AdamMaximum](figures/adammaximum.png)

However, I find that this method overemphasizes the importance of latitude area-weighting, as the `cosφ` term is also raised to the power of *N*, and this method fails when the variability of the parameter in question is small compared to the absolute averaged values.  This is not a problem for precipitation, because the ITCZ has a prominent amplitude relative to the global averaged precipitation, but when extended to other variables like surface temperature, this method fails.

Therefore, I propose a modified version of this equation:

![MaximumLat](figures/maximumlat.png)

And a comparison between our modified version of this equation (white and black dotted lines for centroid and maximum latitudes respectively) with the previous formulae (blue and red solid lines for centroid and maximum latitudes) shows that our formula works better for finding the centroid and maximum latitudes for surface temperature, while retaining similar values to those found using precipitation data.

## 2.

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
