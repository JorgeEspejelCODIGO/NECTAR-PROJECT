# Step 1: Install and load required libraries
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")
if (!require(tidyr)) install.packages("tidyr")
library(ggplot2)
library(dplyr)
library(tidyr)

# Step 2: Set your working directory to where the data file is stored
setwd("~/Desktop/NECTAR-PROJECT")  # Adjust this path to where the CSV file is located

# Step 3: Load the dataset into R
bee_data <- read.csv("cleaned_bee_nectar_data.csv", stringsAsFactors = FALSE)

# Step 4: Basic visualization of sugar concentration distribution
ggplot(bee_data, aes(x = sugar_concentration)) +
  geom_histogram(binwidth = 2, fill = "blue", color = "black", alpha = 0.7) +
  labs(
    title = "Distribution of Sugar Concentration",
    x = "Sugar Concentration (%)",
    y = "Frequency"
  ) +
  theme_minimal()

# Step 5: Boxplot of sugar concentration by family
ggplot(bee_data, aes(x = Family, y = sugar_concentration)) +
  geom_boxplot(fill = "lightblue", color = "black", outlier.color = "red") +
  labs(
    title = "Sugar Concentration by Family",
    x = "Family",
    y = "Sugar Concentration (%)"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
###########

# Install and load required libraries
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")
if (!require(tidyr)) install.packages("tidyr")
if (!require(sf)) install.packages("sf")
if (!require(rnaturalearth)) install.packages("rnaturalearth")
if (!require(rnaturalearthdata)) install.packages("rnaturalearthdata")

library(ggplot2)
library(dplyr)
library(tidyr)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

# Load world map data
world <- ne_countries(scale = "medium", returnclass = "sf")

# Summarize sugar concentration by continent
continent_summary <- bee_data %>%
  gather(key = "Region", value = "Presence", europe:australia) %>%
  filter(Presence == "yes") %>%
  group_by(Region) %>%
  summarise(
    mean_sugar = mean(sugar_concentration, na.rm = TRUE),
    sd_sugar = sd(sugar_concentration, na.rm = TRUE),
    n = n()
  ) %>%
  mutate(label = paste0("N = ", n, "\nMean = ", round(mean_sugar, 1), "\nSD = ", round(sd_sugar, 1)))

# Coordinates for continent labels (approximate)
continent_coords <- data.frame(
  Region = c("europe", "asia", "africa", "north_america", "south_america", "australia"),
  lon = c(10, 100, 20, -100, -60, 135),
  lat = c(50, 40, 0, 45, -15, -25)
)

# Merge summary with coordinates
continent_summary <- continent_summary %>%
  inner_join(continent_coords, by = "Region")

# Plot the world map with sugar concentration summary
ggplot(data = world) +
  geom_sf(fill = "gray95", color = "gray80") +
  geom_point(data = continent_summary, aes(x = lon, y = lat, size = mean_sugar, color = mean_sugar), alpha = 0.8) +
  geom_text(data = continent_summary, aes(x = lon, y = lat - 10, label = label), size = 3, hjust = 0.5) +
  scale_color_viridis_c(name = "Mean Sugar Concentration") +
  scale_size_continuous(name = "Mean Sugar Concentration") +
  labs(
    title = "Sugar Concentration by Continent",
    subtitle = "Mean and SD of nectar sugar concentration (%)",
    x = NULL,
    y = NULL
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    panel.grid = element_blank()
  )
##########
# Does locations have a significant impact on sugar concentration?
# the choice between ANOVA and Kruskal-Wallis depends on the following considerations:
#Shapiro-Wilk test
# If p > 0.05: The data is approximately normal, and ANOVA can be used.
#If p ≤ 0.05p: The data is not normal, so a non-parametric test like Kruskal-Wallis is more appropriate.
# Shapiro-Wilk test for normality of sugar concentration
shapiro_test <- shapiro.test(bee_data$sugar_concentration)
print(shapiro_test)
# W = 0.97619, p-value = 1.182e-06
#This means the sugar concentration data does not follow a normal distribution.
# We use Kruskal-Wallis test
###########
# If p ≤ 0.05, there are significant differences in sugar concentration between continents.

# Prepare the data
long_data <- bee_data %>%
  gather(key = "Continent", value = "Presence", europe:australia) %>%
  filter(Presence == "yes")

# Perform the Kruskal-Wallis test
kruskal_test <- kruskal.test(sugar_concentration ~ Continent, data = long_data)
print(kruskal_test)

# Kruskal-Wallis chi-squared = 1.0451, df = 5, p-value = 0.9588
#Since  p = 0.9588 is much greater than 0.05, we fail to reject the null hypothesis.
# This means there is no statistically significant difference in sugar concentration between continents
############
# Boxplot of sugar concentration by continent
ggplot(long_data, aes(x = Continent, y = sugar_concentration, fill = Continent)) +
  geom_boxplot(outlier.color = "red", alpha = 0.7) +
  stat_summary(fun = mean, geom = "point", shape = 20, size = 3, color = "black", fill = "black") +
  labs(
    title = "Sugar Concentration Across Continents",
    subtitle = "Kruskal-Wallis Test Result: p-value = 0.9588 (No Significant Differences)",
    x = "Continent",
    y = "Sugar Concentration (%)"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 12, face = "italic")
  )
#########
# Add a column to classify crop genera (adjust as needed based on your data)
bee_data <- bee_data %>%
  mutate(
    crop = ifelse(type == "crop", "Crop", "Non-Crop")  # Adjust this based on your data
  )

# Create a boxplot of sugar concentration by genus
ggplot(bee_data, aes(x = reorder(Genus, sugar_concentration, FUN = median), y = sugar_concentration, fill = crop)) +
  geom_boxplot(outlier.color = "black", alpha = 0.8) +
  geom_hline(yintercept = c(65, 35, 20), linetype = "dashed", color = c("red", "orange", "yellow"), size = 0.8) +
  annotate("text", x = 1, y = 66, label = "Optimal (>65%)", hjust = 0, color = "red", size = 3) +
  annotate("text", x = 1, y = 36, label = "Adequate (35–65%)", hjust = 0, color = "orange", size = 3) +
  annotate("text", x = 1, y = 21, label = "Low (<35%)", hjust = 0, color = "yellow", size = 3) +
  labs(
    title = "Nectar Sugar Concentration on a Genus Level",
    subtitle = "Crop genera are highlighted in red. KW test: Chi-sq = 1.045, p = 0.9588",
    x = "Genus",
    y = "Sugar Concentration (%)",
    fill = "Type"
  ) +
  scale_fill_manual(values = c("Crop" = "red", "Non-Crop" = "gray")) +
  theme_minimal() +
  theme(
    legend.position = "top",
    axis.text.x = element_text(angle = 90, hjust = 1, size = 8),
    plot.title = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 12, face = "italic")
  )
#########
#Just for crops
# Filter the dataset for crop genera
crop_data <- bee_data %>%
  filter(type == "crop")  # Adjust this column based on how crop/non-crop is labeled in your data

# Create the boxplot for crop genera
ggplot(crop_data, aes(x = reorder(Genus, sugar_concentration, FUN = median), y = sugar_concentration, fill = Genus)) +
  geom_boxplot(outlier.color = "black", alpha = 0.8) +
  geom_hline(yintercept = c(65, 35, 20), linetype = "dashed", color = c("red", "orange", "yellow"), size = 0.8) +
  annotate("text", x = 1, y = 66, label = "Optimal (>65%)", hjust = 0, color = "red", size = 3) +
  annotate("text", x = 1, y = 36, label = "Adequate (35–65%)", hjust = 0, color = "orange", size = 3) +
  annotate("text", x = 1, y = 21, label = "Low (<35%)", hjust = 0, color = "yellow", size = 3) +
  labs(
    title = "Nectar Sugar Concentration for Crop Genera",
    subtitle = "Showing only genera classified as crops",
    x = "Genus",
    y = "Sugar Concentration (%)"
  ) +
  scale_fill_brewer(palette = "Set3") +
  theme_minimal() +
  theme(
    legend.position = "none",
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    plot.title = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 12, face = "italic")
  )


