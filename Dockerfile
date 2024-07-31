FROM runpod/pytorch:2.2.0-py3.10-cuda12.1.1-devel-ubuntu22.04

MAINTAINER Tristan Everitt <tristan.everitt2@mail.dcu.ie>

# Based on https://github.com/runpod/containers/tree/main/official-templates/base
# and https://github.com/runpod/containers/blob/main/official-templates/pytorch/Dockerfile



RUN apt-get update --yes && \
    apt-get upgrade --yes && \
    apt install --yes --no-install-recommends git tree htop wget p7zip-full gzip unzip jq curl nano vim bash libgl1 software-properties-common


RUN pip install --upgrade --no-cache-dir pip
RUN pip install --no-cache-dir torch==2.2.0 torchdata==0.7.1  torchtext==0.17.0
RUN pip install flash-attn --no-build-isolation
RUN pip install transformers datasets sentencepiece sentence-transformers tabulate tokenizers accelerate evaluate protobuf peft bitsandbytes hf_transfer huggingface_hub scikit-learn pandas numpy scipy tiktoken einops pytest dask tqdm polars awscli
RUN pip install nltk

RUN apt-get autoremove -y &&  apt-get clean &&  rm -rf /var/lib/apt/lists/*

# Faster transfer of models from the hub to the container
ENV HF_HUB_ENABLE_HF_TRANSFER="1"

ENV HF_HOME="/workspace/.huggingface/"
ENV HF_DATASETS_CACHE="/workspace/.huggingface/datasets/"
ENV DEFAULT_HF_METRICS_CACHE="/workspace/.huggingface/metrics/"
ENV DEFAULT_HF_MODULES_CACHE="/workspace/.huggingface/modules/"
ENV HUGGINGFACE_HUB_CACHE="/workspace/.huggingface/hub/"
ENV HUGGINGFACE_ASSETS_CACHE="/workspace/.huggingface/assets/"

WORKDIR /workspace



