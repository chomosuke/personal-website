#!/bin/bash
find content/assets/ -name *.svg | xargs -I _ usvg _ _
find content/assets/ -name *.svg | xargs -I _ vector_graphics_compiler -i _
