[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ml-starter-packs/microservice-workshop/main?urlpath=vscode/)

# microservice-workshop

This repository hosts the computational environment required to run the following repos:
- https://github.com/ml-starter-packs/flask-backend
- https://github.com/ml-starter-packs/cgi-backend
- https://github.com/ml-starter-packs/flask-frontend

by leveraging [mybinder.org](https://mybinder.org), a free service which provides an ephemeral cloud computing environment.


## Developer Environments

In your Terminal, you may want to run `PS1=\$\ `, with `echo PS1=\"\$\ \" >> ~/.bashrc` for it to persist.

### `/proxy/.../`

To visit services (html pages), change your url to end with `{unique-binder-id}/proxy/{PORT}/` (trailing slash included).

### `/vscode`

Code-Server: [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ml-starter-packs/microservice-workshop/main?urlpath=vscode/)

`[Cmd/Ctrl] + Shift + P -> Add Folder to Workspace -> [Enter]`, and your home directory will show up on the left.

To open the Terminal, `Ctrl + ^`.


### `/lab`

Lab: [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ml-starter-packs/microservice-workshop/main?urlpath=lab)

Click on the badge above and you will be launched into a jupyter session.
Your file system is visible on the left-panel, and "apps" are available in the center.
Open a `Terminal` and start checking out the example repos!


### `/tree`

Tree: [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ml-starter-packs/microservice-workshop/main?urlpath=tree)

Classic Notebook view. Use the button on the top right: `Run > Terminal`, but note that multiple terminals (which you may want) will require multiple tabs to view.

## Running with Docker (locally)
This project was set up to work with both mybinder.org and a local docker build which will launch `code-server` by default.
To use it, run

```bash
docker build -t microservices-demo .
docker run --name demo-env -p 5000:5000 microservices-demo
```

or using `docker-compose.yml`:
```bash
version: "3"

services:
  demo:
    container_name: demo-env
    image: microservices-demo
    build:
      dockerfile: Dockerfile
      context: .
    ports:
      - "5000:5000"
    command: code-server --auth none --bind-addr 0.0.0.0 --port 5000
    #command: jupyter lab --ip 0.0.0.0 --port 5000
```
