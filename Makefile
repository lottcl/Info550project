covid_report: Rmd/covid_inequality.Rmd output/covid_plot.png
	Rscript -e "rmarkdown::render('Rmd/covid_inequality.Rmd')"

output/covid_plot.png: R/covid_plot.R
	Rscript R/covid_plot.R

.PHONY: covid_report