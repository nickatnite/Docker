#!/bin/bash

set -eu -o pipefail

##########################################################
#     Nick Ascione 08/15/2017		                     #
#     Grab Web Source and build document root for apache #
#     Currently only accepts dev or master. 		     #
#     Need to add support for feature branches		     #
##########################################################
### CLEAN UP SO SCRIPT IS IDEMPOTENT####

source ./git-utils.sh
WEB_ROOT=var/www/web/
DOCKERFILE_ROOT=$(pwd)

rm -rf ${WEB_ROOT}
mkdir -p ${WEB_ROOT}
cd ${WEB_ROOT}

function y_n_prompt {
    ANS=false
    function auto {
        read -p "$PROMPT_MSG" response
        case $response in
            'y')
                ANS=true;;
            'n')
                ANS=false;;
            *)
                echo 'Please enter y or n';;
        esac
    }
    auto
    while [ $response != 'n' ] && [ $response != 'y' ]; do
        auto
    done
}

PROMPT_MSG="Would you like to auto select branches(y/n): "
y_n_prompt
auto_select=$ANS

if $auto_select; then
    PROMPT_MSG="Would you like to read branch names from repo_branches.sh(y/n): "
    y_n_prompt
    read_from_file=$ANS
    if $read_from_file; then
        source ${DOCKERFILE_ROOT}/repo_branches.sh
        echo "Cloning dev of eve-mongoengine..."
        clone_repo_by_branch "${REPO_URL}/eve-mongoengine" dev
        echo "Cloning ${API_BRANCH} of xxxxxxxxxx_API..."
        clone_repo_by_branch "${REPO_URL}/xxxxxxxxxx_api" $API_BRANCH
        echo "Cloning ${ERP_BRANCH} of xxxxxxxxxx_ERP..."
        clone_repo_by_branch "${REPO_URL}/xxxxxxxxxx_erp" $ERP_BRANCH
        echo "Cloning ${ERP_FRONT_BRANCH} of xxxxxxxxxx_ERP_Frontend..."
        clone_repo_by_branch "${REPO_URL}/xxxxxxxxxx_erp_frontend" $ERP_FRONT_BRANCH
        echo "Cloning ${GEOD_BRANCH} of xxxxxxxxxx_Geod..."
        clone_repo_by_branch "${REPO_URL}/xxxxxxxxxx_geod" $GEOD_BRANCH
        echo "Cloning ${WEBAPP_BRANCH} of xxxxxxxxxx_WebApp..."
        clone_repo_by_branch "${REPO_URL}/xxxxxxxxxx_webapp" $WEBAPP_BRANCH
        echo "Cloning ${PRICING_BRANCH} of xxxxxxxxxx_Pricing..."
        clone_repo_by_branch "${REPO_URL}/xxxxxxxxxx_pricing" $PRICING_BRANCH
    else
        read -p 'What branch would you like to auto select: ' branch_name
        echo "Cloning ${branch_name} of all repositories..."
        clone_repo_by_branch "${REPO_URL}/eve-mongoengine" dev
        clone_repo_by_branch "${REPO_URL}/xxxxxxxxxx_api" $branch_name
        clone_repo_by_branch "${REPO_URL}/xxxxxxxxxx_erp" $branch_name
        clone_repo_by_branch "${REPO_URL}/xxxxxxxxxx_erp_frontend" $branch_name
        clone_repo_by_branch "${REPO_URL}/xxxxxxxxxx_geod" $branch_name
        clone_repo_by_branch "${REPO_URL}/xxxxxxxxxx_webapp" $branch_name
        clone_repo_by_branch "${REPO_URL}/xxxxxxxxxx_pricing" $branch_name
    fi
else
    echo ""
    echo ""
    echo "Pulling dev branch of eve-mongoengine"
    clone_repo_by_branch "${REPO_URL}/eve-mongoengine" dev
    echo ""
    echo ""
    echo "Enter Tag for xxxxxxxxxxPricing:"
    select_repo_branch "${REPO_URL}/xxxxxxxxxx_pricing"
    echo ""
    echo ""
    echo "Enter Tag for xxxxxxxxxxApi"
    select_repo_branch "${REPO_URL}/xxxxxxxxxx_api"
    echo ""
    echo ""
    echo "Enter Tag for xxxxxxxxxxErp:"
    select_repo_branch "${REPO_URL}/xxxxxxxxxx_erp"
    echo ""
    echo ""
    echo "Enter Tag for xxxxxxxxxxErpFrontEnd:"
    select_repo_branch "${REPO_URL}/xxxxxxxxxx_erp_frontend"
    echo ""
    echo ""
    echo "Enter Tag for xxxxxxxxxxGeod:"
    select_repo_branch "${REPO_URL}/xxxxxxxxxx_geod"
    echo ""
    echo ""
    echo "Enter Tag for xxxxxxxxxxWebapp:"
    select_repo_branch "${REPO_URL}/xxxxxxxxxx_webapp"
    echo ""
    echo ""
fi
####### GET RID OF TAG NAME IN DIRECTORY STRUCTURE ###
echo "Renaming folders to remove branch name from directory";

mv eve-mongoengine-* eve-mongoengine || echo "Did not move" 
mv xxxxxxxxxx_api-* xxxxxxxxxx_api || echo "Did not move"
mv xxxxxxxxxx_erp_frontend-* xxxxxxxxxx_erp_frontend || echo "Did not move"
mv xxxxxxxxxx_erp-* xxxxxxxxxx_erp || echo "Did not move"
mv xxxxxxxxxx_geod-* xxxxxxxxxx_geod || echo "Did not move"
mv xxxxxxxxxx_webapp-* xxxxxxxxxx_webapp || echo "Did not move"
mv xxxxxxxxxx_pricing-* xxxxxxxxxx_pricing || echo "Did not move"

######## REMOVE ZIP FILES AND GIT FILES ###############

echo "Removing any left over zip files";
rm -f *.zip

echo "Source code is downloaded and santized (well kind of) and located in `pwd` ";
echo "Good bye!"
exit;
