FROM mambaorg/micromamba:2.0.8-cuda12.2.2-ubuntu20.04

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    libosmesa6-dev libgl1-mesa-glx libglfw3 patchelf sudo build-essential\
    && rm -rf /var/lib/apt/lists/*

RUN echo "$MAMBA_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $MAMBA_USER

COPY --chown=$MAMBA_USER:$MAMBA_USER conda_environment.yaml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes
