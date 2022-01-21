FROM python:3.9-slim
RUN apt-get update -q && \
	apt-get install -yqq \
	curl \
	git \
	nginx \
	make \
	vim

# create user with a home directory
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER=${NB_USER}
ENV HOME=/home/${NB_USER}

RUN adduser --disabled-password \
	--gecos "Default user" \
	--uid ${NB_UID} \
	${NB_USER}

WORKDIR /work/
WORKDIR ${HOME}
USER ${NB_USER}
ENV PATH="/home/${NB_USER}/.local/bin:${PATH}"
ENV SHELL="/bin/bash"
COPY requirements.txt /tmp
RUN pip install -U pip
RUN pip install --no-cache -r /tmp/requirements.txt
COPY postBuild /tmp
COPY jupyter_notebook_config.py /root/.jupyter/
RUN sh /tmp/postBuild
