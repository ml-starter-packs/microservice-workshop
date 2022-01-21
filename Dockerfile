FROM python:3.9-slim
RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	curl && \
	echo "getting latest install script" && \
	curl -fsSL https://code-server.dev/install.sh > install.sh && \
	sh install.sh && \
	rm install.sh && \
	apt-get -qq purge curl && \
	apt-get -qq purge && \
	apt-get -qq clean && \
	rm -rf /var/lib/apt/lists/*

RUN apt-get update -q && \
	apt-get install -yqq \
	curl \
	git \
    htop \
	nginx \
	make \
	tmux \
	vim \
	&& \
	apt-get -qq purge && \
	apt-get -qq clean && \
	rm -rf /var/lib/apt/lists/*

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
COPY jupyter_notebook_config.py /home/${NB_USER}/.jupyter/
RUN sh /tmp/postBuild

CMD code-server --auth none --bind-addr 0.0.0.0 --port 5000
