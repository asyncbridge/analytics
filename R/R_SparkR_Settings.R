# Set Spark home path and library path 
Sys.setenv(SPARK_HOME = "C:\\spark-2.0.1\\")
.libPaths(c(file.path(Sys.getenv("SPARK_HOME"),"R","lib"), .libPaths()))

# Use SparkR library.
library(SparkR)

# as.data.frame function before initializing SparkR session.
as.data.frame

# as.data.frame function after initializing SparkR session.
sparkR.session() 
as.data.frame

# Use default data "faithful" and display it.
df <- as.data.frame(faithful) 
head(df) 

