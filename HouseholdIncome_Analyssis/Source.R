#make sure to change the working directory to your project folder
#uncomment the below section if you didn't install the packages before
#install.packages("dplyr")
#install.packages("data.table")
#install.packages("Hmisc")
#install.packages("ggpubr")
#install.packages("factoextra")
#install.packages("ClusterR")
#install.packages("cluster")

#calling needed libraries
library(dplyr)
library(data.table)
library(Hmisc)
library(ggplot2)
library(gridExtra)
library(ggpubr)
library(factoextra)
library(ClusterR)
library(cluster)

cat("\n\n##################### Review of Big Data Analytic Methods #####################\n\n")

##### 1.1 print zeta description
zeta_dataframe <- read.csv("Datasets/zeta.csv")
cat("summary of zeta data frame \n")
print(summary(zeta_dataframe))

##### 1.1 Record column names
col_names <- names(zeta_dataframe)

##### 2.2 change columns names
colnames(zeta_dataframe)[which(names(zeta_dataframe) == "zcta")] <- "zipCode"
colnames(zeta_dataframe)[which(names(zeta_dataframe) == "meanhouseholdincome")] <- "income"

##### 1.1 transfer the zeta dataframe into table
zeta_table <- as.data.table(zeta_dataframe, TRUE)

##### 1.2 print number of rows
cat("\n#of rows before removing duplication ---> " , nrow(zeta_table) )

##### 1 ->3,4,5 check if there is any duplicated rows and Remove duplicate rows if any
number_of_duplicated_rows <- sum(duplicated(zeta_table))

if(number_of_duplicated_rows != 0 ){
  distinct(zeta_table)
  cat("\nthere is duplicated rows at " , zeta_table[duplicated(zeta_table)])
  write.csv(zeta_table,"“zeta_nodupes.csv", row.names = FALSE)
}else{
  cat("\nthere is no duplicated rows!\n")
}

##### print number of rows after removing duplication
cat("#of rows after removing duplication--->", nrow(zeta_table))

##### 2.1 import zipincome file 
zipincome <- read.delim("Datasets/zipIncome.txt")

##### 2.3 print income column summary
cat("\nsummary of income column\n")
print(summary(zeta_table$income))

##### 2.4 Plot a scatter plot of the data.
# income_table <- as.data.table(zeta_dataframe$income)
# colnames(income_table) = c("income")
# 
# meanage_table <- as.data.table(zeta_dataframe$meanage)
# colnames(meanage_table ) = c("meanage")

# meaneducation_table <- as.data.table(zeta_dataframe$meaneducation)
# colnames(meaneducation_table) = c("meaneducation")

# meanemployment_table <- as.data.table(zeta_dataframe$meanemployment)
# colnames(meanemployment_table) = c("meanemployment")

# ggarrange(ggplot(data = melt(income_table), aes(x=variable, y=value)) +
#           geom_point(colour="blue"),
#           ggplot(data = melt(meanage_table), aes(x=variable, y=value)) +
#           geom_point(colour="red") ,
#           ggplot(data = melt(meaneducation_table), aes(x=variable, y=value)) +
#           geom_point(colour="green"),
#           ggplot(data = melt(meanemployment_table), aes(x=variable, y=value)) +
#           geom_point(colour="black") ,
#           nrow = 1)
#
# ggsave("Output Plots/scatterplot.png")


##### 2.5  create a subset of the data (removing outlires)
cat("\nmean of income column before removing outlires -->",mean(zeta_table$income))

new_zeta_table <- subset(zeta_table, income > 7000 & income < 200000)
# income_table <- as.data.table(new_zeta_table$income)
# colnames(income_table) = c("income")

##### 2.6 mean of new zeta data
cat("\nmean of income column after removing outlires -->",mean(new_zeta_table$income))

##### 3 Visualize your data
##### 3.1 
# ggarrange( ggplot(data = melt(income_table), aes(x=variable, y=value)) +
#           geom_boxplot(colour="blue") ,
#           ggplot(data = melt(meanage_table), aes(x=variable, y=value)) +
#           geom_boxplot(colour="red"),
#           ggplot(data = melt(meaneducation_table), aes(x=variable, y=value)) +
#           geom_boxplot(colour="green"),
#           ggplot(data = melt(meanemployment_table), aes(x=variable, y=value)) +
#           geom_boxplot(colour="black"),
#           nrow = 1 ,
#           top = text_grob("original data"))
#
# ggsave("Output Plots/original_boxplot.png")


##### 3.2
# ggarrange( ggplot(data = melt(income_table), aes(x=variable, y=log(value))) +
#           geom_boxplot(colour="blue"),
#           ggplot(data = melt(meanage_table), aes(x=variable, y=log(value))) +
#           geom_boxplot(colour="red"),
#           ggplot(data = melt(meaneducation_table), aes(x=variable, y=log(value))) +
#           geom_boxplot(colour="green"),
#           ggplot(data = melt(meanemployment_table), aes(x=variable, y=log(value))) +
#           geom_boxplot(colour="black"),
#           nrow = 1 ,
#           top = text_grob("log of the data"))
#
# ggsave("Output Plots/log_boxplot.png")



cat("\n\n#################### Advanced Analytics/Methods (K-means) #####################\n\n")



##### ADV.1 Access the data and change the columns names
income_state_dataframe <- read.csv("Datasets/income_elec_state.csv")
income_state_dataframe_copy <- income_state_dataframe

colnames(income_state_dataframe_copy)[which(names(income_state_dataframe_copy) == "X")] <- "state"
colnames(income_state_dataframe_copy)[which(names(income_state_dataframe_copy) == "income")] <- "mean household income"
colnames(income_state_dataframe_copy)[which(names(income_state_dataframe_copy) == "elec")] <- "mean electricity usage"

income_state_table <- as.data.table(income_state_dataframe_copy, TRUE)
rm(income_state_dataframe_copy)
#delete the first column from the table
income_state_table <- income_state_table[, 2:4]


##### ADV.2 Cluster the data using k-means function
# transform state column to numeric data
income_state_table$state <- as.numeric(as.factor(income_state_table$state))

# start the k-means algorithm
set.seed(120)
km <- kmeans(income_state_table, centers = 10, iter.max = 60, nstart = 30)
cat("\nThe result of Kmeans Algorithm:\n")
print(km)

# plot the k-means cluster:
fviz_cluster(km, income_state_table, 
             geom = "point",
             ellipse.type = "convex",
             ggtheme = theme_bw()
)
ggsave("Output Plots/clusters_plot.png")


##### ADV.3 Determine a reasonable value of k
fviz_nbclust(income_state_table, kmeans, method = "wss")
ggsave("Output Plots/wss_plot.png")
cat("\nAccording to within sum of squares(wss) plot,\nThe optimal number of clusters: 2")


##### ADV.4 Cluster the data with log10 scale
income_state_table$`mean household income`  <- scale(log10(income_state_table$`mean household income`))
income_state_table$`mean electricity usage` <- scale(log10(income_state_table$`mean electricity usage`))

set.seed(120)
km <- kmeans(income_state_table, centers = 10, iter.max = 60, nstart = 30)
cat("\nThe result of Kmeans Algorithm After Convertion columns to log10 scale:\n")
print(km)

# plot the k-means cluster After Update log10 scale on columns:
fviz_cluster(km, income_state_table, 
             geom = "point",
             ellipse.type = "convex",
             ggtheme = theme_bw()
)
ggsave("Output Plots/clusters_log10_plot.png")


##### ADV.5 re-evaluating the choice of k, After Update log10 scale on columns
fviz_nbclust(income_state_table, kmeans, method = "wss")
ggsave("Output Plots/wss_log10_plot.png")
cat("\nAfter re-evaluating the choice of k, Still the optimal number of clusters: 2\n")


##### ADV.6 Detecting outlier
# by Calculation
centers <- km$centers[km$cluster,]
distances <- sqrt(rowSums((income_state_table - centers)^2))
outliers <- order(distances, decreasing=T)[1:5]
cat("\nThe top 5 rows that has outliers: ", outliers, "\n")

# by Graphically
fviz_cluster(kmeans(income_state_table, centers = 10, iter.max = 60, nstart = 30), data = income_state_table)
ggsave("Output Plots/clusters_outliers_plot.png")

# remove rows that has outliers
income_state_table <- income_state_table[-c(32), ]
income_state_table <- income_state_table[-c(20), ]
income_state_table <- income_state_table[-c(41), ]
income_state_table <- income_state_table[-c(7), ]
income_state_table <- income_state_table[-c(17), ]


set.seed(120)
km <- kmeans(income_state_table, centers = 10, iter.max = 60, nstart = 30)
cat("\nThe result of Kmeans Algorithm After Delting The outliers:\n")
print(km)

fviz_cluster(km, income_state_table, 
             geom = "point",
             ellipse.type = "convex",
             ggtheme = theme_bw()
)
ggsave("Output Plots/clusters_without_outlier_plot.png")


# re-evaluate k again
fviz_nbclust(income_state_table, kmeans, method = "wss")
ggsave("Output Plots/wss_without_outlier_plot.png")
cat("\nAfter re-evaluating the choice of k, Still the optimal number of clusters: 2\n")



##### Finally Cluster the data with the best k=2
set.seed(120)
km <- kmeans(income_state_table, centers = 2, iter.max = 60, nstart = 30)
cat("\nThe best result of Kmeans Algorithm with best k=2:\n")
print(km)

fviz_cluster(km, income_state_table, 
             geom = "point",
             ellipse.type = "convex",
             ggtheme = theme_bw()
)
ggsave("Output Plots/clusters_best_k_plot.png")



cat("\n\n######################## Finally The End Point #########################")



