suppressPackageStartupMessages({
  library(AnnotationDbi)
  library(org.Mm.eg.db)
  library(hgu95av2.db)
  library(SummarizedExperiment)
})

counts <- read.csv("data/GSE96870_counts_cerebellum.csv", row.names = 1)
dim(counts)

coldata <- read.csv("data/GSE96870_coldata_cerebellum.csv",row.names = 1)
dim(coldata)

rowranges <- read.delim("data/GSE96870_rowranges.tsv", 
                        sep = "\t", 
                        colClasses = c(ENTREZID = "character"),
                        header = TRUE, 
                        quote = "", 
                        row.names = 5)
dim(rowranges)
table(rowranges$gbkey)

all.equal(colnames(counts), rownames(coldata)) 
all.equal(rownames(counts), rownames(rowranges)) # genes


# Check again:
all.equal(colnames(counts), rownames(coldata)) 


all.equal(rownames(counts), rownames(rowranges)) 

stopifnot(rownames(rowranges) == rownames(counts), # features
          rownames(coldata) == colnames(counts)) # samples

se <- SummarizedExperiment(
  assays = list(counts = as.matrix(counts)),
  rowRanges = as(rowranges, "GRanges"),
  colData = coldata
)

head(assay(se))
head(colData(se))

se$Label <- paste(se$sex, se$time, se$mouse, sep = "_")
se$Label

colnames(se)

colnames(se) <- se$Label

# Our samples are not in order based on sex and time
se$Group <- paste(se$sex, se$time, sep = "_")
se$Group

# change this to factor data with the levels in order 
# that we want, then rearrange the se object:

se$Group <- factor(se$Group, levels = c("Female_Day0","Male_Day0", 
                                        "Female_Day4","Male_Day4",
                                        "Female_Day8","Male_Day8"))
se <- se[, order(se$Group)]
colData(se)

se$Label <- factor(se$Label, levels = se$Label)

colnames(coldata)
table(coldata$infection)

# Create subsets of se for infected and non-infected samples
se_infected <- se[, se$Infection == "Infected"]
se_noninfected <- se[, se$Infection == "Non-Infected"]


  
