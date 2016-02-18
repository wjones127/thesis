# Week 19

## Writing Progress

I've started adding more to my thesis, though in a somewhat unorganized fashion.
I think the introduction will continuously evolve as I come up with other ways
of writing it. 

I think I can have a solid draft of the chapters on data sources, methods, and
about the first modeling iterations.

As it is it still feels a bit scattered right now, so it will soon need another
person to look over it to make sure the flow of ideas actually make sense. I've
been a little lazy with citations, but hopefully that will change soon.

## First Models Back

I got the first iteration of models back, sort of. I had to send a script to Evan
at Ride Report and he ran the models on larger samples. He said he first tried it
on a sample of 65,000 rides, but that the data cleaning took up 6GB of memory
and then crashed. After doing a bit of testing I think this might be from the
initial import command for the GeoJSON, which is something I have no idea how
to get around.

He then tried it on a smaller sample, and for some reasons predictions weren't
working. It said there were new factor levels so it couldn't predict. I tried
to remedy this by changing how the rides were split into testing and training
sets to a solution where it samples for each rider, ensuring that each rider has
at least some rides in the training data. However, when I sent this to Evan that
didn't work.

So I just told him to comment out the separation plots and predictions, and he
gave me the rest of the results. :cry:

The results were interesting. I think ultimately plots though were not good
enough. I wish I had shown confidence intervals for the estimated empiracal 
probabilities. It's really hard to know from the plots if I should trust those
trends.

One interesting finding from the models is that the distribution of the rider
intercepts has a long right tail. So it seems the majority of riders have a
small probability of giving a stressful rating, while others have varyingly high
numbers.

The wind speed variable seems to have no effect, but rainfall for past four 
hours seems to be very important.

The result can be found in `model_iterations/model1/results/first_model.html`.

## Next Model Iteration 

So there are a few things I want to do in the next iteration of models:

* Fix the prediction function
* Create another diagnostic plot
* Try to fit a sinusoidal time
* Improve empirical p plots
* Fit some models in STAN
* Have pure missing data models

## Goals for next week

* Work on the next model iteration. Hopefully have most or half of the above
  stuff done.
* Finish drafts data sources and methods sections
* Start a missing data models chapter
* Research more on time models and missing data models



