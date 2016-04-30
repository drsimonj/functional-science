########################
#
# This Script preps example
# data sets.
#
#
########################

library(tidyr)

# BETWEEN-SUBJECTS ANOVA ========

# Paper Planes Experiment ---
# http://www.statsci.org/data/oz/planes.html
x <- read.table("http://www.statsci.org/data/oz/planes.txt", header = TRUE, sep = "\t")
x$Paper <- factor(x$Paper, levels = c(1, 2), labels = c("80gms", "50gms"))
x$Angle <- factor(x$Angle, levels = c(1, 2), labels = c("Horizontal", "45 Degrees"))
x$Design <- factor(x$Plane, levels = c(1, 2), labels = c("High-performance", "Incedibly simple"))
x$Plane <- x$Order <- NULL
write.csv(x, "data/planes.csv", row.names = F)

# Fishing Rod Experiment ---
# http://www.statsci.org/data/oz/fishing.html
x <- read.table("http://www.statsci.org/data/oz/fishing.txt", header = TRUE, sep = "\t")
x$rod <- factor(x$rod, levels = c(1, 2), labels = c("6ft", "7ft"))
x$line <- factor(x$line, levels = c(1, 2), labels = c("1kg", "2kg"))
x$sinker <- factor(x$sinker, levels = c(1, 2), labels = c("8oz", "12oz"))
x$order <- NULL
write.csv(x, "data/fishing.csv", row.names = F)

# WITHIN-SUBJECTS ANOVA ========

# Energy Requirements Running, Walking and Cycling
# http://www.statsci.org/data/general/energy.html
x <- read.table("http://www.statsci.org/data/general/energy.txt", header = TRUE, sep = "\t")
x <- x %>% gather(activity, energy, Running:Cycling)
x$Subject <- factor(x$Subject)
x$activity <- factor(x$activity)
write.csv(x, "data/energy.csv", row.names = F)


# MIXED ANOVA =============

# Rotary Pursuit Tracking
# http://www.statsci.org/data/general/tracking.html
x <- read.table("http://www.statsci.org/data/general/tracking.txt", header = TRUE, sep = "\t")
x$id <- 1:nrow(x)
x <- x %>% gather(trial, time, Trial1:Trial4)
x$trial <- factor(x$trial, levels = paste0("Trial", 1:4), labels = 1:4)
x$activity <- factor(x$activity)
write.csv(x, "data/energy.csv", row.names = F)



# 
# 
# summary(aov(distance ~ rod*line*sinker, x))
# 
# summary(aov(energy ~ activity, x))
# fit <- aov(energy ~ activity + Error(Subject / activity), x)
# summary(fit)
# plot(fit)
# 
# 
# fit <- aov(time ~ (trial * Shape) + Error(id / trial), x)
# summary(fit)
