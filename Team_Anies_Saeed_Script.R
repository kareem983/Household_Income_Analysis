#make sure to change the working directory to your project folder
#uncomment the below section if you didn't install the packages before
#install.packages("dplyr")
#install.packages("data.table")
#install.packages("Hmisc")
#install.packages("ggpubr")

#calling needed libraries
library(dplyr)
library(data.table)
library(Hmisc)
library(ggplot2)
library(gridExtra)
library(ggpubr)

##### Review of Big Data Analytic Methods
zeta_dataframe <- read.csv("zeta.csv")

##### 1.1 print zeta description
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
zipincome <- read.delim("zipIncome.txt")

##### 2.3 print income column summary
cat("\nsummary of income column\n")
print(summary(zeta_table$income))

##### 2.4 Plot a scatter plot of the data.
# income_table <- as.data.table(zeta_dataframe$income)
# colnames(income_table) = c("income")
# 
# meanage_table <- as.data.table(zeta_dataframe$meanage)
# colnames(meanage_table ) = c("meanage")
# 
# meaneducation_table <- as.data.table(zeta_dataframe$meaneducation)
# colnames(meaneducation_table) = c("meaneducation")
# 
# meanemployment_table <- as.data.table(zeta_dataframe$meanemployment)
# colnames(meanemployment_table) = c("meanemployment")

# ggarrange(ggplot(data = melt(income_table), aes(x=variable, y=value)) +
#             geom_point(colour="blue"),
#           ggplot(data = melt(meanage_table), aes(x=variable, y=value)) +
#             geom_point(colour="red") ,
#           ggplot(data = melt(meaneducation_table), aes(x=variable, y=value)) +
#             geom_point(colour="green"),
#           ggplot(data = melt(meanemployment_table), aes(x=variable, y=value)) +
#             geom_point(colour="black") ,
#           nrow = 1)

##### 2.5  create a subset of the data (removing outlires)
cat("\nmean of income column before removing outlires -->",mean(zeta_table$income))

new_zeta_table <- subset(zeta_table, income > 7000 & income < 200000)
# income_table <- as.data.table(new_zeta_table$income)
# colnames(income_table) = c("income")

##### 2.6 mean of new zeta data
cat("\nmean of income column after removing outlires -->",mean(new_zeta_table$income))

##### 3 Visualize your data
##### .1 
# ggarrange( ggplot(data = melt(income_table), aes(x=variable, y=value)) +
#              geom_boxplot(colour="blue") ,
#            ggplot(data = melt(meanage_table), aes(x=variable, y=value)) +
#              geom_boxplot(colour="red"),
#            ggplot(data = melt(meaneducation_table), aes(x=variable, y=value)) +
#              geom_boxplot(colour="green"),
#            ggplot(data = melt(meanemployment_table), aes(x=variable, y=value)) +
#              geom_boxplot(colour="black"),
#            nrow = 1 ,
#            top = text_grob("original data"))

##### 3.2
# ggarrange( ggplot(data = melt(income_table), aes(x=variable, y=log(value))) +
#              geom_boxplot(colour="blue"),
#            ggplot(data = melt(meanage_table), aes(x=variable, y=log(value))) +
#              geom_boxplot(colour="red"),
#            ggplot(data = melt(meaneducation_table), aes(x=variable, y=log(value))) +
#              geom_boxplot(colour="green"),
#            ggplot(data = melt(meanemployment_table), aes(x=variable, y=log(value))) +
#              geom_boxplot(colour="black"),
#             nrow = 1 ,
#            top = text_grob("log of the data"))

##### Advanced Analytics/Methods (K-means)
income_state_dataframe <- read.csv("income_elec_state.csv")

##### 2.2 change columns names
colnames(income_state_dataframe)[0] <- "state"
colnames(income_state_dataframe)[which(names(income_state_dataframe  ) == "income")] <- "mean household income"
colnames(income_state_dataframe)[which(names(income_state_dataframe  ) == "elec")] <- "mean electricity usage"

income_state_table <- as.data.table(income_state_dataframe, TRUE)

