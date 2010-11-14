#!/bin/bash

#If we have multiple RHS strings, ignore all but the first (e.g. convert "boaut->bout, boat, about" to "boaut->bout").
#Filter out mappings that contain characters outside of the printable ASCII range.
lynx -dump "http://en.wikipedia.org/wiki/Wikipedia:Lists_of_common_misspellings/For_machines" | \
    grep '\->' | \
    sed 's/,.*$//' | \
    grep -P '^[\x20-\x7e]+$' | \
    sort >|data/wikipedia.dat
