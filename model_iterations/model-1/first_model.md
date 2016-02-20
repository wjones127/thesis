# First Model
Will Jones  
December 8, 2015  




## Introduction

As our first steps in modeling ride rating, we will start to model without route
data. Instead we will focus on other question in the modeling as a start for our
model:

- How much variation is there between riders in how they tend to rate rides?
- What relationship does weather, like rain or wind speed, have with ride
rating?
- How does ride rating fluctuate with time of day (which we use as a proxy for
traffic)?

We actually expect a fair amount of the variance in ride rating to be explained
by these variables, based on tests of a smaller sample.

## Some Numbers about the Data





There are 1515 rides in the data set, with 238
(15.709571%) rides with no rating.

## What variables will we include?



### Length

<img src="first_model_files/figure-html/plot_length-1.png" title="" alt="" style="display: block; margin: auto;" /><img src="first_model_files/figure-html/plot_length-2.png" title="" alt="" style="display: block; margin: auto;" />

### Weather

We also want to consider patterns with weather. We have data on daily weather,
including wind speed, temperature highs and lows, and rain data. But we also
have hourly rain data from a local fire station.

<img src="first_model_files/figure-html/plot_weather-1.png" title="" alt="" style="display: block; margin: auto;" /><img src="first_model_files/figure-html/plot_weather-2.png" title="" alt="" style="display: block; margin: auto;" /><img src="first_model_files/figure-html/plot_weather-3.png" title="" alt="" style="display: block; margin: auto;" /><img src="first_model_files/figure-html/plot_weather-4.png" title="" alt="" style="display: block; margin: auto;" />


### Traffic / Daily Trends

We would like to incorporate traffic, but to simplify our model, we may simple
use time of day as a proxy.

<img src="first_model_files/figure-html/plot_traffic-1.png" title="" alt="" style="display: block; margin: auto;" /><img src="first_model_files/figure-html/plot_traffic-2.png" title="" alt="" style="display: block; margin: auto;" />




## The Models

### Classical Model

First, we consider how a classical logistic regression model compares to
a model with a random intercept for riders. So we will model:

\[
Y = \text{logit}^{-1} \left(
\alpha + \beta_1 \cdot \text{log.length} + \beta_2 \cdot \text{log.wind speed} +
\beta_3 \cdot \text{log.rainfall.4h}
\right).
\]

### Just Rider Random Effects

Now we want to explore how we can capture variance with and between riders. So
we will use the basic model

\[
Y \sim \text{Bernoulli} (\text{logit}^{-1}(\alpha_{j[i]})),
\quad
\alpha_{j[i]} \sim \text{Normal}(\mu_\alpha, \sigma^2_\alpha).
\]


### Add Time of Day Effects

Now we want to add effects based on time of day. We will try using polynomial
regression to do this first, by adding to our regression the terms,

\[
\beta_1 \cdot \text{hour} + 
\beta_2 \cdot \text{hour}^2 + 
\beta_3 \cdot \text{hour}^3 + 
\beta_4 \cdot \text{hour}^4.
\]

### All Effects

Our last model will take the rider intercepts and day effects and add the terms
we had in our first regression with variables. 


## Table of coefficients

For now, we will compute these models using maximum likelihood. Later, we might
do Bayesian inference with STAN.






<table style="text-align:center"><caption><strong>results</strong></caption>
<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"></td><td colspan="4"><em>Dependent variable:</em></td></tr>
<tr><td></td><td colspan="4" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align:left"></td><td colspan="4">stressful</td></tr>
<tr><td style="text-align:left"></td><td><em>logistic</em></td><td colspan="3"><em>generalized linear</em></td></tr>
<tr><td style="text-align:left"></td><td><em></em></td><td colspan="3"><em>mixed-effects</em></td></tr>
<tr><td style="text-align:left"></td><td>(1)</td><td>(2)</td><td>(3)</td><td>(4)</td></tr>
<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">log.length</td><td>-0.288<sup>***</sup></td><td></td><td></td><td>-0.377<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.097)</td><td></td><td></td><td>(0.105)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">rainfall.4h</td><td>-0.001</td><td></td><td></td><td>-0.018</td></tr>
<tr><td style="text-align:left"></td><td>(0.026)</td><td></td><td></td><td>(0.027)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">mean.wind.speed</td><td>0.037</td><td></td><td></td><td>0.008</td></tr>
<tr><td style="text-align:left"></td><td>(0.038)</td><td></td><td></td><td>(0.038)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">hour</td><td></td><td></td><td>0.227</td><td>0.288</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td>(0.192)</td><td>(0.203)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">I(hour2)</td><td></td><td></td><td>-0.097</td><td>0.049</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td>(0.249)</td><td>(0.262)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">I(hour3)</td><td></td><td></td><td>-0.038</td><td>-0.087</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td>(0.108)</td><td>(0.117)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">I(hour4)</td><td></td><td></td><td>-0.034</td><td>-0.062</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td>(0.060)</td><td>(0.068)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Constant</td><td>-1.980<sup>***</sup></td><td>-2.783<sup>***</sup></td><td>-2.640<sup>***</sup></td><td>-2.792<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.249)</td><td>(0.957)</td><td>(0.952)</td><td>(0.980)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Observations</td><td>890</td><td>890</td><td>890</td><td>890</td></tr>
<tr><td style="text-align:left">Log Likelihood</td><td>-367.220</td><td>-316.641</td><td>-313.213</td><td>-306.525</td></tr>
<tr><td style="text-align:left">Akaike Inf. Crit.</td><td>742.440</td><td>637.281</td><td>638.426</td><td>631.050</td></tr>
<tr><td style="text-align:left">Bayesian Inf. Crit.</td><td></td><td>646.864</td><td>667.173</td><td>674.171</td></tr>
<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td colspan="4" style="text-align:right"><sup>*</sup>p<0.1; <sup>**</sup>p<0.05; <sup>***</sup>p<0.01</td></tr>
</table>


### Rider Intercepts

![](first_model_files/figure-html/rider_intercepts-1.png)

### Hourly Trends

<img src="first_model_files/figure-html/hourly_plot-1.png" title="" alt="" style="display: block; margin: auto;" />


## Model Accuracy and Fit


### Separation Plots


Were there new levels? FALSE.
<img src="first_model_files/figure-html/pred_sep_plot-1.png" title="" alt="" style="display: block; margin: auto;" /><img src="first_model_files/figure-html/pred_sep_plot-2.png" title="" alt="" style="display: block; margin: auto;" /><img src="first_model_files/figure-html/pred_sep_plot-3.png" title="" alt="" style="display: block; margin: auto;" /><img src="first_model_files/figure-html/pred_sep_plot-4.png" title="" alt="" style="display: block; margin: auto;" />

