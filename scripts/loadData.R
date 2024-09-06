# Create a setup ----

dir.create("data")
dir.create("scripts")
dir.create("output")
dir.create("documents")


download.file(
  url = "https://github.com/carpentries-incubator/bioc-rnaseq/raw/main/episodes/data/GSE96870_counts_cerebellum.csv", 
  destfile = "data/GSE96870_counts_cerebellum.csv"
)
download.file(
  url = "https://github.com/carpentries-incubator/bioc-rnaseq/raw/main/episodes/data/GSE96870_coldata_cerebellum.csv", 
  destfile = "data/GSE96870_coldata_cerebellum.csv"
)
download.file(
  url = "https://github.com/carpentries-incubator/bioc-rnaseq/raw/main/episodes/data/GSE96870_coldata_all.csv", 
  destfile = "data/GSE96870_coldata_all.csv"
)
download.file(
  url = "https://github.com/carpentries-incubator/bioc-rnaseq/raw/main/episodes/data/GSE96870_rowranges.tsv", 
  destfile = "data/GSE96870_rowranges.tsv"
)

# loading library ----
library(AnnotationDbi)
library(org.Mm.eg.db)
library(hgu95av2.db)
library(SummarizedExperiment)

# loading data

## load counts ----
counts <- read.csv("data/GSE96870_counts_cerebellum.csv", row.names = 1)
head(counts)
dim(counts)
str(counts)
View(counts)
