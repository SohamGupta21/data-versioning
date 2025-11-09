#!/bin/bash

set -e

echo "Container is running!!!"
echo "Architecture: $(uname -m)"
echo "Python version: $(python --version)"
echo "UV version: $(uv --version)"

# Authenticate with GCP service account
echo "Authenticating with GCP service account..."
gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS

# Mount GCS bucket to volume mount
echo "Mounting GCS bucket: $GCS_BUCKET_NAME to /mnt/gcs_data..."
mkdir -p /mnt/gcs_data
gcsfuse --key-file=$GOOGLE_APPLICATION_CREDENTIALS $GCS_BUCKET_NAME /mnt/gcs_data
echo "GCS bucket mounted at /mnt/gcs_data"

# Wait a moment for the mount to be ready
sleep 2

# Mount the "images" folder from bucket mount to "/app/cheese_dataset"
echo "Binding images folder to /app/cheese_dataset..."
mkdir -p /app/cheese_dataset

# Check if images folder exists in the bucket
if [ ! -d "/mnt/gcs_data/images" ]; then
    echo "Warning: /mnt/gcs_data/images does not exist. Creating it..."
    mkdir -p /mnt/gcs_data/images
fi

# Bind mount the images folder
mount --bind /mnt/gcs_data/images /app/cheese_dataset
echo "Images folder mounted at /app/cheese_dataset"

# Activate virtual environment
echo "Activating virtual environment..."
source /.venv/bin/activate

# Keep a shell open
echo "Setup complete! Ready for DVC operations."
exec /bin/bash