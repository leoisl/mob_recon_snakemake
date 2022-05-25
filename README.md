# MOB recon snakemake

Parallelises running `mob_recon` with `snakemake`.

# Dependencies

* `python`;
* `snakemake`;
* `conda`;
* `mamba`;


# Setup

We need some steps to setup the pipeline due to [mob-suite](https://github.com/phac-nml/mob-suite) database locking issues.snakemake

1. Setup code and create conda envs
```
git clone https://github.com/leoisl/mob_recon_snakemake  # clone this repo
snakemake -j1 --use-conda --conda-create-envs-only  # create the conda envs
```

2. Make `mob-suite` databases directory unwritable
```
chmod ugo-w .snakemake/
```

# Running

LSF cluster:

```
bash submit_lsf.sh
```

Locally:
```
bash run_local.sh
```
