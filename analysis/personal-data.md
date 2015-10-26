# Personal Data
Will Jones  
October 26, 2015  


```
## Loading required package: rgdal
## Loading required package: sp
## rgdal: version: 0.9-1, (SVN revision 518)
## Geospatial Data Abstraction Library extensions to R successfully loaded
## Loaded GDAL runtime: GDAL 1.11.2, released 2015/02/10
## Path to GDAL shared files: /Library/Frameworks/GDAL.framework/Versions/1.11/Resources/gdal
## Loaded PROJ.4 runtime: Rel. 4.9.1, 04 March 2015, [PJ_VERSION: 480]
## Path to PROJ.4 shared files: (autodetected)
## Loading required package: ggplot2
## Loading required package: dplyr
## 
## Attaching package: 'dplyr'
## 
## The following objects are masked from 'package:stats':
## 
##     filter, lag
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```
## [[1]]
## [1] TRUE
## 
## [[2]]
## [1] TRUE
## 
## [[3]]
## [1] TRUE
```

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
bikeroutes.df <- bikeroutes.df %>%
  filter(lat > 45.462 && lat < 45.549) %>%
  filter(long < -122.577 && long > -122.722)

ggplot(bikeroutes.df, aes(x = long, y = lat, group = group)) + geom_path()
```

![](personal-data_files/figure-html/unnamed-chunk-3-1.png) 

