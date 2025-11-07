# IIITH-MFA-Assigment-Someshwaran

## 1. MFA Environment Setup

1. Initialize Conda for Your Shell (Zsh)
    
    Run these commands, then close and re-open your terminal.
    
    Bash
    
    ```
    source /opt/miniconda3/etc/profile.d/conda.sh
    conda init zsh
    ```
    
2. Create and Activate MFA Environment
    
    After re-opening your terminal (you should see (base) in your prompt), run the following:
    
    Bash
    
    ```
    # Add conda-forge channel
    conda config --add channels conda-forge
    
    # Create the 'mfa' environment
    conda create -n mfa -c conda-forge montreal-forced-aligner
    
    # Activate the environment
    conda activate mfa
    ```
    
3. Verify Installation

    Your prompt should now be (mfa).

    ```
    mfa version
    output: 3.3.8 
    ```

   
## 2. Data Preparation

MFA requires the input data in a way that input folder has both the audio files and the text file of the transcripts and we make one more output folder which is empty so that our textgrid files can be saved there.

## 3. Run the Alignment

This command aligns the corpus using a pre-trained English model and dictionary.

Bash

```
# Ensure your (mfa) environment is active
mfa align \
    /home/somesh/Desktop/input \
    /home/somesh/Documents/MFA/pretrained_models/dictionary/english_us_arpa.dict \
    /home/somesh/Documents/MFA/pretrained_models/acoustic/english_us_arpa.zip \
    /home/somesh/Desktop/output \
    --clean
```

### Command Arguments Used:

- **Corpus:** `/home/somesh/Desktop/input`
    
- **Dictionary:** `/home/somesh/Documents/MFA/pretrained_models/dictionary/english_us_arpa.dict`
    
- **Acoustic Model:** `/home/somesh/Documents/MFA/pretrained_models/acoustic/english_us_arpa.zip`
    
- **Output Directory:** `/home/somesh/Desktop/output`
    

## 4. Inspect Output

The generated `.TextGrid` files are saved in the output directory.

- **Output Location:** `/home/somesh/Desktop/output`

I have added the analysis of the phenomes in the pdf attached with the mail.
