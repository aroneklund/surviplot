surviplot
========

An R package for drawing survival curves with the number-at-risk displayed underneath.

The primary function "surviplot" draws a survival curve with the number at risk 
displayed underneath. Optionally, the hazard ratio, CI, and logrank P value are 
displayed if there are exactly two strata. 

You can see a couple of examples here:
http://www.cbs.dtu.dk/~eklund/surviplot/



History: surviplot vs. survplot
-------------------------------

I originally called this package "survplot" and made it available on my website
around 2009.  Soon after, I discovered the existence of a function also called "survplot"
in the ["rms" package](https://cran.r-project.org/package=rms) with
somewhat similar functionality.  I was heartbroken.  Worse, there seemed to be people
out there who were getting the two packages confused. 

After seven years of anguish I finally arrived at a satisfactory new name for my
package: **surviplot**.  

Version 1.0.0 of surviplot is essentially the same as version 0.0.7 of
survplot, except for the "survplot" -> "surviplot" thing.

For former users of "survplot", you just need to replace

    ## old
    library(survplot)
    survplot(...)

with 

    ## new
    library(surviplot)
    surviplot(...)



Installation
------------


You can install the latest version from GitHub like this:

    ## install.packages(devtools)
	library(devtools)
	install_github("aroneklund/surviplot")


Related works
-------------

There are other R packages with similar functionality:
* ["rms"](https://cran.r-project.org/package=rms) also draws
survival curves with number-at-risk.
* ["survminer"](https://cran.r-project.org/package=survminer)
draws survival curves with number-at-risk in the ggplot2 framework.


