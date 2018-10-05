# docker-mysql

## Background

## Create and run docker container

### Preparation

The following programs need to be installed:

```console
git --version

docker --version
docker run hello-world
```

Optional:

```console
make --version
```

### Set Environment variables

These variables may be modified, but do not need to be modified.
The variables are used throughout the installation procedure.

```console
export GIT_ACCOUNT=docktermj
export GIT_REPOSITORY=docker-mysql
export DOCKER_IMAGE_TAG=mysql
export DOCKER_CONTAINER_NAME=mysql-container
```

Synthesize environment variables.

```console
export GIT_ACCOUNT_DIR=~/${GIT_ACCOUNT}.git
export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/${GIT_REPOSITORY}"
export GIT_REPOSITORY_URL="git@github.com:${GIT_ACCOUNT}/${GIT_REPOSITORY}.git"
```

### Clone repository

Get repository.

```console
mkdir --parents ${GIT_ACCOUNT_DIR}
cd  ${GIT_ACCOUNT_DIR}
git clone ${GIT_REPOSITORY_URL}
```

### Build Docker image

Option #1 - Using make command

```console
cd ${GIT_REPOSITORY_DIR}
make docker-build
docker images
```

Option #2 - Using docker command

```console
cd ${GIT_REPOSITORY_DIR}
docker build --tag ${DOCKER_IMAGE_TAG} .
docker images
```

### Run Docker container

Option #1 - Using make command

```console
cd ${GIT_REPOSITORY_DIR}
make docker-run
```

Option #2 - Using docker command

```console
cd ${GIT_REPOSITORY_DIR}
docker run -it --name ${DOCKER_CONTAINER_NAME} ${DOCKER_IMAGE_TAG}
```

### Push to hub.docker.com

1. Set Environment variables

    ```console
    export DOCKER_IMAGE_VERSION=1.0.0
    ```

1. Docker build

    ```console
    cd ${GIT_REPOSITORY_DIR}
    docker build \
      --tag dockter/mysql \
      --tag dockter/mysql:${DOCKER_IMAGE_VERSION} \
      .
    docker images
    ```

1. Push to hub.docker.com

    ```console
    docker push "dockter/mysql"
    ```