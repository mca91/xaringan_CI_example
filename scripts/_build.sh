#!/bin/sh
Rscript -e "xrngn_fls<-list.files(recursive = T, pattern = '.Rmd')[1]
for (i in 1:length(xrngn_fls)) {
    callr::r(function(x) rmarkdown::render(x, 'xaringan::moon_reader'), 
    args = list(xrngn_fls[i]))
    rm(list = setdiff(ls(), 'xrngn_fls')) 
}"
