Set-Location $PSScriptRoot

$Env:PIP_DISABLE_PIP_VERSION_CHECK = 1

if (!(Test-Path -Path "venv")) {
    Write-Output  "创建python虚拟环境venv..."
    python -m venv venv
}
.\venv\Scripts\activate

Write-Output "安装依赖..."
pip install -U -r requirements-windows.txt -i https://mirror.baidu.com/pypi/simple

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

Write-Output "安装完毕"
Read-Host | Out-Null ;
