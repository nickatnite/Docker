# Engine Docker container
This directory contains the Dockerfile defining the docker
configuration as well as a script to build the container.


# Building the docker image
Before the docker image can be built, it should be configured.
Configuration is located in two places:

1. Config files in this directory
2. The `build.sh` file

First, create three files in this directory with the proper
configuration for each app: `engine_config.py`, `erp_config.py`, and
`geod_config.py`. These files should have the same config variables as
found in the `config/__init__.py` in each of the repos, but set to the
proper values for the environment into which the container is to be
deployed.

Next, adjust the "<REPO>_COMMIT" variables in `build.sh` to point to
the proper branch in the corresponding repository. The branches listed
in these variables will be checked out and copied into the image.

Once the configuration is finished, build the container by running the
script:

    $ ./build.sh
