Set-Location $PSScriptRoot

$Env:PIP_DISABLE_PIP_VERSION_CHECK = 1

if (!(Test-Path -Path "venv")) {
    Write-Output  "创建python虚拟环境venv..."
    python -m venv venv
}
.\venv\Scripts\activate

Write-Output "安装依赖..."
#pip install -U -r requirements-windows.txt -i https://mirror.baidu.com/pypi/simple

Write-Output "检查模型..."

if (!(Test-Path -Path "pretrained_models")) {
    Write-Output  "创建模型文件夹..."
    mkdir "pretrained_models"
}

Set-Location .\pretrained_models

if (!(Test-Path -Path "MagicAnimate")) {
    Write-Output  "下载MagicAnimate模型..."
    git clone https://huggingface.co/zcxu-eric/MagicAnimate
}
if (Test-Path -Path "MagicAnimate/.git/lfs") {
    Remove-Item -Path MagicAnimate/.git/lfs/* -Recurse -Force
}

$install_SD15 = Read-Host "是否需要下载huggingface的SD15模型? 若您本地没有任何SD15模型选择y，如果想要换其他SD1.5模型选择 n。[y/n] (默认为 y)"
if ($install_SD15 -eq "y" -or $install_SD15 -eq "Y" -or $install_SD15 -eq "") {
    if (!(Test-Path -Path "stable-diffusion-v1-5")) {
        Write-Output  "下载 stable-diffusion-v1-5 模型..."
        git clone https://huggingface.co/bdsqlsz/stable-diffusion-v1-5
        
    }
    if (Test-Path -Path "stable-diffusion-v1-5/.git/lfs") {
        Remove-Item -Path stable-diffusion-v1-5/.git/lfs/* -Recurse -Force
    }
}

$install_CNOP = Read-Host "是否需要下载huggingface的control_v11p_sd15_openpose模型? 若您希望使用openpose选择y，如果不需要选择 n。[y/n] (默认为 y)"
if ($install_CNOP -eq "y" -or $install_CNOP -eq "Y" -or $install_CNOP -eq ""){
    if (!(Test-Path -Path "control_v11p_sd15_openpose")) {
    Write-Output  "下载 control_v11p_sd15_openpose 模型..."
    git clone https://huggingface.co/bdsqlsz/control_v11p_sd15_openpose
    }
    if (Test-Path -Path "control_v11p_sd15_openpose/.git/lfs") {
        Remove-Item -Path control_v11p_sd15_openpose/.git/lfs/* -Recurse -Force
    }
}

Write-Output "安装Video_controlnet_aux..."

git submodule update --recursive --init

Set-Location $PSScriptRoot/video_controlnet_aux
pip install -r requirements.txt -i https://mirror.baidu.com/pypi/simple
pip install -r requirements-video.txt -i https://mirror.baidu.com/pypi/simple

Write-Output "安装完毕"
Read-Host | Out-Null ;
