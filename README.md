# Nextflow Pipeline with Conda

We are attempting sequential and parallel processing with Nextflow. We will take two small paired-end test FASTQ files and run them through fastp for QC control. Then we will take those outputs and run them
in parallel through spades and seqkit!

## 💻 System & Software Requirements
- **Nextflow version**: 24.10.5 build 5935
- **Package manager**: Conda (Miniconda3)
- **Operating System**: Ubuntu 22.04
- **Architecture**: x86_64
- **Device**: HP Spectre laptop with 2 CPU cores

## 🧬 Workflow Overview

![image](https://github.gatech.edu/nkodgi3/Nextflow/assets/97635/f81ce00e-2fc0-45c0-b3f6-63b73d026cf8)


The pipeline performs the following steps:

1. Runs `fastp` on raw FASTQ data (quality filtering)
2. Uses `fastp` output to:
   - Run `spades` for de novo assembly
   - Run `seqkit` for basic read statistics  
   *(spades and seqkit run in parallel)*

## 📦 Test Data

This repo includes two small paired-end test FASTQ files derived from the SRA run [SRR15268468](https://www.ncbi.nlm.nih.gov/sra/SRR15268468) (*Listeria monocytogenes*).

They are located in the `data/` folder:

## ▶️ How to Run

Install [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) and [Miniconda](https://docs.conda.io/en/latest/miniconda.html) and create Nextflow environment:

```bash
conda create -n nf -c bioconda nextflow -y
conda activate nf
nextflow -version
```

Now clone directory to get started:

```bash
git clone https://github.gatech.edu/nkodgi3/Nextflow.git
cd Nextflow/my_pipeline
nextflow run main.nf -profile test 
```
This runs it on debug mode so you can see if an errors occur!

##  🛠 Having Problems? Here Are More Debugging Tips!

First of all make sure you have the right repo structure from the download. 

![image](https://github.gatech.edu/nkodgi3/Nextflow/assets/97635/2e467572-3d5c-4182-9120-3c219692054b)

If not that's not the problem, here are some Nextflow commands that help with debugging:

```bash
nextflow log # See history of pipeline runs
nextflow run main.nf -profile test -resume # Skip recomputing successful steps
nextflow validate main.nf -profile test # Check pipeline syntax
nextflow run main.nf -profile test -with-trace # Record timing/resource usage in trace.txt
```
