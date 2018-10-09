#!/bin/bash

# download cuda and cuDNN file from baidu yun
sudo apt-get install aria2
aria2c -c -s10 -k1M -x16 --enable-rpc=false -o "cudnn-9.0-linux-x64-v7.tgz" --header "User-Agent: netdisk;5.3.4.5;PC;PC-Windows;5.1.2600;WindowsBaiduYunGuanJia" --header "Referer: https://pan.baidu.com/disk/home" --header "Cookie: BDUSS=G9lSUR4Q1l0UGpOMWM5UGNrVWUxakw3RHlzZ0RhaEVDdVZlRWo0TXhsMDJLdVJiQVFBQUFBJCQAAAAAAAAAAAEAAACTvaQlxuIzNwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADadvFs2nbxbS; pcsett=1539174104-7b85e491753ed0277f205bfd0a6cda84" "https://d.pcs.baidu.com/file/6189e05077dbce0bd07059b20306a836?fid=3173113211-250528-232665924311611&dstime=1539087730&rt=sh&sign=FDtAERV-DCb740ccc5511e5e8fedcff06b081203-mZfPM5tV1Hzz3chc7LzqnXCZDik%3D&expires=8h&chkv=1&chkbd=0&chkpc=&dp-logid=6536867844767327573&dp-callid=0&shareid=1137671773&r=148903240"
aria2c -c -s10 -k1M -x16 --enable-rpc=false -o "cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64.deb" --header "User-Agent: netdisk;5.3.4.5;PC;PC-Windows;5.1.2600;WindowsBaiduYunGuanJia" --header "Referer: https://pan.baidu.com/disk/home" --header "Cookie: BDUSS=G9lSUR4Q1l0UGpOMWM5UGNrVWUxakw3RHlzZ0RhaEVDdVZlRWo0TXhsMDJLdVJiQVFBQUFBJCQAAAAAAAAAAAEAAACTvaQlxuIzNwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADadvFs2nbxbS; pcsett=1539174104-7b85e491753ed0277f205bfd0a6cda84" "https://d.pcs.baidu.com/file/e78e6ff56582f09a0cbc607049bdb2fd?fid=3173113211-250528-985189579948407&dstime=1539087730&rt=sh&sign=FDtAERV-DCb740ccc5511e5e8fedcff06b081203-uLoM3%2BX%2BfFUP2%2BeT3z8DFpLtriA%3D&expires=8h&chkv=1&chkbd=0&chkpc=&dp-logid=6536867844767327573&dp-callid=0&shareid=1137671773&r=484828159"

# install cuda 9.0
CUDA_REPO_PKG="cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64.deb"
sudo dpkg -i ${CUDA_REPO_PKG}
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
sudo apt-get update
sudo apt-get install cuda-9-0 

# install cuDNN v7.0.4
CUDNN_TAR_FILE="cudnn-9.0-linux-x64-v7.tgz"
tar -xzvf ${CUDNN_TAR_FILE}
CUDA_FOLDER="cuda-9.0"
sudo cp -P cuda/include/cudnn.h /usr/local/${CUDA_FOLDER}/include
sudo cp -P cuda/lib64/libcudnn* /usr/local/${CUDA_FOLDER}/lib64/
sudo chmod a+r /usr/local/${CUDA_FOLDER}/lib64/libcudnn*

# set environment variables
export PATH=/usr/local/${CUDA_FOLDER}/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/${CUDA_FOLDER}/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export CUDA_VISIBLE_DEVICES=0
sudo ldconfig


# install tensorflow 1.6.0
sudo apt-get -y update
sudo apt-get install python-dev python-pip
sudo apt-get install libcupti-dev
TF_WHL_FILE="tensorflow_gpu-1.6.0-cp27-cp27mu-manylinux1_x86_64.whl"
wget https://pypi.python.org/packages/0f/a2/38929ec9677cb0009837b77674388ab4a35ad81573f3289b21963eda0f9a/${TF_WHL_FILE}#md5=6aeae66cb813e26086dd460eede672bd
sudo pip install ${TF_WHL_FILE}
python -c 'import tensorflow as tf; print(tf.__version__)' 
