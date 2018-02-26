#!/usr/bin/env bash

# Clone repos at specified branch; use shallow cloning to minimize
# network traffic.
export ENGINE_URL="git@github.com:xxxxxxxxxx/xxxxxxxxxx_engine.git"
export ENGINE_COMMIT="master"

export ERP_URL="git@github.com:xxxxxxxxxx/xxxxxxxxxx_erp.git"
export ERP_COMMIT="master"

export GEOD_URL="git@github.com:xxxxxxxxxx/xxxxxxxxxx_geod.git"
export GEOD_COMMIT="master"

git clone --depth 1 --branch $ENGINE_COMMIT $ENGINE_URL
git clone --depth 1 --branch $ERP_COMMIT $ERP_URL
git clone --depth 1 --branch $GEOD_COMMIT $GEOD_URL


# Configure apps in container.
# Choose what environment to build. Case-sensitive choices are:
# * production
# * qaA
# * qaB
# * dev
# * DevOps
export ENV="production"

echo "Configuring container for $ENV"
sleep 1

if [ $ENV != "dev" ]; then
    aws s3 cp s3://xxxxxxxxxx-xxxxxxxxxx-pkg/web/$ENV/xxxxxxxxxx_engine_config.py .
    aws s3 cp s3://xxxxxxxxxx-xxxxxxxxxx-pkg/web/$ENV/xxxxxxxxxx_erp_config.py .
    aws s3 cp s3://xxxxxxxxxx-xxxxxxxxxx-pkg/web/$ENV/xxxxxxxxxx_geod_config.py .
fi

mv xxxxxxxxxx_erp_config.py xxxxxxxxxx_erp/config/config.py
cp xxxxxxxxxx_erp/config/config.py xxxxxxxxxx_erp/config/env_config.py
mv xxxxxxxxxx_geod_config.py xxxxxxxxxx_geod/config.py
mv xxxxxxxxxx_engine_config.py xxxxxxxxxx_engine/config.py


# Remove superfluous files to decrease size.
rm -rf xxxxxxxxxx_engine/tests
rm -rf xxxxxxxxxx_engine/.git


# Build the container.
docker build -t engine-$ENV .

# Clean up.
echo "Cleaning up."
rm -rf xxxxxxxxxx_engine \
    xxxxxxxxxx_erp \
    xxxxxxxxxx_geod
