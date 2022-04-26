#!/bin/bash
echo "starting server... stop witch CTRL-C"

/usr/bin/env python3 -m http.server --directory data 9000
