# Week 21

## Progress Report

Ran models at Ride Report on all rides in Portland, OR. (Cool!) It was a good
thing I went into the office. There was a big bug that involved leap day, of
all things.

I implemented the sliding window regression to choose a window by maximizing
the leave-on-out cross validation likelihood, which I thought was a nice metric.
It takes really long though. I might look into methods of making it smaller.
(Also, note to self: do tests on large sample sizes to get more performance 
information.)

I had a few problems with getting models to converge. All of the random
intercept models gave a failure to converge. I tried filtering the data to make
sure we have at least 20 rides for each riders. But that didn't seem to work,
except for the additive models, which didn't complain about not converging.

Most of my loess fitted plot came out pretty boring, which I didn't expect. I
wonder why that is? Maybe there is no relationship. Or maybe there is a bug in 
my code that makes the window size large... The window does seem to be exceedingly
large. Maybe I did just choose a poor metric.

I also broke my gamm predict function because the rider indexes for the intercepts
are wrong. Will have to fix that later. Ultimately I guess I will need to try
again with starting values and better tested code.

## Some Questions

Is there already research on the questions I pose in the missing data chapter?
What are the terms used for this? (Most of the missing data stuff has been looking
at missing predictors, not reponses, which I think makes a huge difference.)

## Todos / Timeline

Some things I might want to do:

- Parrallelize the code for leave one out in the stuff
- Write up leave on out cross validation in methods to full explain how
  chart was make