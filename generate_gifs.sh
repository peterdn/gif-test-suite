#!/bin/bash

[ -z "${CONVERT_COMMAND}" ] && CONVERT_COMMAND="convert"
[ -z "${MOGRIFY_COMMAND}" ] && MOGRIFY_COMMAND="mogrify"

GIF_OUTPUT_DIR="./gifs"
FRAME_OUTPUT_DIR="${GIF_OUTPUT_DIR}/frames"

mkdir -p "${GIF_OUTPUT_DIR}"
mkdir -p "${FRAME_OUTPUT_DIR}"

# Static gif with no animation, no transparency
${CONVERT_COMMAND} -dispose none \
  -size 100x100 xc:DarkSeaGreen \
  -fill PaleGreen -draw "circle 50,50 15,25" \
  -loop 1 \
  "${GIF_OUTPUT_DIR}/static_nontransparent.gif"

# Regular gif with 4 frames, no loop, no transparency
${CONVERT_COMMAND} -dispose none -delay 100 \
  -size 100x100 xc:DarkSeaGreen \
  -fill PaleGreen -draw "circle 50,50 15,25" \
  -dispose none -delay 100 \
  -page +10+10 -size 30x30 xc:LightSalmon \
  -page +30+30 -size 40x40 xc:SkyBlue \
  -page +60+60 -size 30x30 xc:Khaki \
  -loop 1 \
  "${GIF_OUTPUT_DIR}/animated_noloop.gif"

# Animated gif with 4 frames, looping forever, no transparency
${CONVERT_COMMAND} -dispose none -delay 100 \
  -size 100x100 xc:DarkSeaGreen \
  -fill PaleGreen -draw "circle 50,50 15,25" \
  -dispose none -delay 100 \
  -page +10+10 -size 30x30 xc:LightSalmon \
  -page +30+30 -size 40x40 xc:SkyBlue \
  -page +60+60 -size 30x30 xc:Khaki \
  -loop 0 \
  "${GIF_OUTPUT_DIR}/animated_loop.gif"

# As above, but interlaced
INTERLACED_GIF_PATH="${GIF_OUTPUT_DIR}/animated_loop_interlaced.gif"
cp "${GIF_OUTPUT_DIR}/animated_loop.gif" "${INTERLACED_GIF_PATH}"
${MOGRIFY_COMMAND} -interlace gif "${INTERLACED_GIF_PATH}"
if ! identify -verbose "${INTERLACED_GIF_PATH}" | grep "Interlace: GIF" >/dev/null ; then
  echo "mogrify does not support creating interlaced GIFs"
  echo "exiting..."
  exit 1
fi

# Animated gif with 4 frames, looping forever, no transparency, variable delay
${CONVERT_COMMAND} -dispose none -delay 100 \
  -size 100x100 xc:DarkSeaGreen \
  -fill PaleGreen -draw "circle 50,50 15,25" \
  -dispose none -delay 100 \
  -page +10+10 -size 30x30 xc:LightSalmon \
  -delay 10 \
  -page +30+30 -size 40x40 xc:SkyBlue \
  -delay 100 \
  -page +60+60 -size 30x30 xc:Khaki \
  -loop 0 \
  "${GIF_OUTPUT_DIR}/animated_loop_variable_delay.gif"

# Static transparent gif with no animation
${CONVERT_COMMAND} -dispose none \
  -size 100x100 xc:transparent \
  -fill DarkSeaGreen -draw "circle 50,50 15,25" \
  -loop 1 \
  "${GIF_OUTPUT_DIR}/static_transparent.gif"

# Transparent gif with 4 frames, loops forever
${CONVERT_COMMAND} -dispose none -delay 100 \
  -size 100x100 xc:transparent \
  -fill DarkSeaGreen -draw "circle 50,50 15,25" \
  -dispose background -delay 100 \
  -page +10+10 -size 30x30 xc:LightSalmon \
  -page +30+30 -size 40x40 xc:SkyBlue \
  -page +60+60 -size 30x30 xc:Khaki \
  -loop 0 \
  "${GIF_OUTPUT_DIR}/animated_transparent_loop.gif"

# Transparent gif with 4 frames, loops forever, restore previous
${CONVERT_COMMAND} -dispose none -delay 100 \
  -size 100x100 xc:transparent \
  -fill DarkSeaGreen -draw "circle 50,50 15,25" \
  -dispose previous -delay 100 \
  -page +10+10 -size 30x30 xc:LightSalmon \
  -page +30+30 -size 40x40 xc:SkyBlue \
  -page +60+60 -size 30x30 xc:Khaki \
  -loop 0 \
  "${GIF_OUTPUT_DIR}/animated_transparent_restoreprev_loop.gif"

# Transparent gif with 4 frames, loops forever, first frame restore previous
${CONVERT_COMMAND} -dispose previous -delay 100 \
  -size 100x100 xc:transparent \
  -fill DarkSeaGreen -draw "circle 50,50 15,25" \
  -page +10+10 -size 30x30 xc:LightSalmon \
  -page +30+30 -size 40x40 xc:SkyBlue \
  -page +60+60 -size 30x30 xc:Khaki \
  -loop 0 \
  "${GIF_OUTPUT_DIR}/animated_transparent_firstframerestoreprev_loop.gif"

# Transparent gif with 4 transparent frames, loops forever, no dispose
${CONVERT_COMMAND} -dispose none -delay 100 \
  -size 100x100 xc:transparent \
  -fill DarkSeaGreen -draw "circle 50,50 15,25" \
  -page +10+10 \( -size 30x30 xc:transparent -fill LightSalmon -draw "circle 15,15 5,5" \) \
  -page +20+20 \( -size 40x40 xc:transparent -fill SkyBlue -draw "circle 20,20 10,5" \)  \
  -page +30+30 \( -size 30x30 xc:transparent -fill Khaki -draw "circle 15,15 5,5" \)  \
  -loop 0 \
  "${GIF_OUTPUT_DIR}/animated_transparent_frame_norestore_loop.gif"

# Transparent gif with 4 transparent frames, loops forever, restore background
${CONVERT_COMMAND} -dispose none -delay 100 \
  -size 100x100 xc:transparent \
  -fill DarkSeaGreen -draw "circle 50,50 15,25" \
  -dispose background \
  -page +10+10 \( -size 30x30 xc:transparent -fill LightSalmon -draw "circle 15,15 5,5" \) \
  -page +20+20 \( -size 40x40 xc:transparent -fill SkyBlue -draw "circle 20,20 10,5" \)  \
  -page +30+30 \( -size 30x30 xc:transparent -fill Khaki -draw "circle 15,15 5,5" \)  \
  -loop 0 \
  "${GIF_OUTPUT_DIR}/animated_transparent_frame_restorebackground_loop.gif"

# Transparent gif with 4 transparent frames, loops forever, restore previous
${CONVERT_COMMAND} -dispose none -delay 100 \
  -size 100x100 xc:transparent \
  -fill DarkSeaGreen -draw "circle 50,50 15,25" \
  -dispose previous -delay 100 \
  -page +10+10 \( -size 30x30 xc:transparent -fill LightSalmon -draw "circle 15,15 5,5" \) \
  -page +30+30 \( -size 40x40 xc:transparent -fill SkyBlue -draw "circle 20,20 10,5" \)  \
  -page +60+60 \( -size 30x30 xc:transparent -fill Khaki -draw "circle 15,15 5,5" \)  \
  -loop 0 \
  "${GIF_OUTPUT_DIR}/animated_transparent_frame_restoreprev_loop.gif"

# Transparent gif with 4 frames, several out of bounds, loops forever
${CONVERT_COMMAND} -dispose none -delay 100 \
  -size 100x100 xc:transparent \
  -page +200+0 -fill DarkSeaGreen -draw "circle 50,50 15,25" \
  -dispose background -delay 100 \
  -page +10+10 -size 30x30 xc:LightSalmon \
  -page +30+30 -size 40x40 xc:SkyBlue \
  -page +60+60 -size 50x50 xc:Khaki \
  -loop 0 \
  "${GIF_OUTPUT_DIR}/animated_transparent_loop_frames_out_of_bounds.gif"

# Output individual coalesced frames
for f in "${GIF_OUTPUT_DIR}"/*.gif; do
  ${CONVERT_COMMAND} +adjoin -coalesce "${f}" "${FRAME_OUTPUT_DIR}/$(basename "${f}" .gif).png"
done
