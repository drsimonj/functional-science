#' Generate a correlation matrix with significance stars (*)
#'
#' This function correlates the columns of a matrix or dataframe, and returns
#' the results with stars indicating their level of statistical significance.
#' The stars are used to indicate the following significance levels: *** p <
#' .001, ** p < .01, * p < .05
#'
#' @export
#' @param vars A matrix or dataframe
#' @param ... Additional parameters to pass to psych::corr.test()
#' @return Correlation matrix with significance stars
#' @examples
#' starMatrix(iris[, -5])
starMatrix <- function(vars,...) {
  
  require(psych)
  
  # from psych package to compute correlations, n and p
  c.mat <- psych::corr.test(vars,...)
  
  # create matrix for correlations and p-values
  R <- c.mat$r
  p <- c.mat$p
  
  R <- format(round(cbind(rep(-1.11, ncol(R)), R), 2))[,-1]
  
  # define notions for significance levels; spacing is important.
  Stars <- ifelse(p < .001, "***", ifelse(p < .01, "** ", ifelse(p < .05, "* ", " ")))
  
  # build new matrix that includes the correlations with their apropriate stars
  r.new           <- matrix(paste(R, Stars, sep=""), ncol=ncol(R))
  diag(r.new)     <- paste(diag(R), " ", sep="")
  rownames(r.new) <- colnames(R)
  colnames(r.new) <- paste(colnames(R), "", sep="")
  
  # remove upper triangle
  r.new <- as.matrix(r.new)
  r.new[upper.tri(r.new, diag <- TRUE)] <- ""
  r.new <- as.data.frame(r.new)
  
  # remove last column & first Row and return the matrix (which is now a data frame)
  r.new <- cbind(r.new[1:length(r.new)-1])
  r.new <- cbind(r.new[2:nrow(r.new), ])
  return(r.new)
}