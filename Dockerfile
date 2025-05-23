# Dockerfile
# ---------------------------
# Use official Python image with CUDA support
FROM pytorch/pytorch:2.1.0-cuda11.8-cudnn8-runtime

# Set up environment
WORKDIR /app

# Install system packages
RUN apt-get update && apt-get install -y git

# Copy files
COPY requirements.txt ./
COPY main.py ./

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Expose port
EXPOSE 8000

# Run the API
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
