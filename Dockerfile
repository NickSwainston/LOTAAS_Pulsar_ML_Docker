FROM ubuntu:18.04

# Install dependancies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y python \
    python-tk \
    python-pip \
    git \
    default-jre
RUN pip install scipy \
    numpy \
    matplotlib

# Install PulsarFeatureLab
WORKDIR /home/soft
RUN git clone --single-branch --branch V1.3.2 https://github.com/scienceguyrob/PulsarFeatureLab && \
    chmod 755 PulsarFeatureLab/PulsarFeatureLab/Src/*py && \
    cp PulsarFeatureLab/PulsarFeatureLab/Src/*py /usr/local/bin

# Install LOTAAS Classifier
RUN git clone https://github.com/scienceguyrob/LOTAASClassifier && \
    chmod 755 LOTAASClassifier/dist/LOTAASClassifier.jar && \
    cp LOTAASClassifier/dist/LOTAASClassifier.jar /usr/local/bin

# Install this repos scripts and data
COPY . /home/soft/
ENV LOTAAS_MLC_MODEL_DIR /home/soft/models
RUN cp /home/soft/LOTAAS_wrapper.py /usr/local/bin



