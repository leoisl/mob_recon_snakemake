# MOB recon snakemake

Parallelises running `mob_recon` with `snakemake`.

# Dependencies

* `snakemake`;
* `singularity`;

# Configuration

Edit `config.yaml` to set the input and output directories,
`mob_suite` container image and `mob_recon` parameters.
Look at the [config.yaml](config.yaml) for an example.

# Running

LSF cluster:

```
bash submit_lsf.sh
```

Locally:
```
bash run_local.sh
```
