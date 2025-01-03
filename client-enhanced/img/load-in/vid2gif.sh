target="load-in.mp4"
output="output.gif"
optimized="optimized.gif"
speed="0.15" # represented as a percentage of original video length, lower is faster i.e. 0.1=10% & 1=100%
fps="15" # frames per second to sample from the original video
resolution="720" # frame height in pixels
optimization_factor="20" # optimization factor for gifsicle, lower is better quality but bigger file size

# convert the video to a gif
ffmpeg -i "$target" -loop 0 -filter_complex "[0:v]fps=$fps, scale=-1:$resolution""[s]; [s]split[a][b]; [a]palettegen[palette]; [b][palette]paletteuse, setpts=$speed*PTS[v]" -map '[v]' "$output"

# optimize the gif using gifsicle
gifsicle -O3 --lossy="$optimization_factor" "$output" -o "$optimized"
