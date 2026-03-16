1. launch Client-Enhanced
2. Enter Borderless Fullscreen
3. Press F1 to toggle HUD
4. Take macOS screen recording on 4k display
5. Trim recording to correct time with LosslessCut (stills=5-10 seconds)
6. Export to `trimmed.mov` (if more than one clip, use `trimmed-n.mov`)
7. Open `trimmed.mov` in Handbrake to reencode and reduce size
   - 1080p30fps Fast preset
   - Set to constant frame-rate: 24fps
   - Set to target bitrate: 5000kbps
8. Export to `transcode.mov`
9. Run `extract_frames` from `make_clip_functions.sh` to extract frames from
   `transcode.mov`
   - `extract_frames <video> <frames> <height> <speed> <fps>`
   - e.g.: `extract_frames transcode.mov frames 720 1 12`
   - `height` is the height to scale the frames to in pixels
   - `speed` is the factor to speed up the video by, before extracting frames
     (can reduce file sizes by generating less frames)
   - `fps` is the frames per second to extract the frames at (lower value
     results in lower file sizes, but choppier video)
   - Generally exporting stills with:
     - `speed=1`
     - `fps=12`
     - `height=720`
   - Exporting longer clips with:
     - `speed=1.5`
     - `fps=12`
     - `height=480` or `height=360`
10. Run `round_corners` from `make_clip_functions.sh` to round the corners of
    the frames
    - `round_corners <frames> <output> [extension] [quality]`
    - e.g.: `frames/ rounded/ 15`
    - `corners` is the radius of the corners in pixels
    - `extension` is the extension of the frames
    - `quality` is the quality of the frames
    - Generally using:
      - `corners=15` @ 720p, `corners=30` @ 1080p
11. Run `compile_avif` from `make_clip_functions.sh` to compile the frames into
    an AVIF video
    - Target 2-5mb file size
    - `compile_avif <frames> <output> <fps> <quality> <speed>`
      - e.g.: `compile_avif frames/ output.avif 12 75 4`
    - `fps` is the frames per second to use in the video (same as what you used
      to extract the frames)
    - `quality` reflects the amount of compression to apply to the video (1-100,
      lower provides more compression). Use the lowest value possible without
      compromising the quality of the video too much
    - `speed` is the speed of the encoding (0-4, lower is slower, but results in
      slightly better compression)
    - Generally using:
      - `fps=12`
      - `quality=75`
      - `speed=1`
12. Run `compile_webp` from `make_clip_functions.sh` to compile the frames into
    a WebP video
    - Target exactly 4.9mb file size
    - `compile_webp <frames> <output> <fps> <quality>`
      - e.g.: `compile_webp frames/ output.webp 12 85`
    - `fps` is the frames per second to use in the video (same as what you used
      to extract the frames)
    - `quality` reflects the amount of compression to apply to the video (1-100,
      lower provides more compression). Use the highest value possible without
      going over the target file size.
    - Generally using:
      - `fps=12`
      - `quality=85`
13. Run `extract_frames` from `make_clip_functions.sh` to get a screenshot of a
    frame of the video
    - run as `extract_frames transcode.mp4 stills/ 2304 2 5`
    - Grab a frame from the `stills/` directory and save to
      `docs/screenshots/source/<clip-name>.png`
14. Run `round_corners` from `make_clip_functions.sh` to round the corners of
    the screenshots
    - run as `round_corners screenshots/source/ screenshots/ 50 webp 90`
