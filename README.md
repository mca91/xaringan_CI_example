## An Example for deploying xaringan projects using Travis CI

<img src="https://travis-ci.com/images/logos/TravisCI-Full-Color.png" width="80" height="25"><br><img src="https://travis-ci.com/mca91/xaringan_CI_example.svg?branch=master">

This is a basic example how to check and deploy xaringan projects using the travis continuous integration service and GitHub Pages.

#### .travis.yml

The below `.travis.yml` file tells travis to test the project using an R environment and deploy the results to the gh-pages branch (travis creates the branch if it doesn't exist). 

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
  on:
    branch: master

notifications:
  email:
    on_success: never
    on_failure: always
```

We tell travis to turn `cibuild` in an executable which invokes the following shell script:

#### _build.sh
```
#!/bin/sh
Rscript -e "xrngn_fls<-list.files(recursive = T, pattern = '.Rmd')
for (i in 1:length(xrngn_fls)) {
    callr::r(function(x) rmarkdown::render(x, 'xaringan::moon_reader'), 
    args = list(xrngn_fls[i]))
}"
```
Here we recursively search for `.Rmd` files in the project repository and render them to `xaringan::moon_reader`, each in a separate subprocess since `rmarkdown::render(x, 'xaringan::moon_reader')` clutters the global environment which may lead to conflicts. 

Note that `$GITHUB_TOKEN` is a reference to the environment variable `GITHUB-Token` which is stored in the repository settings @ [travis-ci.org](https://travis-ci.org).  

If everything runs without issues, travis pushes everything into the gh-pages branch which you may use to publish your slides via, e.g., netlify.
