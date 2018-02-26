
######################################
# Collect github account credentials #
######################################

echo "Please enter your github credentials. Use an API token for the password"
echo "unless you're a slacker and haven't turned on 2FA yet."
read -p "username: " username
read -sp "api token: " password
echo ""

urlencoded_username=$(printf %s "${username}" | xxd -plain | tr -d '\n' | sed 's/\(..\)/%\1/g')
urlencoded_password=$(printf %s "${password}" | xxd -plain | tr -d '\n' | sed 's/\(..\)/%\1/g')

REPO_URL=https://${urlencoded_username}:${urlencoded_password}@github.com/xxxxxxxxxx

function select_repo {
    REPLY=0
    arr=$(git ls-remote --tags $1 v* | awk '{print $2}' | sed 's/refs\/tags\///' | sort -n -r | head -100)
    options=($arr)
    select TAG in ${options[@]}; do
        if [ "$REPLY" -le "${#options[@]}" ] && [ "$REPLY" -gt "0" ];then
            curl -sLO ${1}/archive/${TAG}.zip;unzip ${TAG}.zip;
            break;
        else
            echo ""
            echo "Please select a valid option";
            echo ""
            continue;
        fi
    done
}

function select_repo_branch {
    REPLY=0
    arr=$(git ls-remote --heads $1 | awk '{print $2}' | sed 's/refs\/heads\///')
    options=($arr)
    select TAG in ${options[@]}; do
        if [ "$REPLY" -le "${#options[@]}" ] && [ "$REPLY" -gt "0" ];then
            curl -sLO ${1}/archive/${TAG}.zip;unzip ${TAG}.zip;
            break;
        else
            echo ""
            echo "Please select a valid option";
            echo ""
            continue;
        fi
    done
}

function clone_repo_by_branch {
    git clone -b $2 --single-branch ${1}.git --depth 1
}