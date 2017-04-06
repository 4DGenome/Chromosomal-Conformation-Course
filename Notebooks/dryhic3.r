#!/usr/bin/env Rscript

# dependencies

suppressMessages(library("data.table"))
library("dryhic")
library("dryhicdata")
suppressMessages(library("dplyr"))

# functions to interact with cPickle objects

read_cpickle <- function(infile){

    script_file <- system.file("src", "cpickle2tsv.py", package = "dryhic")
   
    tmp <- tempfile()

    on.exit(unlink(tmp))
    
    paste(script_file,
          infile,
          tmp) %>%
        system

    read.delim(tmp, head = F)

}

write_cpickle <- function(obj, outfile){

    script_file <- system.file("src", "tsv2cpickle.py", package = "dryhic")

    tmp <- tempfile()
    
    on.exit(unlink(tmp))

    write.table(obj, tmp, row.names = F, col.names = F, sep = "\t", quote = F)
    
    paste(script_file,
          tmp,
          outfile) %>%
        system
    
}


# get arguments

input <- commandArgs(trailingOnly = T)
reads <- input[1]
bad <- input[2]
enz <- input[3]
genome <- input[4]
reso <- as.numeric(input[5])
outfile <- input[6]

## reads <- "/mnt/cluster/ccc/valid_reads12_MboI.tsv"
## bad <- "/mnt/cluster/ccc/bad_columns_100000_MboI.pick"
## enz <- "MboI"
## genome <- "hg38"
## reso <- 100e3
## outfile <- "/mnt/cluster/ccc/test.pick"

options(stringsAsFactors = F)

# get data

chromosomes <- read.delim(reads, head = F, nrows = 100) %>%
    setNames(c("chr", "len")) %>%
    filter(grepl("^#", chr)) %>%
        mutate(chr = gsub("^.* ", "", chr),
               chr = ifelse(grepl("chr", chr), chr, paste0("chr", chr)),
               len = as.integer(len))

cat("Getting contacts\n")

dat <- fread(reads, skip = nrow(chromosomes), select = c(2, 3)) %>%
    mutate(chr = ifelse(grepl("chr", V2), V2, paste0("chr", V2)),
           bin = paste0(chr, ":", as.integer(floor(V3 / reso) * reso))) %>%
    group_by(bin) %>%
    summarize(tot = n()) %>%
    ungroup

allbins <- group_by(chromosomes, chr) %>%
    do(data.frame(pos = seq(0, len = ceiling(.$len / reso)))) %>%
    ungroup %>%
    as.data.frame %>%
    mutate(pos = as.integer(pos * reso),
           i = 1:n() - 1)

# get biases

cat("Getting genomic features\n")

enz <- ifelse(enz == "MboI", "DpnII", enz)

bias <- paste0("bias_", genome) %>%
    get %>%
    mutate(bin = paste0(chr, ":", as.integer(floor(pos / reso) * reso))) %>%
    group_by(bin) %>%
    summarize(cg = mean(cg, na.rm = T),
              map = mean(map, na.rm = T)) %>%
    ungroup

bias <- paste0("enzymes_", genome) %>%
    get %>%
    mutate(bin = paste0(chr, ":", as.integer(floor(pos / reso) * reso))) %>%
    mutate_(res = enz) %>%
    group_by(bin) %>%
    summarize(res = sum(res, na.rm = T)) %>%
    ungroup %>%
    inner_join(bias, by = "bin")

bias <- mutate(bias,
               chr = gsub(":.*$", "", bin),
               pos = gsub("^.*:", "", bin) %>% as.integer)

# merge

cat("Merging info\n")

dat <- right_join(dat, bias, by = "bin")
dat$tot[is.na(dat$tot)] <- 0

dat <- right_join(dat, allbins, by = c("chr", "pos"))

# get bad bins

cat("Getting bad bins\n")

badbins <- read_cpickle(bad)[,1]

dat$tot[dat$i %in% badbins] <- NA

# compute bias

cat("Computing biases\n")

res <- oned(dat)

out <- data.frame(i = 1:length(res) - 1,
                  b = res[match(dat$i, allbins$i)])
out$b[is.na(out$b)] <- min(out$b, na.rm = T) / 2

out$i <- as.integer(out$i)

cat("Storing results\n")

write_cpickle(out, outfile)

write.table(out, gsub(".pick", ".tsv", outfile), col.names = F, row.names = F, sep = "\t", quote = F)
