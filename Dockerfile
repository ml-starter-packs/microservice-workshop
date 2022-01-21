FROM python:3.9-slim
COPY apt.txt /tmp
RUN cat /tmp/apt.txt | apt-get install --yes --no-install-recommends
### create user with a home directory
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
RUN pip install --no-cache notebook jupyterlab jupyter-server-proxy
