# "Data" project

This is the final project for the subject "Data Acquisition Analysis and Scientific Methods for Life Sciences" shorted as "Data" from the first course of the Master Plant Health at the Universitat Politècnica de València.

In this project the students chose a scientific article and redo all possible statistic analyses and graphics from it, trying different approaches to see if they can improve them. They will use the data included in the article and follow the Material and methods chapter as a guide.

## Group members

Group B: 

Espejel, Mehedi, Thomas, Ei Mon 

## Chosen article

[The nectar report: quantitative review of nectar sugar concentrations offered by bee visited flowers in agricultural and non-agricultural landscapes](https://peerj.com/articles/6329/)

## Proposal

The dataset includes nectar sugar concentrations for various plant species, classified by taxonomic details (Family, Genus, species) and geographical presence (continents). This data can be used to explore ecological and geographical patterns influencing nectar sugar concentration.

I see your data have only one dependent variable (sugar concentration) and the independent variables of species and countries. It is not enough to do a multivariate analyses. 

But on the other side you have several plant species and can learn how to relate them using their phylogenetic relations. This will make the project more interesting. I want you to relate the sugar concentration with the phylogeny. 

For the phylogenetic relationships you can follow the "Tree of life" database and this tutorial to start: https://mctavishlab.github.io/BIO144/labs/rotl-rgbif.html

### Objectives

Objectives

Primary Objective:

To investigate the relationships between plant taxonomy (e.g., family, genus), geography and nectar sugar concentration.

Secondary Objective

To analyze sugar concentration variability within high-performing families and identify key genera.

Hypotheses

Primary Hypothesis:

H₀ (Null Hypothesis): There is no significant relationship between plant taxonomy (family, genus) and nectar sugar concentration.

H₁ (Alternative Hypothesis): Plant taxonomy significantly affects nectar sugar concentration.

Secondary Hypotheses:

Geographical Variation:

H₀: Nectar sugar concentration does not vary significantly across geographical regions (continents or hemispheres).

H₁: Nectar sugar concentration varies significantly across geographical regions.

Taxonomic Contribution:

H₀: Within high-performing families, genera do not significantly differ in their contributions to higher average sugar concentrations.

H₁: Certain genera within high-performing families significantly drive higher average sugar concentrations.

### Analysis

1. Summary Statistics:

Objective: Summarize nectar sugar concentration by Family, Genus, and Region.

Analyses:

Grouped data by Family, Genus, and Region to compute:

Mean: To determine average sugar concentration.

Median: To measure central tendency, reducing outlier effects.

Range: To understand variability in sugar concentration.

Standard Deviation (SD): To quantify data spread.

Interquartile Range (IQR): To capture variability while ignoring extreme values.

Visualized the mean sugar concentration by Family and Region using barplots.

2. Kruskal-Wallis Test for Taxonomic Effects:

Objective: Evaluate the relationship between taxonomy and nectar sugar concentration.

Analyses:

Conducted Kruskal-Wallis tests for sugar concentration across:

Families and Genera to detect significant differences.

Visualized results with a heatmap highlighting significant p-values for Family and Genus comparisons.

3. Pairwise Comparisons with Dunn’s Test:

Objective: Identify pairwise differences in nectar sugar concentration.

Analyses:

Performed Dunn’s test for pairwise comparisons at both:

Family and Genus levels.

Adjusted p-values using the Bonferroni correction.

Highlighted significant pairwise comparisons in barplots.

4. Linear Mixed-Effects Model:

Objective: Assess variability in nectar sugar concentration within and across Families and Genera.

Analyses:

Fitted a linear mixed-effects model:

Included Genus nested within Family as random effects.

Examined fixed and random effects.

Visualized random effects using histograms and barplots for top/bottom genera.

5. Geographical Effects on Sugar Concentration:

Objective: Explore geographical variability in nectar sugar concentration.

Analyses:

Tested sugar concentration across continents using:

ANOVA (if data were normal) or Kruskal-Wallis (if non-normal).

Visualized results with boxplots and geospatial maps highlighting mean sugar concentration per region.

6. Ecological Effects (Crops vs. Weeds):

Objective: Compare sugar concentration between crops and weeds.

Analyses:

Created boxplots to visualize differences between plant types.

Used Kruskal-Wallis tests to test for significant differences.

Performed Dunn’s test for pairwise comparisons between plant types.

7. High-Performing Families:

Objective: Analyze sugar concentration variability within families with high average values.

Analyses:

Identified families with mean sugar concentration > 55%.

Conducted ANOVA to evaluate differences among genera within these families.

Visualized variability using boxplots.

8. Phylogenetic Analysis:

Objective: Assess evolutionary patterns in nectar sugar concentration.

Analyses:

Matched Family names with Open Tree of Life identifiers.

Constructed a phylogenetic tree and tested for phylogenetic signal.

Mapped sugar concentration as a heatmap on the tree.

9. Heatmap of Sugar Concentration by Family:

Objective: Visualize sugar concentration aligned with phylogenetic tree order.

Analyses:

Aligned Family order from the phylogenetic tree.

Mapped mean sugar concentration using a heatmap.

Adjusted visualization for improved readability.


## Files description

## Protocol
