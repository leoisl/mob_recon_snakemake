configfile: "config.yaml"

def get_batch_output_dirs(wildcards):
    import glob
    from pathlib import Path
    output_dirs = glob.glob(f"{config['assemblies_dir']}/*")
    output_dirs = list(map(lambda dir: f"{config['out_dir']}/mob_recon/{Path(dir).name}", output_dirs))
    return output_dirs


rule all:
    input: get_batch_output_dirs


rule decompress_batch:
    input:
        batch_dir = f"{config['assemblies_dir']}/{{assembly_batch}}"
    output:
        batch_output = directory(f"{config['out_dir']}/decompression/{{assembly_batch}}")
    threads: 1
    resources: mem_mb=200
    log:
        "logs/decompress_batch/{assembly_batch}.log"
    shell:
        """
        mkdir -p {output.batch_output}
        for file in `ls {input.batch_dir}/*.contigs.fa.gz`
        do
            fasta_filename=$(basename -- $file)
            fasta_filename="${{fasta_filename%.*}}"
            gunzip -c -k -d $file > {output.batch_output}/${{fasta_filename}}
        done
        """


rule run_mob_recon:
    input:
        decompressed_batch_dir = rules.decompress_batch.output.batch_output
    output:
        batch_output = directory(f"{config['out_dir']}/mob_recon/{{assembly_batch}}")
    threads: 1
    resources:
        mem_mb=lambda wildcards, attempt: 4000 * attempt
    log:
        "logs/run_mob_recon/{assembly_batch}.log"
    container:
        config["mob_suite_container"]
    shell:
        """
        mkdir -p {output.batch_output}
        for file in `ls {input.decompressed_batch_dir}/*.contigs.fa`
        do
            sample_name=$(basename -- $file)
            sample_name="${{sample_name%.*}}"
            mob_recon --infile $file --outdir {output.batch_output}/${{sample_name}} -t -c -n {threads} 2>>{log}
        done
        """
