![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)
![CRAN Version](https://img.shields.io/badge/CRAN-7.3.2-brightgreen)
![Open Issues](https://img.shields.io/badge/open%20issues-0-brightgreen)
![License](https://img.shields.io/badge/License-MIT-blue)

![image](https://github.com/user-attachments/assets/195ab93a-1231-4e90-99db-cf70f97ff225)

# segmonR

`segmonR` is an R package designed for visualizing data in the form of pie charts with customizable segment motion. It allows you to create dynamic, circular visualizations, and provides options to customize the segments based on variables or categories in your data.

## Installation

To install the `segmonR` package, run the following code in your R script:

```R
# Install package from GitHub
devtools::install_github("jokoadenur/segmonR")
```

> **Note:** If prompted to update certain packages (options like 1. All, 2. CRAN, etc.), simply press **ENTER** to skip. Wait until the installation process is complete and the message `DONE (segmonR)` appears.

After installation, activate the package with the following code:

```R
# Activate the package
library(segmonR)
```

## Usage

To create a pie chart with customized segment motion, use the segmonr() function with a dataset containing at least two columns: text (for category labels) and value (for category values)

```R
segmonr(data)
```

### Examples:

1. Simple data with additional columns:
   ```R
   data <- data.frame(
   text = c("A", "B", "C", "D", "E", "F"),
   value = c(20, 45, 60, 75, 120, 67),
   group = c("G1", "G1", "G2", "G2", "G3", "G8"),
   category = c("Cat1", "Cat2", "Cat3", "Cat4", "Cat5", "Cat6"))

   segmonr(data)
   ```
   <img width="1117" height="957" alt="image" src="https://github.com/user-attachments/assets/2fc28a58-67ad-4f70-9bec-3da1d4821f42" />

2. Data with customized colors:
   ```R
   data <- data.frame(
   text = c("A", "B", "C", "D", "E"),
   value = c(20, 45, 60, 75, 120),
   color = c("#ff1493", "#ff6361", "#bc5090", "#50508d", "#60508d"))

   segmonr(data)
   ```
   <img width="1046" height="957" alt="image" src="https://github.com/user-attachments/assets/d4be8053-f20e-4724-b5bd-75ff1a79f9cd" />

3. Customize colors manually:
   ```R
   segmonr(data, color = c("#ff6347", "#32cd32", "#ff4500", "#6a5acd", "#d2691e"))
   ```
### Data Requirements:
  To use the segmonr() function effectively, your data must contain at least two columns:
  
  text: The category or label for each segment
  
  value: The value or proportion for each segment
  
  Optional additional columns such as color, group, or category can be used to further customize the visualization.
