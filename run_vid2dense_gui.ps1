$mutil_gpu=0

Set-Location $PSScriptRoot
.\venv\Scripts\activate

$Env:HF_HOME = "./huggingface"
$Env:XFORMERS_FORCE_DISABLE_TRITON = "1"
$Env:PYTHONPATH = $PSScriptRoot

$laungh_script = "gradio_animate"

if ($mutil_gpu) {
    $laungh_script += "_dist"
}

python.exe "demo/$laungh_script.py"