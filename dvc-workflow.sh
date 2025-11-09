#!/bin/bash

# DVC Workflow Helper Script
# This script helps you run DVC commands inside the container

set -e

echo "=========================================="
echo "DVC Data Versioning Workflow"
echo "=========================================="
echo ""
echo "This script will guide you through the DVC workflow."
echo "Make sure you're running this INSIDE the Docker container!"
echo ""
echo "Your GCS bucket: cheese-app-data-versioning-soham"
echo ""

# Check if we're in the container (basic check)
if [ ! -f "/.venv/bin/activate" ]; then
    echo "⚠️  WARNING: This doesn't look like the Docker container environment."
    echo "   Make sure you're inside the container before running DVC commands."
    echo ""
fi

echo "Step 1: Initialize DVC (if not already done)"
echo "Command: dvc init"
echo ""
read -p "Press Enter to run 'dvc init' or Ctrl+C to cancel..."
dvc init

echo ""
echo "Step 2: Add Remote Registry to GCS Bucket"
echo "Command: dvc remote add -d cheese_dataset gs://cheese-app-data-versioning-soham/dvc_store"
echo ""
read -p "Press Enter to add remote or Ctrl+C to cancel..."
dvc remote add -d cheese_dataset gs://cheese-app-data-versioning-soham/dvc_store

echo ""
echo "Step 3: Add the dataset to registry"
echo "Command: dvc add cheese_dataset"
echo ""
read -p "Press Enter to add dataset or Ctrl+C to cancel..."
dvc add cheese_dataset

echo ""
echo "Step 4: Push to Remote Registry"
echo "Command: dvc push"
echo ""
read -p "Press Enter to push to GCS or Ctrl+C to cancel..."
dvc push

echo ""
echo "=========================================="
echo "✅ DVC workflow complete!"
echo "=========================================="
echo ""
echo "Next steps (run these OUTSIDE the container):"
echo "1. Exit the container: exit"
echo "2. Run: git status"
echo "3. Run: git add ."
echo "4. Run: git commit -m 'dataset updates...'"
echo "5. Run: git tag -a 'dataset_v20' -m 'tag dataset'"
echo "6. Run: git push --atomic origin main dataset_v20"
echo ""

