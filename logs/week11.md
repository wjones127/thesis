# Week 11 Research Log

## November 21: Eureka!
I found a way to get the road network info I need, and it was surprisingly simple.
So previously, I had tried to get the road network from the already matched
paths given to me, by splitting up the given paths into segments and finding all
the paths that are common. (In other words, seeing if there was a road network
embedded in the matched paths they gave me.) But when I tried it before, it didn't
work: there were few, if any, common paths.

Well it turns out that was the right idea, I had just messed up earlier. Earlier
in processing the data, I had discovered that there were four copies of each 
ride. I confirmed with Evan from RIDE that they were actually two copies each of
the 'simplify' and 'match' versions of the path. Now before I assumed the 'match'
version were the ones I wanted, but I was wrong.

I went back to look at the difference between those two sets, and look what I
found:

![Plot of the four different data sets, zoomed in at a portion of the city. ](../analysis/personal-data_files/unnamed-chunk-7-1.png)

Here, it's clear that plots 1 and 3, which are 'match' data, are not cleanly 
matched to streets, while plots 2 and 4, which are the 'simplify' data, are.
So when I pushed this data through the process I created earlier, I got a nice
network of roads from the data. So yay!

Now the challenge is how do I get the data about those roads joined to the 
segments.
