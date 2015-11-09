library(readxl)
library(reshape2)
library(ggplot2)

# Load data
setwd("/Users/andrew/Documents/Work/WBG/reproducibleresearch/wbg-rr/")

#download.file("http://www.doingbusiness.org/~/media/GIAWB/Doing%20Business/Documents/Miscellaneous/DB16-Distance-to-Frontier-dataset.xlsx",
#              "DB16-Distance-to-Frontier-dataset.xlsx")
db_dtf_new <- read_excel("DB16-Distance-to-Frontier-dataset.xlsx", sheet = 1)
db_dtf_old <- read_excel("DB16-Distance-to-Frontier-dataset.xlsx", sheet = 2)
db_dtf_new <- db_dtf_new[db_dtf_new$"DB Year" == 2015,c("Economy", "Overall")]
db_dtf_old <- db_dtf_old[db_dtf_old$"DB Year" == 2014,c("Economy","Overall (previous methodology)")]
colnames(db_dtf_old) <- c("country", "dtf_2014")
colnames(db_dtf_new) <- c("country", "dtf_2015")
rownames(db_dtf_old) <- NULL
rownames(db_dtf_new) <- NULL
db_dtf <- merge(db_dtf_old, db_dtf_new)

# Output correlation

cor(db_dtf$dtf_2015, db_dtf$dtf_2014)

# Simple plot

plot(db_dtf$dtf_2015, db_dtf$dtf_2014)

# Pretty plot

ggplot(db_dtf, aes(dtf_2015, dtf_2014)) +
  geom_point(shape=18, size=4, color="steelblue3") +
  scale_x_continuous(breaks=seq(30,100,10), limits = c(30, 100), expand=c(0,0)) +
  scale_y_continuous(breaks=seq(30,100,10), limits = c(30, 100), expand=c(0,0)) +
  theme_bw(base_size = 22) +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank()) +
  xlab("Distance to frontier score, 2015 (new method, 0-100)") +
  ylab("Distance to frontier score, 2014 (old methid, 0-100)") +
  geom_segment(aes(x = 30, y = 30, xend = 90, yend = 90), colour = "red")

ggsave("fig1.2butnot.png", dpi=96, width=12, height=8)
