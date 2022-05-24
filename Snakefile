configfile: "config.yaml"

def get_batch_output_dirs(wildcards):
    import glob
    from pathlib import Path
    output_dirs = glob.glob(f"{config['assemblies_dir']}/*")
    output_dirs = list(map(lambda dir: f"{config['out_dir']}/{Path(dir).name}", output_dirs))
    print(output_dirs)
    return output_dirs

rule all:
    input: get_batch_output_dirs

rule run_mob_recon:
    input:
        batch_dir = f"{config['assemblies_dir']}/{{assembly_batch}}"
    output:
        batch_output = directory(f"{config['out_dir']}/{{assembly_batch}}")
    threads: 4
    resources:
        mem_mb=lambda wildcards, attempt: 4000 * attempt
    log:
        "logs/run_mob_recon/{assembly_batch}.log"
    conda: "envs/mob_suite.yaml"
    shell:
        """
        for file in `ls {input.batch_dir}/*.contigs.fa.gz`
        do
            sample_name=$(basename -- $file)
            mob_recon --infile $file --outdir {output.batch_output}/sample_name -t -c -n {threads}
        done
        """

