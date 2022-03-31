
# Required packages -------------------------------------------------------
install.packages('remotes') # for installing packages from sources that aren't CRAN
library(remotes) # load the package

install_github("allisonhorst/palmerpenguins") #installing development version of dataset
#username/reponame to get stuff right from github
library(palmerpenguins) # loading the package which contains dataset we will use


install.packages('tidyverse')
library(tidyverse) # loading tidyverse package for ggplot etc.


# Session Info ------------------------------------------------------------
sessionInfo() #THIS POOPS OUT ALL THE INFORMATION ABOUT THE R VERSION, COMPUTER PLATFORM ETC that other people would like to see in a readme file~!

# R version 4.1.3 (2022-03-10)
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows 10 x64 (build 19042)
# 
# Matrix products: default
# 
# locale:
#   [1] LC_COLLATE=English_Canada.1252  LC_CTYPE=English_Canada.1252    LC_MONETARY=English_Canada.1252
# [4] LC_NUMERIC=C                    LC_TIME=English_Canada.1252    
# 
# attached base packages:
#   [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
#   [1] forcats_0.5.1        stringr_1.4.0        dplyr_1.0.8          purrr_0.3.4          readr_2.1.2         
# [6] tidyr_1.2.0          tibble_3.1.6         ggplot2_3.3.5        tidyverse_1.3.1      palmerpenguins_0.1.0
# [11] remotes_2.4.2       
# 
# loaded via a namespace (and not attached):
#   [1] tidyselect_1.1.2  haven_2.4.3       colorspace_2.0-3  vctrs_0.3.8       generics_0.1.2    utf8_1.2.2       
# [7] rlang_1.0.2       pkgbuild_1.3.1    pillar_1.7.0      glue_1.6.2        withr_2.5.0       DBI_1.1.2        
# [13] dbplyr_2.1.1      modelr_0.1.8      readxl_1.3.1      lifecycle_1.0.1   munsell_0.5.0     gtable_0.3.0     
# [19] cellranger_1.1.0  rvest_1.0.2       callr_3.7.0       tzdb_0.2.0        ps_1.6.0          curl_4.3.2       
# [25] fansi_1.0.2       broom_0.7.12      Rcpp_1.0.8.3      backports_1.4.1   scales_1.1.1      jsonlite_1.8.0   
# [31] fs_1.5.2          hms_1.1.1         stringi_1.7.6     processx_3.5.2    rprojroot_2.0.2   grid_4.1.3       
# [37] cli_3.2.0         tools_4.1.3       magrittr_2.0.2    crayon_1.5.1      pkgconfig_2.0.3   ellipsis_0.3.2   
# [43] xml2_1.3.3        prettyunits_1.1.1 reprex_2.0.1      lubridate_1.8.0   assertthat_0.2.1  httr_1.4.2       
# [49] rstudioapi_0.13   R6_2.5.1          compiler_4.1.3 

# Create data -------------------------------------------------------------
data(penguins, package = "palmerpenguins")

write.csv(penguins_raw, "raw_data/penguins_raw.csv", row.names = FALSE)

write.csv(penguins,"data/penguins.csv",row.names = FALSE)

# Load data ---------------------------------------------------------------
# and some preliminary data exploration
pen.data<-read.csv("data/penguins.csv")
str(pen.data)
glimpse(pen.data)

colnames(pen.data) #check the columns!
head(pen.data)
tail(pen.data)

pairs(pen.data[,c(3:6,8)]) # pairwise correlation plot of numeric columns
#[row, column] and we want columns 3:6 and 8 which are the numeric variables
?pairs # will give you information about the function

hist(pen.data$body_mass_g)  # make a histogram    
boxplot(pen.data$body_mass_g ~ pen.data$species) # boxplot of body mass x species

## lets try and save the figure as a pdf
pdf("outputs/wt_by_spp.pdf",
    width = 7,
    height = 5) # open a graphics device (everything you print to the screen while this is open will be saved to the file name that you give here), there are analogous functions for png and other image types
boxplot(pen.data$body_mass_g ~ pen.data$species,
        xlab="Species", ylab="Body Mass (g)") # print the boxplot to the pdf file
dev.off() #close the graphics device (very important to run this line or the pdf won’t save and will continue to add new plots that you run afterwards)

pen_fig <- pen.data %>% # calling on the data
  drop_na() %>%  # dropping "NAs" from the plot
  ggplot(aes(y = body_mass_g, x = sex, # aesthetic: y = body mass, x = sex
             colour = sex)) + # colour violin plots by sex
  facet_wrap(~species) + # each species will have it's own plot
  geom_violin(trim = FALSE, # violin plot, turn off trim the edges
              lwd = 1) + # make the lines thick
  theme_bw() + # black and white background theme
  theme(text = element_text(size = 12), # change the text size
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        strip.text = element_text(size=12),
        legend.position = "none") + # remove the legend
  labs(y = "Body Mass (g)", # specify labels on axes
       x = " ") +
  scale_colour_manual(values = c("black", "darkgrey"))

pen_fig

ggsave("outputs/pen_fig.jpeg", pen_fig, # save figure to output directly from ggplot, you can specify the resolution of the final figure here (its in inches right now)
       width = 7,
       height = 5)