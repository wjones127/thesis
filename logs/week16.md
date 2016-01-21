# Week 16

## Some new resources for modeling

So I've been reading more of Andrew Gelman's blog. I think I've found a few more
resources that will be useful when I start running models.

One strong suggestion Gelman has is to use Stan, to do bayesian inference for
regression models. It might be worthwhile looking into the methods and writing
up an overview in the methods sections, to show some understanding of how the
program works. He linked to a paper earlier this year exploring what kind of
priors should be used for logistic regression
(<http://andrewgelman.com/2015/11/01/cauchy-priors-for-logistic-regression-coefficients/>.)

I might also spend some time reading [Multilevel (Hierarchical) Modeling: What it can and cannot do]<http://www.stat.columbia.edu/~gelman/research/published/multi2.pdf>.

On question: [here]<http://andrewgelman.com/2015/10/23/26857/>, what does it
mean "you can’t always use predictive performance to choose among models"?

## Some rider level variables

I also found a paper that helps gives some answer to how I should handle variance
correlation between rider variance and ride level variables like length and rain.
Bafumi and Gelman suggest adding terms to the rider level that have average of
the ride level predictors in the rider level regression. I'm not sure this
answers, though, how I might handle how riders respond to segment level 
predictors.

