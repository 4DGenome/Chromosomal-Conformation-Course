# Chromosomal Conformation Course
<p>
<img align="right" src=/Documents/Logo/Foto-DNA_MMarti_0.jpg?raw=True>
<h2>Course description</h2><br>
3C-based methods, such as Hi-C, produce a huge amount of raw data as pairs of DNA reads that are in close spatial proximity in the cell nucleus. Overall, those interaction matrices have been used to study how the genome folds within the nucleus, which is one of the most fascinating problems in modern biology. The rigorous analysis of those paired-reads using computational tools has been essential to fully exploit the experimental technique, and to study how the genome is folded in the space. Currently, there is a clear expansion on the wealth of data on genome structure with the availability of many datasets of Hi-C experiments down to 1Kb resolution (see for example: http://hic.umassmed.edu/welcome/welcome.php ; http://promoter.bx.psu.edu/hi-c/view.php or http://www.aidenlab.org/data.html ). In this course, participants will learn to use TADbit, a software designed and developed to manage all dimensionalities of the Hi-C data:
</p>


 - 1D - Map paired-end sequences to generate Hi-C interaction matrices
 - 2D - Normalize matrices and identify constitutive domains (TADs, compartments)
 - 3D - Generate populations of structures which satisfy the Hi-C interaction matrices
 - 4D - Compare samples at different time points

Participants can bring- specific biological questions and/or their own 3C-based data to analyze during the course. At the end of the course, participants will be familiar with the TADbit software and will be able to fully analyze Hi-C data. Note: Although the TADbit software is central in this course, alternative software will be discussed for each part of the analysis.

## Target Audience

The course design is oriented towards experimental researchers and bioinformaticians at the graduate and post-graduate levels. The last edition of this course was attended by people with different backgrounds and interested in the genome organization.
Moreover, Hi-C data have recently been used in metagenomics studies to accurately cluster metagenome assembly contigs into groups that contain nearly complete genomes of each species.
It is likely that the participants to this course aim at getting involved in generating Hi-C data for chromosome structure determination or that they just want to be able to correctly interpret and analyse publicly available data. 

## Course Pre-requisites

Recommended Linux and basic Python programming skills, graduate level in Life Sciences.


## Content

|                  | Lectures (pdf)                          | Core pipeline (notebooks)               | Annex (notebooks)                 |
|-------------------|----------------|-------------------------|------------|
| Day1 | <ul><li>[Intro UNIX](/Presentations/Day1/linux.pdf)</li><li>[Intro Python](/Presentations/Day1/python.pdf)</ul></li> | | <ul><li>[Software installation](/Notebooks/A0-Preparing_your_computer_for_HiC_data_analysis.ipynb)</li></ul> |
| Day2 | <ul><li>[Intro TADbit](/Presentations/Day2/Intro_TADbit.pdf)</li><li>[NGS in HiC](/Presentations/Day2/NGS_for_HiC.pdf)</li></ul>| <ul><li>[Hi-C Quality check](/Notebooks/00-Hi-C_quality_check.ipynb)</li><li>[Mapping](/Notebooks/01-Mapping.ipynb)</li></ul> | <ul><li>[Prepare reference genome](/Notebooks/A1-Preparation_reference_genome.ipynb)</li><li>[Download Hi-C experiment](/Notebooks/A2-Download_published_Hi-C_experiments.ipynb)</li></ul> |
| Day3 | <ul><li>[From HiC to 3D models](/Presentations/Day3/from_hic_to_3D.pdf)</li></ul>|  |  |
| Day4 | <ul><li>[Normalization & comparison](/Presentations/Day2/02_20161012_NormalizationComparison.pdf)</li></ul>| <ul><li>[Parsing mapped reads](/Notebooks/02-Parsing_mapped_reads.ipynb)</li><li>[Filterind reads](/Notebooks/03-Filtering_mapped_reads.ipynb)</li><li>[Normalization](Notebooks/04-Bin-filtering_and_normalization.ipynb)</li></ul> | <ul><li>[Compare/merge experiments](/Notebooks/A3-Compare_and_merge_Hi-C_experiments.ipynb)</li></ul> |
| Day5 | <ul></ul>| <ul><li>[Compartments and TADs](/Notebooks/05-Compartments_and_TADs.ipynb)</li><li>[Parameter optimization](/Notebooks/06a-Modeling_-_parameter_optimization.ipynb)</li><li>[Model optimization](/Notebooks/06b-Modeling_-_model_optimization.ipynb)</li></ul> | <ul><li>[Align and compare TADs](/Notebooks/A4-Align_and_compare_TADs.ipynb)</li><li>[Analysis of 3D models](/Notebooks/A5-Modeling_-_analysis_of_3D_models.ipynb)</li></ul> | |

## TADbit tools

Most of the tasks of the "core pipeline" can be tunned directly from command line (without any python), using [TADbit tool](/TADbit_tools). Have a look to the commands, and the metadata of the results. 

_For now TADbit tool is not incuded in the general documetation, as it is still "under construction". Use it carefully, and don't hesitate to repport anyweird behaviour you observe._


## TADbit version

This tutorial is associated with a __specific version of TADbit__, if you wish to reproduce exactly the results in the notebooks you should use the version of TADbit tagged `CRG_CCc_2017`.

To install this version do:

    git clone https://github.com/3dgenomes/tadbit
    cd tadbit
    git checkout tags/CRG_CCc_2017
    sudo python setup.py install


- http://www.crg.eu/en/event/coursescrg-chromosomal-conformation-0



