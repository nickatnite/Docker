source ./git-utils.sh
git clone -b rel-v3.2.0 --single-branch https://github.com/xxxxxxxxxx/xxxxxxxxxx_erp.git --depth 1 
git clone -b Rel-3.2.0 --single-branch https://github.com/xxxxxxxxxx/xxxxxxxxxx_api.git --depth 1 
git clone -b master --single-branch https://github.com/xxxxxxxxxx/xxxxxxxxxx_geod.git --depth 1
git clone -b dev --single-branch https://github.com/xxxxxxxxxx/eve-mongoengine.git --depth 1
cat xxxxxxxxxx_erp/requirements.txt > ./erp_reqs.txt
cat xxxxxxxxxx_api/requirements.txt > ./api_reqs.txt
cat xxxxxxxxxx_geod/requirements.txt > ./geod_reqs.txt
docker build -t web-base -f ./Dockerfile-web-base .
rm -rf xxxxxxxxxx_*
rm -f *_reqs.txt
rm -rf var
