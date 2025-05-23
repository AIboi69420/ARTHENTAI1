# Use official PyTorch image with CUDA support
FROM pytorch/pytorch:2.1.0-cuda11.8-cudnn8-runtime

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y git

# Copy requirements and source files
COPY requirements.txt ./
COPY main.py ./
COPY run.sh ./

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Make run.sh executable
RUN chmod +x run.sh

# Expose port for FastAPI/Uvicorn
EXPOSE 8000

# Start the API with run.sh
CMD ["./run.sh"]
