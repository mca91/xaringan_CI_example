## An Example for deploying xaringan projects using Travis CI

<img src="https://travis-ci.com/images/logos/TravisCI-Full-Color.png" width="80" height="25"><br><img src="https://travis-ci.com/mca91/xaringan_CI_example.svg?branch=master">

This is a basic example how to check and deploy xaringan projects using the travis continuous integration service and GitHub Pages.

#### .travis.yml

The below `.travis.yml` file tells travis to test the project using an R environment and deploy the results to the gh-pages. 

```yaml
language: r
sudo: required
cache: packages

before_script:
  - chmod +x ./scripts/cibuild

install:
  - R -e 'install.packages(c("rmarkdown", "xaringan", "callr"))'

script:
  - scripts/cibuild

deploy:
  provider: pages
  skip_cleanup: true
  github_token: $GITHUB_TOKEN
  local_dir: .
  on:
    branch: master

notifications:
  email:
    on_success: never
    on_failure: always
```

We tell travis to turn `cibuild` in an executable which then runs the following shell script.
```
#!/bin/sh
Rscript -e "xrngn_fls<-list.files(recursive = T, pattern = '.Rmd')
for (i in 1:length(xrngn_fls)) {
    callr::r(function(x) rmarkdown::render(x, 'xaringan::moon_reader'), 
    args = list(xrngn_fls[i]))
}"
```
Here we recursively search for `.Rmd` files in the project repository and render them to `xaringan::moon_reader` &msash; each in a new R session since `rmarkdown::render(x, 'xaringan::moon_reader')` clutters the global environment which may lead to conflicts. 

Note that `$GITHUB-Token` is a reference to the environment variable `GITHUB-Token` which is stored in the repository settings @ [travis-ci.org](https://travis-ci.org).  
