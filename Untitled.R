# Step 1: Set your working directory to where the data file is stored
setwd("~/Desktop/NECTAR-PROJECT")  # Adjust this path to where your CSV file is located

# Step 2: Load the dataset into R
bee_data <- read.csv("cleaned_bee_nectar_data.csv", stringsAsFactors = FALSE)

# Step 3: Check the structure of the data to ensure it loaded correctly
str(bee_data)

# Optionally, view the first few rows of the dataset to confirm
head(bee_data)

########

# Step 1: Filter the data for the Fabaceae family
fabaceae_data <- bee_data[bee_data$Family == "Fabaceae", ]

# Step 2: Select only the columns we need: sci_name, sugar_concentration, and type
fabaceae_filtered <- fabaceae_data[, c("sci_name", "sugar_concentration", "type")]

# Step 3: Check the structure of the new table to make sure it's correct
str(fabaceae_filtered)

# Optionally, view the first few rows of the filtered data
head(fabaceae_filtered)

######

# Create the mapping between your dataset's species names and the Open Tree of Life's species names
name_mapping <- c(
  "Onobrychis viciiaefolia" = "Onobrychis_cyri_ott213478",
  "Trifolium repens" = "Trifolium_repens_ott116218",
  "Lotus corniculatus" = "Lotus_corniculatus_ott183572",
  "Vicia nigricans" = "Vicia_nigricans_ott238365",
  "Crotalaria micans" = "Crotalaria_micans_ott227361",
  "Pongamia pinnata" = "Pongamia_pinnata_ott170183",
  "Trifolium pratense" = "Trifolium_pratense_ott839027",
  "Trifolium hybridium" = "Trifolium_hybridum_ott1066895",
  "Trifolium incarnatum" = "Trifolium_incarnatum_ott705473",
  "Medicago falcata" = "Medicago_falcata_ott1030374",
  "Melilotus albus" = "Melilotus_albus_ott38042",
  "Styphnolobium japonica" = "Styphnolobium_japonicum_ott935514",
  "Adesmia candida" = "Adesmia_candida_ott593511",
  "Adesmia filipes" = "Adesmia_filipes_ott3926236",
  "Adesmia serrana" = "Adesmia_serrana_ott3926330",
  "Anthrophyllum rigidum" = "Anarthrophyllum_rigidum_ott393217",
  "Astragalus cruckshanksii" = "Astragalus_cruckshanksii_ott1093759",
  "Hoffmannseggia trifolata" = "Hoffmannseggia_trifoliata_ott517680",
  "Hoffmannseggia erecta" = "Hoffmannseggia_erecta_ott517690",
  "Adesmia volkmanni" = "Adesmia_volckmannii_ott674927",
  "Adesmia obcordata" = "Adesmia_obcordata_ott1064241",
  "Adesmia villosa" = "Adesmia_villosa_ott853739"
)

# Apply the mapping to the 'sci_name' column in your table using dplyr's recode function
library(dplyr)

fabaceae_filtered <- fabaceae_filtered %>%
  mutate(sci_name = recode(sci_name, !!!name_mapping))

# Check the updated table to ensure that names have been changed
head(fabaceae_filtered)

# Step 2: Check for species names that didn't get mapped (i.e., NA values)
missing_species <- fabaceae_filtered$sci_name[is.na(fabaceae_filtered$sci_name)]
if(length(missing_species) > 0) {
  print("Species with no match in name_mapping:")
  print(missing_species)
}

########

# Step 1: Remove duplicates by averaging sugar concentrations
# Group by the 'sci_name' and calculate the mean of sugar concentrations for duplicates
fabaceae_filtered_valid <- fabaceae_filtered[!is.na(fabaceae_filtered$sci_name), ]

# Aggregate sugar concentration by 'sci_name', calculating the average for duplicates
fabaceae_filtered_cleaned <- fabaceae_filtered_valid %>%
  group_by(sci_name) %>%
  summarise(sugar_concentration = mean(sugar_concentration, na.rm = TRUE), 
            type = first(type))  # Take the first 'type' (assuming it doesn't change for each species)

# Print the cleaned table
print(fabaceae_filtered_cleaned)


###########

# Load required libraries
library(rotl)
library(ape)

# Step 1: Extract the list of species names from the cleaned table
species_names <- fabaceae_filtered_cleaned$sci_name
print(species_names)

# Step 2: Match species names with Open Tree of Life
taxa <- tnrs_match_names(names = species_names)
      
####

# Step 3: Check which names are unmatched
unmatched_species <- taxa[is.na(taxa$ott_id), "submitted_name"]
# Step 4: Print out the unmatched species names
if(length(unmatched_species) > 0) {
  print("The following species were not matched in the Open Tree of Life:")
  print(unmatched_species)
} else {
  print("All species were matched successfully!")
}
#########

# Step 1: Extract the OTT IDs for the matched species
ott_ids <- taxa$ott_id[!is.na(taxa$ott_id)]  # Only take valid OTT IDs (those that were matched)

# Step 2: Fetch the phylogenetic tree for the matched species
if(length(ott_ids) > 1) {  # At least two valid IDs are needed to build the tree
  fabaceae_tree <- tol_induced_subtree(ott_ids = ott_ids)
  
  # Step 3: Visualize the Phylogenetic Tree
  plot(fabaceae_tree, cex = 0.8, main = "Phylogenetic Tree for Fabaceae Species")
} else {
  print("Not enough valid OTT IDs to create a tree.")
}
###########
# Fetch the OTT ID for the Fabaceae family
fabaceae_family_ott_ids <- tnrs_match_names(names = "Fabaceae")
print(fabaceae_family_ott_ids)


