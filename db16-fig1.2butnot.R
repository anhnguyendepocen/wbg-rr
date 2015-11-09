library(readxl)
library(reshape2)
library(ggplot2)

# Load data

#db<-read_excel("http://www.doingbusiness.org/~/media/GIAWB/Doing%20Business/Documents/Miscellaneous/DB16-Distance-to-Frontier-dataset.xlsx"
db_dtf <- read_excel("DB16-Distance-to-Frontier-dataset.xlsx")
db_dtf <- db_dtf[db_dtf$"DB Year" %in% c(2015,2016),c("Economy", "DB Year", "Overall")]
colnames(db_dtf) <- c("country", "year", "dtf")
rownames(db_dtf) <- NULL

# Cast two most recent years

db_rs <- dcast(db_dtf, country ~ year, value.var = "dtf")
colnames(db_rs) <- c("country", "dtf_2015", "dtf_2016")

# Output correlation

cor(db_rs$dtf_2016, db_rs$dtf_2015)

# Simple plot

plot(db_rs$dtf_2016, db_rs$dtf_2015)

# Pretty plot

ggplot(db_rs, aes(dtf_2016, dtf_2015)) +
  geom_point(shape=18, size=4, color="steelblue3") +
  scale_x_continuous(breaks=seq(30,100,10), limits = c(30, 100), expand=c(0,0)) +
  scale_y_continuous(breaks=seq(30,100,10), limits = c(30, 100), expand=c(0,0)) +
  theme_bw(base_size = 22) +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank()) +
  xlab("Distance to frontier score, 2016 (0-100)") +
  ylab("Distance to frontier score, 2015 (0-100)") +
  geom_segment(aes(x = 30, y = 30, xend = 90, yend = 90), colour = "red")

ggsave("fig1.2butnot.png", dpi=72)
