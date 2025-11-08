#!/usr/bin/env bash
#
# Automates the full MFA alignment pipeline for the assignment.
#

# Exit immediately if any command fails
set -e

echo "===== STARTING ALIGNMENT PIPELINE ====="

# --- 1. Paths and Model Names ---
INPUT_DIR="/home/somesh/Desktop/input"
MODEL_DIR="/home/somesh/Documents/MFA/pretrained_models"
OUTPUT_DIR="/home/somesh/Desktop/output"

ACOUSTIC_MODEL="english_us_arpa"
G2P_MODEL="english_us_arpa"
CUSTOM_DICT="custom_dictionary.dict"


# --- 2. Activate Conda Environment ---
echo "Activating Conda environment 'mfa'..."
source /opt/miniconda3/etc/profile.d/conda.sh
conda activate mfa


# --- 3. Download Required Models ---
echo "Downloading required models (if not present)..."
mfa model download acoustic ${ACOUSTIC_MODEL}
mfa model download g2p ${G2P_MODEL}


# --- 4. Generate Custom Dictionary ---
echo "Generating custom dictionary: ${CUSTOM_DICT}..."
mfa g2p \
    ${INPUT_DIR} \
    ${MODEL_DIR}/g2p/${G2P_MODEL}.zip \
    ${MODEL_DIR}/dictionary/${CUSTOM_DICT} \
    --clean

# --- 5. Run Alignment ---
echo "Running alignment with ${ACOUSTIC_MODEL} model..."
mfa align \
    ${INPUT_DIR} \
    ${MODEL_DIR}/dictionary/${CUSTOM_DICT} \
    ${MODEL_DIR}/acoustic/${ACOUSTIC_MODEL}.zip \
    ${OUTPUT_DIR} \
    --clean

# --- 6. Finalization ---
echo ""
echo "===== AUTOMATION COMPLETE ====="
echo "Alignment TextGrids are in: ${OUTPUT_DIR}"
