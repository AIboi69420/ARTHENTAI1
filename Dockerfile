# Use official PyTorch image with CUDA support
FROM pytorch/pytorch:2.1.0-cuda11.8-cudnn8-runtime

# Set working directory
WORKDIR /app

# Install system packages
RUN apt-get update && apt-get install -y git

# Copy project files
COPY requirements.txt ./
COPY main.py ./
COPY run.sh ./

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Expose API port
EXPOSE 8000

# Start the FastAPI app
CMD ["./run.sh"]
