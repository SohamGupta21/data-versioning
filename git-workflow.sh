#!/bin/bash

# Git Workflow Helper Script
# This script helps you commit and push DVC changes
# Run this OUTSIDE the Docker container

set -e

echo "=========================================="
echo "Git Workflow for DVC Changes"
echo "=========================================="
echo ""
echo "This script will help you commit and push DVC tracking files."
echo "Make sure you're running this OUTSIDE the Docker container!"
echo ""

# Check git status
echo "Current git status:"
git status

echo ""
read -p "Press Enter to continue with git add . or Ctrl+C to cancel..."
git add .

echo ""
echo "Staged changes:"
git status

echo ""
read -p "Press Enter to commit or Ctrl+C to cancel..."
git commit -m 'dataset updates...'

echo ""
read -p "Press Enter to create tag 'dataset_v20' or Ctrl+C to cancel..."
git tag -a 'dataset_v20' -m 'tag dataset'

echo ""
echo "Ready to push. Current branch:"
git branch --show-current

echo ""
read -p "Press Enter to push to origin (main/master) with tag or Ctrl+C to cancel..."

# Get the current branch name
BRANCH=$(git branch --show-current)
git push --atomic origin "$BRANCH" dataset_v20

echo ""
echo "=========================================="
echo "✅ Git workflow complete!"
echo "=========================================="
echo ""
echo "Your dataset is now versioned and pushed to:"
echo "- Git repository: origin/$BRANCH"
echo "- Git tag: dataset_v20"
echo "- DVC remote: gs://cheese-app-data-versioning-soham/dvc_store"
echo ""

