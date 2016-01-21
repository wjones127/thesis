# Week 17

## Logistic Regression Diagnostics

So I've been looking up how to evaluate logistic regressions. One simple measure
I've used is just splitting data into testing and training and then computing the
percent of training data misclassified. (This, of course, requires choosing an
arbitrary threshold, but it is useful at time for comparing models.)

One question I have is: in what situations is it appropriate to compare the
likelihood of different models? When they data is the same? When there are the
same models computed different ways?

I found a couple of useful papers from political science publications (aparently
logistic regression is a big deal in that field), which present to novel ways
of visualizing logistic regression. They offer several advantages over ROC curves
and other measures.

I've created a quick function to do separation plots. It is really useful! It was
able to show some serious improvement of a model with random effects from riders
over a normal fixed effects model.

## Missing Data

This dataset has a lot of missing data: people will often forget to rate their
rides. It might be useful to incorporate this into the model. The nice thing is
that only rider ratings are missing, assuming we collect enough weather data.
(And if we do have to cut out some days, I think we could assume that it wouldn't
bias our results very much, especially because we are including weather in our
regression.)

One question we might ask is whether non respsonse is independent of the riders
experience. We might expect that it is not: a rider who just experienced a very
unpleasant ride might be more likely to rate their ride that one who experienced
an uneventful ride.

Put another way: are the rides that aren't rated to systematically different
from those that are rated? I have one thought on a way to get at this question:
We could use our best regression model to predict the ratings of unrated rides
and then try to determine if those ratings are distributed differently. We might
use the permutation test on the average rating for each group to determine if
that statistic is different by a significant amount. Might want to scale the
distribution based on the error rate of the model used to predict.

I might consider later adding an entire chapter on missing data.

In fact, there are two types of missing data here: routes not taken, and ratings
not given. It will be worthwhile examining both.

## Intersections

I think I might be able to have more immediate success adding intersections to 
the data. I can simply use a dataset of intersections, use nearest neighor search
to find the nearest GPS point for each intersection, and assigning that intersection
to that route only if the nearest neighbor distance is less than a certain threshold.

Sadly, the data for intersections is limited to signals and is poorly described.
Maybe I can get a more full one later by emailing the Portland Bureau of Transportation?

## TODO

- Draft Data section
- Finish first models RMD.
- Write functions for graphing logistic regression
- Research other logistic regression diagnostics
- Do missing data experiment
- Read more and write up section on missing data
- Write out current road model
- Investigate other models for routes
