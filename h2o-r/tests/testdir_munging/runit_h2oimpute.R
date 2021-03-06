setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
source("../../scripts/h2o-r-test-setup.R")



test.h2o.impute<- function() {
  fr <- as.h2o(iris)
  h2o.insertMissingValues(fr)

  cat("Frame before imputation:\n")
  print(fr)

  # impute all columns
  res <- h2o.impute(fr,values = c(1.2,2.2,1.3,0.2,"setosa"))

  cat("Frame after imputation:\n")
  print(fr)

  fr <- as.h2o(iris)
  h2o.insertMissingValues(fr)

  # group by Species column and impute the first column, save the groupby result
  grpdRes <- h2o.impute(fr, 1, by=5)


  # use the saved groupby from the previous impute to impute the second column too!
  h2o.impute(fr, 2, groupByFrame=grpdRes)


  # impute the rest of the frame with the values from the original imputation
  h2o.impute(fr, values = c(1.2,2.2,1.3,0.2,"setosa"))
}

doTest("Test h2o.impute", test.h2o.impute)
