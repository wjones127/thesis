# Week 23

## Missing Data

So assuming MAR a missing response doesn't mean bias in our slope estimates, but
it does mean bias in our intercept estimates. This could be especially a problem
in estimating the uncertainty we have in the intercepts. We are underestimating
our uncertainty of them right now. Maybe.


Datetime is when the ride starts. I just learned that they also have ride end...
That would have been useful.


## Problems?

I had a thought. what if I randomly assigned riders to rides. Would models 
perform similarly well if I added a random intercept then? How do I test if 
those gains were were due to the riders... and not just because I let the 
model give different sets of observations different values????
