# Copyright@SCLBD
# Base image for DeepfakeBench
FROM pytorch/pytorch:1.12.0-cuda11.3-cudnn8-devel

LABEL maintainer="Deepfake"

# Install system dependencies
RUN DEBIAN_FRONTEND=noninteractive apt update && \
    apt install -y --no-install-recommends \
        automake \
        build-essential \
        ca-certificates \
        libfreetype6-dev \
        libtool \
        pkg-config \
        python-dev \
        python-distutils-extra \
        python3.7-dev \
        python3-pip \
        cmake \
        libgl1 \
        git \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3.7 0 \
    && python3.7 -m pip install --upgrade pip

WORKDIR /

# Install Rust (for packages like safetensors)
RUN apt update && apt install -y curl && \
    curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    export PATH="/root/.cargo/bin:$PATH" && \
    echo 'export PATH="/root/.cargo/bin:$PATH"' >> /etc/profile

ENV PATH="/root/.cargo/bin:${PATH}"

# Install Python dependencies in one layer
RUN pip install --no-cache-dir \
    certifi \
    albumentations==1.1.0 \
    setuptools==59.5.0 \
    dlib==19.24.0 \
    imageio==2.9.0 \
    imgaug==0.4.0 \
    scipy==1.7.3 \
    seaborn==0.11.2 \
    pyyaml==6.0 \
    imutils==0.5.4 \
    opencv-python==4.6.0.66 \
    scikit-image==0.19.2 \
    scikit-learn==1.0.2 \
    efficientnet-pytorch==0.7.1 \
    timm==0.6.12 \
    segmentation-models-pytorch==0.3.2 \
    torchtoolbox==0.1.8.2 \
    tensorboard==2.10.1 \
    loralib \
    pytorchvideo \
    einops \
    transformers \
    filterpy \
    simplejson \
    kornia \
    git+https://github.com/openai/CLIP.git

ENV MODEL_NAME=deepfakebench

# Expose port
EXPOSE 6000
