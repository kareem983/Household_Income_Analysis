# Household_Income_Analysis


![back](https://user-images.githubusercontent.com/52586356/168449600-9c574e80-dd40-4dfe-94a5-7ba8bcd9c087.jpg)



> A full data analytics project that Review of Big Data Analytic Methods and cluster the Household Income using the K-means algorithm.


## Features
- [x] Preprocessing:
- [1] Analyzing the data.
- [2] Detecting the duplicate rows of data and removing them.
- [3] Detecting the outlier values of data and removing them.
- [4] Visualizing the scatter and box plots.

- [x] Advanced Analytics Methods:
- [1] Applying K-means algorithm in the data.
- [2] Determine the best value of K using the `elbow plot`.
- [3] Scale the data by `Log10` to improve the clustering result.

## Visualization/Plots

<details>
  <summary>Data Analysis</summary>
<p>
  
- **Scatter plot**<BR>
![scatterplot](https://user-images.githubusercontent.com/52586356/168449677-ebb1f239-3547-431f-87cd-36ed3267eb76.png)

  
- **Scaled box plot**<BR>
![log_boxplot](https://user-images.githubusercontent.com/52586356/168449721-127858aa-b4fc-46fa-bbac-2a4794edbbcf.png)
  

</p>
</details>


<details>
  <summary>Data Clustering</summary>
<p>
  
- **Clustering with K = 10**<BR>
![clusters_log10_plot](https://user-images.githubusercontent.com/52586356/168449766-736415ce-d86a-4be6-a6e7-be6341a57daf.png)

  
- **elbow plot**<BR>
![wss_without_outlier_plot](https://user-images.githubusercontent.com/52586356/168449794-d0075932-f853-4c46-81a9-5333a3764b01.png)

- **Clustering with The best choice of K = 2**<BR>
![clusters_best_k_plot](https://user-images.githubusercontent.com/52586356/168449812-891014f7-bd57-498e-ade5-fdf08ab8313d.png)

  
</p>
</details>
  
  
## Prerequisites
- [1] Install R programming language.<BR/>
- [2] Install R Studio.<BR/>
- [3] Install the needed packages.<BR/>

## Packages

```
install.packages("dplyr")
install.packages("data.table")
install.packages("Hmisc")
install.packages("ggpubr")
install.packages("factoextra")
install.packages("ClusterR")
install.packages("cluster")
```

## References
- [R Studio Download](https://www.rstudio.com/products/rstudio/download/)
- [R Studio Official Documentation](https://team-admin.rstudio.com/documentation/)
