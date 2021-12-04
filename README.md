## Inequality and COVID-19 in Virginia

My project is using county-level COVID-19 data from the Virginia Department of Health dataset 'VDH-COVID-19-PublicUseDataset-Cases.csv' and income inequality data from the 2000 Census dataset 'county5.csv'. The datasets will be analyzed using R.

## Bash Code to conduct the analysis

First, navigate to the directory where you would like to run the code (you do not need to fork the GitHub repository and clone it). You will need to pull the docker image from dockerhub using the following code:

```bash
docker pull lottcl/info550project:v1
```

Then you will need to create a new output file in your current working directory using the following code:

```bash
mkdir output
```

Finally, you will need to run the docker image with the local output directory mounted to the container's output directory using the following code:

```bash
docker run -v /your_directory_path/output:/project/output lottcl/info550project:v1
```
**Note, you need to put the full absolute path to your current directory or the image will not mount correctly and you will not get the report file in the output directory.**

After running this code successfully, a file called 'covid_inequality.html' will be in the output folder in your directory.