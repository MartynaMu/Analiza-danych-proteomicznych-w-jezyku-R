# Run the following script to install all required packages

# tidyverse
install.packages("tidyverse")


# pheatmap
install.packages("pheatmap")

# clusterProfiler
remotes::install_github("YuLab-SMU/clusterProfiler")

# org.Sc.sgd.db
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("org.Sc.sgd.db") #type n to stop update

# enrichplot
BiocManager::install("enrichplot")

