# MOB recon snakemake

Parallelises running `mob_recon` with `snakemake`.

# Dependencies

* `python`;
* `snakemake`;
* `conda`;
* `mamba`;


# Setup

We need some steps to setup the pipeline due to [mob-suite](https://github.com/phac-nml/mob-suite) database locking issues.

1. Setup code and create conda envs
```
git clone https://github.com/leoisl/mob_recon_snakemake  # clone this repo
cd mob_recon_snakemake
snakemake -j4 --use-conda --conda-create-envs-only  # create the conda envs
```

2. Make `mob-suite` databases directory unwritable
```
chmod -R ugo-w .snakemake/conda/988b6b9b759f6a95e5855e82ee71d450/lib/python3.8/site-packages/mob_suite/databases
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
