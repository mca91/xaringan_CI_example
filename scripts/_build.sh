#!/bin/sh
Rscript -e "rmarkdown::render('slides.Rmd', 'xaringan::moon_reader')"