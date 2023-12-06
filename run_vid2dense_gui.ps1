$input_video_path="./vid2pose/sample_videos/input_video.mp4"
$output_video_path="./vid2pose/sample_videos/output_video1.mp4"

Set-Location $PSScriptRoot
.\venv\Scripts\activate

$Env:HF_HOME = "./huggingface"
$Env:XFORMERS_FORCE_DISABLE_TRITON = "1"
#$Env:PYTHONPATH = $PSScriptRoot
$ext_args = [System.Collections.ArrayList]::new()

if ($input_video_path) {
    [void]$ext_args.Add("-i=$input_video_path")
}

if ($output_video_path) {
    [void]$ext_args.Add("-o=$output_video_path")
}


python.exe "vid2pose/main.py" $ext_args
