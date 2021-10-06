## Inequality and COVID-19 in Virginia

My project is using county-level COVID-19 data from the Virginia Department of Health dataset 'VDH-COVID-19-PublicUseDataset-Cases.csv' and income inequality data from the 2000 Census dataset 'county5.csv'.

The dataset will be analyzed using R and will require you to install the 'readxl', 'dplyr', 'tidyverse', 'lubridate', and 'ggplot2' packages using the following R code:

```R
installed_pkgs <- row.names(installed.packages())
pkgs <- c("readxl", "dplyr", "lubridate", "ggplot2")
for(p in pkgs){if(!(p %in% installed_pkgs)){install.packages(p)}}
```

## Bash Code to conduct the analysis

You will need to run the analysis from the project folder, and you can use the following bash code to execute it:

```bash
Rscript -e "rmarkdown::render('homework_3.Rmd')"
```
The output will be a file called 'homework_3.html' in the same project folder that contains 'homework_3.Rmd'.
