# Function to check which values (in a vector) are not valid
# 
# Args:
#   vals The values to be checked
#   accept Vector of acceptable values. Minimum and maximum for numeric, and all
#          possible for character or factor.
not_valid <- function(vals, accept) {
  
  # Find any invalid values
  if (is.numeric(vals)) {
    invalid <- vals < accept[1] | vals > accept[2]
  } else {
    invalid <- !(vals %in% accept)
  }
  
  # Replace any NA with FALSE
  invalid[is.na(invalid)] <- FALSE
  
  # Return NULL if no invalid values
  if (all(!invalid)) {
    return(NULL)
  }
  
  # Return a data frame with the indices and values of the invalid.
  data.frame(
    i   = which(invalid),
    val = vals[invalid]
  )
}

# Functions tests
not_valid(1:10, c(0, 4))
not_valid(1:10, c(0, 11))

not_valid(letters, c("a", "b", "c"))
not_valid(c("a", "b", "c"), letters)

# Practice data set
x <- data.frame(
  name   = c("Simon", "Jackson", "John", "Smith"),
  gender = factor(c("m", "f", "g", "a")),
  iq     = c(NA, -20, 100, 120),
  height = c(160, 170, 180, 190)
)

# List of values to accept for each variables
accept_list <- list(
  gender = c("m", "f"),
  iq     = c(0, 200),
  height = c(130, 230)
)

# Check for invalid values
a <- purrr::map(names(accept_list), ~not_valid(x[[.]], accept_list[[.]]))
names(a) <- names(accept_list)
a

# Replace invald values with NA
for (var in names(a)) {
  if (!is.null(a[[var]])) {
    x[a[[var]]$i, var] <- NA
  }
}
x 