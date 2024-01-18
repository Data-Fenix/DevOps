# Run this script to install the dependencies for the Company project
# make sure to run this script from a directory (e.g. home) and make sure that there is no $env_name directory (here set to "Company") in the current directory
set -e  # Exit immediately if any command exits with a non-zero status
set -o pipefail  # Return a failure status if any command in the pipeline fails
cd ~

# remove any existing Devel directory
rm -rf Devel

# make a new Devel directory
mkdir Devel

# change to Devel directory
cd Devel

# deactivate any existing conda environments
conda deactivate

#remove index| tarballs | unused packages and caches
conda clean -p -y -t -y -i -y

env_name="exa_pedata"

# remove any existing $env_name directory
conda remove --name $env_name --all -y

# create and activate  a new conda environment
conda create -n $env_name python=3.11 -y
conda activate "$env_name"

# install the dependencies
pip install --upgrade pip

# pedata
git clone -b dev git@github.com:Company/protein_engineering_data.git && cd protein_engineering_data && pip install --no-cache-dir -e ".[ci, doc]"

#run tests
test/run
if [ $? -eq 0 ]; then
    echo "Tests passed"
else
    echo "Tests failed"
    exit 1
fi
cd .. 

