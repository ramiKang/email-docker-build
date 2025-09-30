FROM nvidia/cuda:12.5.1-base-ubuntu22.04 as base
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG C.UTF-8

COPY setup.sources.sh /setup.sources.sh
COPY setup.packages.sh /setup.packages.sh
COPY gpu.packages.txt /gpu.packages.txt
RUN /setup.sources.sh && \
    /setup.packages.sh /gpu.packages.txt

ARG PYTHON_VERSION=python3.9
COPY setup.python.sh /setup.python.sh
COPY gpu.requirements.txt /gpu.requirements.txt
RUN /setup.python.sh $PYTHON_VERSION /gpu.requirements.txt && \
    pip install --no-cache-dir jupyterlab tensorflow && \
    pip3 install --no-cache-dir torch --index-url https://download.pytorch.org/whl/cu126

# Customize Bash Environment & Jupyter Terminal Config
RUN touch /root/.bashrc && \
    echo "PS1='\[\e[1;32m\]\u@\h:\w\$\[\e[0m\] '" >> /root/.bashrc && \
    echo "alias ll='ls -alh --color=auto'" >> /root/.bashrc && \
    jupyter server --generate-config && \
    echo "c.ServerApp.terminado_settings = {'shell_command': ['/bin/bash']}" >> /root/.jupyter/jupyter_server_config.py

WORKDIR /workspacee

# Setup Default Command
CMD ["bash"]
