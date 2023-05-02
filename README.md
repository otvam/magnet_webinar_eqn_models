# MagNet Challenge Webinar: Equation-based Baseline Models

## Introduction

This repository contains the **slides** and **code** related to the following webinar:
* **2023 MagNet Challenge Webinar: Equation-based Baseline Models**
* **IEEE PELS Webinar - May 12 2023**
* **Thomas Guillod** - Dartmouth College

This webinar focuses on equation-based loss models for soft-magnetic materials:
* Several models are presented (SE, iGSE, ISE, iGCC, and Stenglein equation).
* The model performances are evaluated for different frequencies, waveshapes, and temperatures.
* The advantages and drawbacks of equation-based models with respect to machine learning models are discussed.
* The software implementation of the iGSE and iGCC is discussed in detail and the pitfalls are highlighted.

## Main Files

* [slides.pdf](slides.pdf) - Slides of the webinar
* [run_igse.m](run_igse.m) - Parametrize and evaluate the iGSE model
* [run_igcc.m](run_igcc.m) - Parametrize and evaluate the iGCC model

## Dataset

* For the software implementation, the EPCOS/TDK N87 ferrite material is considered.
* The material is measured at ambient temperature (25C) without DC bias.
* For parametrizing the models, the following dataset is used:
    * 346 symmetric triangular waveforms (50% duty cycle)
    * Dataset contained in [N87_25C_fit.mat](data/N87_25C_fit.mat)
* For evaluating the models, the following dataset is used:
    * 2446 asymmetric triangular waveforms (10% to 90% duty cycle)
    * Dataset contained in [N87_25C_eval.mat](data/N87_25C_eval.mat)
* Both datasets are extracted from the following repository:
    * Guillod, T. and Lee, J. S. and Li, H. and Wang, S. and Chen, M. and Sullivan, C. R.
    * Calculation of Ferrite Core Losses with Arbitrary Waveforms using the Composite Waveform Hypothesis
    * Reproducibility Dataset, Zenodo Repository, 2022
    * [10.5281/zenodo.7368936](https://doi.org/10.5281/zenodo.7368936)

## Warnings

> **Warning**
> This implementation is provided for **pedagogical purposes**:
> * The goal of this code is to highlight the **typical workflow** of equation-based loss models.
> * The implementation is **not meant** to be **comprehensive and/or accurate**.

> **Warning**
> In order to limit the complexity of the code, **several assumptions** are made:
> * Single material measured at ambient temperature
> * Only triangular signals are considered
> * No DC bias and relaxation effects
> * Simple model parametrization
> * Reduced dataset size

## Compatibility

* Tested with MATLAB R2021a.
* The `optimization_toolbox` is required.
* The `signal_toolbox` is required.
* The `statistics_toolbox` is required.

## Author

**Thomas Guillod** - [GitHub Profile](https://github.com/otvam)

## License

This project is licensed under the **MIT License**, see [LICENSE.md](LICENSE.md).
