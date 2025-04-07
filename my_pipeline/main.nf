#!/usr/bin/env nextflow

params.reads1 = "data/test_1.fastq.gz"
params.reads2 = "data/test_2.fastq.gz"

process fastp {
    conda 'envs/fastp.yml'

    input:
    path reads1
    path reads2

    output:
    path "cleaned_1.fastq.gz"
    path "cleaned_2.fastq.gz"

    script:
    """
    fastp -i ${reads1} -I ${reads2} -o cleaned_1.fastq.gz -O cleaned_2.fastq.gz 
    """
}

process spades {
    conda 'envs/spades.yml'

    input:
    path cleaned1
    path cleaned2

    output:
    path "spades_output"

    script:
    """
    mkdir spades_output
    spades.py -1 ${cleaned1} -2 ${cleaned2} -o spades_output
    """
}

process seqkit_stats {
    conda 'envs/seqkit.yml'

    input:
    path cleaned1
    path cleaned2

    output:
    path "seqkit_stats.txt"

    script:
    """
    seqkit stats ${cleaned1} ${cleaned2} > seqkit_stats.txt
    """
}

workflow {
    reads1 = file(params.reads1)
    reads2 = file(params.reads2)

    cleaned = fastp(reads1, reads2)

    spades(cleaned[0], cleaned[1])
    seqkit_stats(cleaned[0], cleaned[1])
}
