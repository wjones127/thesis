# Hierarchical Models for Crowdsourced Bicycle Route Ratings
This is my undergraduate thesis, currently in progress and to be completed May
of 2016.

The [Ride Report App](ride.report) automatically saves GPS traces of users'
bicycle rides and prompts them at the end of their ride for a rating ("Stressful"
or "Chill".) From this, they have created a [stress map](ride.report/map) of
Portland, OR, with color indicated average rating of road segments (and width 
indicating segment popularity.)

This thesis seeks to improve upon this map. We use a multilevel regression model
for predicting ride rating based on route and road conditions, with rider-specific
random effects to account for between and within rider variability in ratings. 
While we were not able to complete a model that incorporated route information,
we present some models that could be used by future researchers.

## Outline
**Chapter 1: Data sources** details the collection methods of the data sources used,
including the Ride Report data as well as weather data.

**Chapter 2: Methods** outlines the main modeling methods used, including 
logistic regression, multilevel models, and additive models, to keep the analysis
accessible for most readers. 

**Chapter 3: Modeling Rides and Riders** compares
six iteratively built statistical models, importantly demonstrating that the 
differences in average ride rating throughout the day can be account better
by differences in the base rate at which riders give negative ratings rather
than an universal daily pattern. 

**Chapter 4: Classifying Riders** attempts
to map out the distinction between different kinds of rider and then uses
these classifications to improve models developed in the previous chapter. 

**Chapter 5: Modeling Missing Response** reports the results of using expectation
maximization to use ride observations that are missing a rating to reduce the
potential bias in estimates in previous models and, at the same time, model
the missing data mechanism.

**Chapter 6: Unfinished Work: Modeling Routes** outlines the data transformation
challenges we faced and puts forward some suggestions for models that incorporate
route information.

## File Structure
This repository is an R package with several bonus folders. They are:

- **analysis**: contains exploratory analysis from original work on data
manipulation and cleaning.
- **data**: contains some data. For privacy and license reasons, most of the
data is not availible in the repository. 
- **logs**: contains weekly logs reporting work done for the past week. 
- **R**: contains R functions written as part of the package to manipulate data
- **thesis**: contains thesis PDF and source files. (The thesis document is
created from an R markdown template, which can be found at
<https://github.com/Reedies/reedtemplates>)
