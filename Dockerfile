FROM python:3.9-slim
RUN apt-get update -q && \
    apt-get install -yqq \
    git \
    nginx \
    make
 
### create user with a home directory
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    --shell /bin/bash \
    ${NB_USER}
WORKDIR ${HOME}
USER ${NB_USER}
ENV PATH /home/${NB_USER}/.local/bin:${PATH}
COPY requirements.txt /tmp
RUN pip install --no-cache -r /tmp/requirements.txt
COPY postBuild /tmp
RUN sh /tmp/postBuild
