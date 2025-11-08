# IIITH-MFA-Assignment-Someshwaran

## 1. MFA Environment Setup

```bash
# Initialize Conda
source /opt/miniconda3/etc/profile.d/conda.sh
conda init zsh

# Create and activate MFA environment
conda config --add channels conda-forge
conda create -n mfa -c conda-forge montreal-forced-aligner
conda activate mfa

# Verify installation
mfa version  # Output: 3.3.8
```

## 2. Data Preparation

Input folder contains audio files and transcript text files. Output folder is created empty for TextGrid files.

## 3. Baseline Alignment

```bash
mfa align \
    /home/somesh/Desktop/input \
    /home/somesh/Documents/MFA/pretrained_models/dictionary/english_us_arpa.dict \
    /home/somesh/Documents/MFA/pretrained_models/acoustic/english_us_arpa.zip \
    /home/somesh/Desktop/output \
    --clean
```

**Output:** TextGrid files saved in `/home/somesh/Desktop/output`

## 4. Analysis

Phoneme analysis included in attached PDF.

---

## Extra Credit

### 1. Custom Dictionary (Fixing OOV Words)

**Problem:** Baseline `english_us_arpa` dictionary failed on OOV words: `Dukakis`, `WBUR'S`, `melnicove`, `politicize`, `maffy` (resulted in `spn` mismatches).

**Solution:** Generated custom dictionary using G2P:

```bash
mfa g2p \
    /home/somesh/Desktop/input \
    /home/somesh/Documents/MFA/pretrained_models/g2p/english_us_arpa.zip \
    /home/somesh/Documents/MFA/pretrained_models/dictionary/custom_dictionary.dict \
    --clean
```

Re-ran alignment with `custom_dictionary.dict`.

### 2. Acoustic Model Comparison

Compared two acoustic models:
- `english_us_arpa` (with `custom_dictionary.dict`)
- `english_mfa` (with `custom_dictionary_mfa.dict`)

**Issue:** `custom_dictionary.dict` incompatible with `english_mfa` due to different phoneme sets (stress markers).

**Solution:** Generated MFA-compatible dictionary:

```bash
mfa g2p \
    /home/somesh/Desktop/input \
    /home/somesh/Documents/MFA/pretrained_models/g2p/english_us_mfa.zip \
    /home/somesh/Documents/MFA/pretrained_models/dictionary/custom_dictionary_mfa.dict \
    --clean
```

Ran alignment with MFA model:

```bash
mfa align \
    /home/somesh/Desktop/input \
    /home/somesh/Documents/MFA/pretrained_models/dictionary/custom_dictionary_mfa.dict \
    /home/somesh/Documents/MFA/pretrained_models/acoustic/english_mfa.zip \
    /home/somesh/Desktop/output_mfa \
    --clean
```

**Result:** Compared `alignment_analysis.csv` files. `english_mfa` had higher log-likelihood for some files, `english_us_arpa` for others.

### 3. Automation Script

Created `run_pipeline.sh` to automate the ARPA model pipeline (downloads models, generates custom dictionary, runs alignment).

**Usage:**

```bash
chmod +x run_pipeline.sh
./run_pipeline.sh
```
