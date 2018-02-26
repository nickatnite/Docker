#!/bin/bash -x

set -eu -o pipefail

###########################################
# AFTER RUNNING step1_build_base.sh #######
# THIS SCRIPT WILL BUILD CONTAINER  #######
# AND CONFIGURE THE APACHE SERVER   #######
######### Nick Ascione ####################

REGISTRY=xxxxxxxxxx
DOCKER_REPOSITORY=xom-qa-web
LOCAL_AWS_CONFIG_FILE_DIR=`eval echo ~/.aws`
DOCKER_BUILD_WEB_ROOT=$(pwd)
DOCKER_FILE=Dockerfile-web
MODELS_WHL=xxxxxxxxxx_models-1.3.4-py2-none-any.whl
ENV=$1

cd ${DOCKER_BUILD_WEB_ROOT}

###########################################
# FETCH ARTIFACTS FROM ARTIFACTORY ########
# CURRENTLY THIS IS AN S3 BUCKET   ######## 
###########################################

###########################################
## GRAB APACHE CONFIGURATION FROM S3  #####
###########################################
aws s3 cp s3://xxxxxxxxxx-xxxxxxxxxx-pkg/web/httpd_configs.tar.gz .
tar -xzvf httpd_configs.tar.gz
# cp -R ../s3_local_files/httpd_configs .

###### CONFFIGURE APACHE ##################
if [ "$ENV" == 'qaa' ]; then
    WEBMASTER_EMAIL='webmaster@xxxxxxxxxx.com'
    ERP_URL='qaa-erp.xxxxxxxxxx.net'
    GET_URL='qaa-get.xxxxxxxxxx.net'
    WORK_URL='qaa-work.xxxxxxxxxx.net'
    API_URL='qaa-api.xxxxxxxxxx.net'
elif [ "$ENV" == 'qab' ]; then
    WEBMASTER_EMAIL='webmaster@xxxxxxxxxx.com'
    ERP_URL='qab-erp.xxxxxxxxxx.net'
    GET_URL='qab-get.xxxxxxxxxx.net'
    WORK_URL='qab-work.xxxxxxxxxx.net'
    API_URL='qab-api.xxxxxxxxxx.net'
elif [ "$ENV" == 'prod' ]; then
    WEBMASTER_EMAIL='webmaster@xxxxxxxxxx.com'
    ERP_URL='erp.xxxxxxxxxx.com'
    GET_URL='get.xxxxxxxxxx.com'
    WORK_URL='work.xxxxxxxxxx.com'
    API_URL='api.xxxxxxxxxx.com'
fi

cd ${DOCKER_BUILD_WEB_ROOT}/httpd_configs/prod/apache2/sites-enabled/
mv app.conf app_temp.conf
cat app_temp.conf   | sed "s/EMAIL-TAG/${WEBMASTER_EMAIL}/g" > app_temp2.conf
cat app_temp2.conf   | sed "s/ERP-TAG/${ERP_URL}/g" > app_temp3.conf
cat app_temp3.conf   | sed "s/WORK-TAG/${WORK_URL}/g" > app_live.conf

mv api.conf api_temp.conf
cat api_temp.conf   | sed "s/EMAIL-TAG/${WEBMASTER_EMAIL}/g" > api_temp2.conf
cat api_temp2.conf   | sed "s/API-TAG/${API_URL}/g" >  api_live.conf

mv quote.conf quote_temp.conf
cat quote_temp.conf | sed "s/EMAIL-TAG/${WEBMASTER_EMAIL}/g" >  quote_temp2.conf
cat quote_temp2.conf | sed "s/GET-TAG/${GET_URL}/g" >  quote_live.conf

mv ../apache2.conf apache2_temp.conf
cat apache2_temp.conf | sed "s/EMAIL-TAG/${WEBMASTER_EMAIL}/g" >  apache2_temp2.conf
cat apache2_temp2.conf | sed "s/GET-TAG/${GET_URL}/g" >  ../apache2.conf

mv 000-default.conf 000-default_temp.conf
cat 000-default_temp.conf | sed "s/GET-TAG/${GET_URL}/g" > 000-default_temp2.conf
cat 000-default_temp2.conf | sed "s/ERP-TAG/${ERP_URL}/g" > 000-default_temp3.conf
cat 000-default_temp3.conf | sed "s/API-TAG/${API_URL}/g" > 000-default_temp4.conf
cat 000-default_temp4.conf | sed "s/WORK-TAG/${WORK_URL}/g" > 000-default_temp5.conf
cat 000-default_temp5.conf | sed "s/EMAIL-TAG/${WEBMASTER_EMAIL}/g" > 000-default.conf

rm -f *_temp*.conf

## AFTER CONFIGURATION MOVE TO  ${DOCKER_BUILD_WEB_ROOT} FOR COPY TO DOCKER
cd ${DOCKER_BUILD_WEB_ROOT}
cp -a  ${DOCKER_BUILD_WEB_ROOT}/httpd_configs/prod/apache2/ ${DOCKER_BUILD_WEB_ROOT}/apache2-ready
cp -a  ${DOCKER_BUILD_WEB_ROOT}/httpd_configs/prod/ssl/ ${DOCKER_BUILD_WEB_ROOT}/ssl-ready/

# SETUP NEW RELIC
cd ${DOCKER_BUILD_WEB_ROOT}
mkdir -p var/www/web/newrelic_config/
# Use local configs for now
aws s3 cp s3://xxxxxxxxxx-xxxxxxxxxx-pkg/web/newrelic_config/newrelic_api.ini var/www/web/newrelic_config/
aws s3 cp s3://xxxxxxxxxx-xxxxxxxxxx-pkg/web/newrelic_config/newrelic_app.ini var/www/web/newrelic_config/
aws s3 cp s3://xxxxxxxxxx-xxxxxxxxxx-pkg/web/newrelic_config/newrelic_quote.ini var/www/web/newrelic_config/
# cp ../s3_local_files/newrelic_* var/www/web/newrelic_config

####################################################
## UPDATE THE ERP AND GEOD CONFIG FILE FROM S3 #####
####################################################
if [ "$ENV" == 'prod' ]; then
    aws s3 cp s3://xxxxxxxxxx-xxxxxxxxxx-pkg/web/production/xxxxxxxxxx_erp_config.py .
    aws s3 cp s3://xxxxxxxxxx-xxxxxxxxxx-pkg/web/production/xxxxxxxxxx_geod_config.py .
    # cp ../s3_local_files/prod.ecs.docker.config.py .
    # cp ../s3_local_files/prod.xom-geod.config.py .
elif [ "$ENV" == 'stage' ]; then
    aws s3 cp s3://xxxxxxxxxx-xxxxxxxxxx-pkg/web/stage.ecs.docker.config.py .
    aws s3 cp s3://xxxxxxxxxx-xxxxxxxxxx-pkg/web/stage.xom-geod.config.py .
elif [ "$ENV" == 'qaa' ]; then
    aws s3 cp s3://xxxxxxxxxx-xxxxxxxxxx-pkg/web/qaA/xxxxxxxxxx_erp_config.py .
    aws s3 cp s3://xxxxxxxxxx-xxxxxxxxxx-pkg/web/qaA/xxxxxxxxxx_geod_config.py .
    # cp ../s3_local_files/qaa.ecs.docke.config.py .
    # cp ../s3_local_files/qaa.xom-geod.config.py .
elif [ "$ENV" == 'qab' ]; then
    aws s3 cp s3://xxxxxxxxxx-xxxxxxxxxx-pkg/web/qaB/xxxxxxxxxx_erp_config.py .
    aws s3 cp s3://xxxxxxxxxx-xxxxxxxxxx-pkg/web/qaB/xxxxxxxxxx_geod_config.py .
fi
# cp ../s3_local_files/__init__.py ${DOCKER_BUILD_WEB_ROOT}
aws s3 cp s3://xxxxxxxxxx-xxxxxxxxxx-pkg/web/__init__.py .


# INSTALL WHEEL PACAKES FOR xxxxxxxxxx_Models
aws s3 cp s3://xxxxxxxxxx-xxxxxxxxxx-pkg/wheel/${MODELS_WHL} .

# SETUP ERP CONFIG
cd ${DOCKER_BUILD_WEB_ROOT}/var/www/web/xxxxxxxxxx_erp/config/
rm -rf  * 
cd ${DOCKER_BUILD_WEB_ROOT}
cp xxxxxxxxxx_erp_config.py ${DOCKER_BUILD_WEB_ROOT}/var/www/web/xxxxxxxxxx_erp/config/config.py
cp __init__.py ${DOCKER_BUILD_WEB_ROOT}/var/www/web/xxxxxxxxxx_erp/config/

# SETUP GEOD CONFIG
cd  ${DOCKER_BUILD_WEB_ROOT}/var/www/web/xxxxxxxxxx_geod/
rm config.py
cd ${DOCKER_BUILD_WEB_ROOT}
cp xxxxxxxxxx_geod_config.py   ${DOCKER_BUILD_WEB_ROOT}/var/www/web/xxxxxxxxxx_geod/config.py


# CREATE SYMBOLIC LINKS
cd  ${DOCKER_BUILD_WEB_ROOT}/var/www/web/

ln -s xxxxxxxxxx_erp nextline_erp
ln -s xxxxxxxxxx_webapp nextline_webapp
ln -s nextline_erp/tools/ansible/server_config/api.wsgi    api.wsgi
ln -s nextline_erp/tools/ansible/server_config/app.wsgi    app.wsgi
ln -s nextline_erp/tools/ansible/server_config/quote.wsgi  quote.wsgi
ln -s xxxxxxxxxx_geod nextline_geod

cd  ${DOCKER_BUILD_WEB_ROOT}/var/www/web/nextline_erp/config/
ln -s config.py env_config.py
cd ${DOCKER_BUILD_WEB_ROOT}

###########################################
## EXECUTE THE DOCKER BUILD WITH TAG ######
###########################################
## Choose one of the other below.
## Options should be obvious.
## Use --no-cache --squash for final builds
# docker build --no-cache --squash -t  ${REGISTRY}/${DOCKER_REPOSITORY}  -f ${DOCKER_FILE} --build-arg BUILD_ENV=${ENV} .
docker build -t ${REGISTRY}/${DOCKER_REPOSITORY} -f ${DOCKER_FILE} --build-arg BUILD_ENV=${ENV} .
#docker build -t ${REGISTRY}/${DOCKER_REPOSITORY}:gwbush -f ${DOCKER_FILE} .

###########################################
## CLEANUP AND REMOVE THE WORKING FILES ###
###########################################

rm -rf apache2-ready/
rm -rf ssl-ready/
rm -rf var/
rm -f Eve_Mongoengine-0.0.10-py2-none-any.whl
rm -f ${DOCKER_BUILD_WEB_ROOT}/.boto
rm -rf httpd*
rm -rf xxxxxxxxxx_erp_config.py
rm -rf eve-mongoengine
rm -rf xxxxxxxxxx_geod_config.py 
rm -rf __init__.py
rm -rf mobile_device_registration.py
rm -rf ecs-cluster-name
rm -rf xxxxxxxxxx_models*
rm -rf xxxxxxxxxx_*
rm -rf newrelic_config/

###END
