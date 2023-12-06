$input_path="./vid2pose/sample_videos/input_video.mp4"
$output_path="./outputs/"
$pose_model="dwpose"


Set-Location $PSScriptRoot
.\venv\Scripts\activate

$Env:HF_HOME = "./huggingface"
$Env:XFORMERS_FORCE_DISABLE_TRITON = "1"
#$Env:PYTHONPATH = $PSScriptRoot
$ext_args = [System.Collections.ArrayList]::new()

if ($input_path) {
    [void]$ext_args.Add("-i=$input_path")
}

if ($output_path) {
    [void]$ext_args.Add("-o=$output_path")
}

if ($pose_model) {
    [void]$ext_args.Add("--pose_model=$pose_model")
}


python.exe "vid2pose/video2openpose2.py" $ext_args
