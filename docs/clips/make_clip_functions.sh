extract_frames() {
  local input="$1"
  local outdir="$2"
  local height="$3"
  local speed="$4"
  local fps="$5"

  mkdir -p "$outdir" || return 1

  ffmpeg -v error -y -i "$input" \
    -vf "setpts=PTS/${speed},fps=${fps},scale=-2:${height}:flags=lanczos" \
    "$outdir/frame_%04d.png"
}

round_corners() {
  emulate -L zsh
  setopt localtraps

  local indir="$1"
  local outdir="$2"
  local radius="${3:-28}"
  local extension="${4:-png}"
  local quality_string="-quality $5"

  if [[ -z "$5" ]]; then
    quality_string=""
  fi

  trap 'echo "\nCanceled."; return 130' INT

  mkdir -p "$outdir" || return 1

  local files=("$indir"/*)
  local total=${#files[@]}
  local i=0
  local f

  for f in "${files[@]}"; do
    [[ -f "$f" ]] || continue
    i=$((i + 1))
    printf '%s/%s %s\n' "$i" "$total" "$(basename "$f")"

    base="${$(basename "$f"):r}"

    magick "$f" \
      \( +clone -alpha transparent -fill white \
         -draw "roundrectangle 0,0,%[fx:w-1],%[fx:h-1],${radius},${radius}" \) \
      -compose CopyOpacity -composite \
      ${=quality_string} \
      "$outdir/${base}.${extension}" || return $?

      ## Can be used to color the corners black for webp compilation, but makes corner edge look whiteish, put under -compose line
      # \( +clone -alpha extract \) \
      # -channel RGB -compose Multiply -composite +channel \
  done
}

compile_avif() {
  local indir="$1"
  local output="$2"
  local fps="$3"
  local quality="$4"
  local speed="$5"

  local frames=("$indir"/*)
  [[ ${#frames[@]} -gt 0 ]] || {
    echo "No input frames found in $indir" >&2
    return 1
  }

  avifenc \
    --fps "$fps" \
    --repetition-count infinite \
    -q "$quality" \
    --qalpha 100 \
    -s "$speed" \
    "${frames[@]}" \
    "$output"
}

compile_webp() {
    local indir="$1"
    local output="$2"
    local fps="$3"
    local quality="$4"

    local frames=("$indir"/*)
    [[ ${#frames[@]} -gt 0 ]] || {
        echo "No input frames found in $indir" >&2
        return 1
    }
    ffmpeg -framerate "$fps" -pattern_type glob -i "$indir/*.png" -c:v libwebp_anim -pix_fmt yuv420p -loop 0 -q:v "$quality" "$output"
}
