# Personal Data
Will Jones  
October 26, 2015  



Here we have data provided by William Henderson, containing data from 5 riders.



```r
bikeroutes.shapefile <- readOGR("../data/RIDE/william-trips-export.json", "OGRGeoJSON", p4s="+proj=tmerc +ellps=WGS84")
```

```
## OGR data source with driver: GeoJSON 
## Source: "../data/RIDE/william-trips-export.json", layer: "OGRGeoJSON"
## with 7712 features and 13 fields, of which 1 list fields
## Feature type: wkbLineString with 2 dimensions
```

```r
bikeroutes.df <- fortify(bikeroutes.shapefile)

head(bikeroutes.df)
```

```
##        long      lat order piece group id
## 1 -122.6532 45.50247     1     1   0.1  0
## 2 -122.6532 45.50247     2     1   0.1  0
## 3 -122.6532 45.50247     3     1   0.1  0
## 4 -122.6532 45.50247     4     1   0.1  0
## 5 -122.6531 45.50240     5     1   0.1  0
## 6 -122.6530 45.50235     6     1   0.1  0
```

```r
ggplot(bikeroutes.df, aes(x=long, y=lat, group=group)) + geom_path()
```

![](personal-data_files/figure-html/unnamed-chunk-2-1.png) 

This seems to include locations outside of Portland, OR. So let's filter this data.


```r
# TODO: filter by rides/groups/lines, not individual points
bikeroutes.df <- bikeroutes.df %>%
  filter(lat > 45.462 & lat < 45.549) %>%
  filter(long < -122.577 & long > -122.722)

ggplot(bikeroutes.df, aes(x = long, y = lat, group = group)) + geom_path()
```

![](personal-data_files/figure-html/unnamed-chunk-3-1.png) 

That's quite a bit of coverage for only five people!