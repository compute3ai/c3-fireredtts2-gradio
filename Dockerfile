# Base image with CUDA runtime
ARG MAX_JOBS=2
ARG EXT_PARALLEL=1
FROM nvidia/cuda:12.9.1-cudnn-devel-ubuntu24.04

ARG MAX_JOBS
ARG EXT_PARALLEL

# Set CUDA architectures for building without GPUs
ENV TORCH_CUDA_ARCH_LIST="8.0;8.6;8.7;8.9;12.0"

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    MAX_JOBS=${MAX_JOBS} \
    EXT_PARALLEL=${EXT_PARALLEL} \
    CMAKE_BUILD_PARALLEL_LEVEL=${MAX_JOBS}

# Install Python and required packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    git \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Set up workspace directory
WORKDIR /app

# Create virtual environment
RUN python3 -m venv /app/venv

# Use shell form for commands that need to source the activation script
SHELL ["/bin/bash", "-c"]

# Install torch first (stable layer - cached separately)
RUN source /app/venv/bin/activate && \
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu129

# Install flash-attn (separate layer - long compile time)
RUN source /app/venv/bin/activate && \
    pip install packaging ninja wheel psutil && \
    pip install flash-attn --no-build-isolation

# ============== ABOVE IS CACHED FROM VIBEVOICE ==============

# Install torchcodec (required by torchaudio for audio loading)
RUN source /app/venv/bin/activate && \
    pip install torchcodec

# Copy requirements file
COPY requirements.txt /app/

# Install other requirements
RUN source /app/venv/bin/activate && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install huggingface_hub

# Copy fireredtts2 package and install
COPY setup.py /app/
COPY fireredtts2 /app/fireredtts2
RUN source /app/venv/bin/activate && pip install -e .

# Copy app files
COPY app.py /app/
COPY gradio_demo.py /app/
COPY examples /app/examples

# Expose the port for the Gradio web interface
EXPOSE 7860

# Command to run when the container starts
CMD ["/app/venv/bin/python", "app.py"]
