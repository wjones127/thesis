# Hierarchical Models for Crowdsourced Bicycle Route Ratings
This is my undergraduate thesis, currently in progress and to be completed May
of 2016.

The [Ride Report App](ride.report) automatically saves GPS traces of users'
bicycle rides and prompts them at the end of their ride for a rating ("Stressful"
or "Chill".) From this, they have created a [stress map](ride.report/map) of
Portland, OR, with color indicated average rating of road segments (and width 
indicating segment popularity.)

This thesis seeks to improve upon this map. I use a multilevel regression model
for predicting ride rating based on route and road conditions, with rider-specific
random effects to account for between and within rider variability in ratings.

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
