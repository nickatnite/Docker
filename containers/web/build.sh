#!/bin/bash

set -eu -o pipefail

ENV=''

function cluster_select {
    echo "Do you wish to build a container for qa, stage or production ECS CLuster?:";
    select TAG in "qa" "stage" "production" ; do
        case $TAG in
            qa ) `echo "qa" > ecs-cluster-name` ;break;;
            stage )  `echo "stage" > ecs-cluster-name`;break;;
    	production ) `echo "production" > ecs-cluster-name`;break;; 
            * ) echo "Please enter Cluster Name";
        esac
    done
}
select ENV in "Prod" "Stage" "QA A" "QA B" "Local"; do
    case $ENV in
        "Prod")
            ENV='prod'
            break;;
        "Stage")
            ENV='stage'
            break;;
        "QA A")
            ENV='qaa'
            break;;
        "QA B")
            ENV='qab'
            break;;
        "Local")
            ENV='local'
            break;;
        *) echo "Enter an environment";
    esac
done

echo "Starting step 1 of web container build."
./step1_get_code.sh $ENV

echo "Starting step 2 of web container build."
./step2_build_base.sh $ENV

echo "#########################"
echo "###  Have a nice day! ###"
echo "#########################"

