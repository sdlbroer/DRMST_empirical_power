# DRMST empirical power
This GitHub repository contains supplementary code to the preprint [TBA: reference to the preprint]. 

### Files overview
Below is an overview of the files in this repository, categorized into the data files, data preprocessing, main analysis and subgroup analyses.

*Data* 
* reconstructed.xlsx - the 65 reconstructed datasets. This includes the 35 datasets reconstructed by [1].
* manuscript_information.xlsx - contains practical information on the 65 included trials, such as the sample size, significance level, etc.

*Margin conversion*
* preprocessing_data.R - categorizes the manuscript data by original summary measure, to be used in further files.
* margin_conversion_exp.R - margin conversion under the exponential distribution.
* margin_conversion_flexsurv.R - margin conversion using flexible parametric regression.

*Main analysis*
* NI_testing.R - this is the main analysis. In this file, non-inferiority is tested using all methods we compared. That is, Cox regression for HR, flexible parametric regression for DS/DRMST and Kaplain-Meier for DS/DRMST.
* flex_outcomes.R - looks at the subset of the NI_testing.R outcomes which correspond to the margins which were converted using flexible parametric regression.
* SE_calculations.R - performs exact McNemar test.

*Subgroup and sensitivity analyses*
  * flex_outcomes_subgroup_EventRisk.R - subgroup analysis split by event rate.
  * flex_outcomes_subgroup_OriginalSumMeasure.R - subgroup analysis split by original summary measure.
  * flex_outcomes_subgroup_PH.R - subgroup analysis on trials without evidence of non-PH.
  * exp_outcomes.R - looks at the subset of the NI_testing.R outcomes which correspond to the margins which were converted using the exponential distribution

### References
[1] Weir, IR., Trinquart, L. Design of non-inferiority randomized trials using the difference in restricted mean survival times. Clin Trials 2018; 15: 499-508. https://www.ncbi.nlm.nih.gov/pubmed/30074407
