#!/bin/bash -e

echo "Using pip. Installing tensorflow on unbuntu." 

PACKAGE="tensorflow"

if [[ ("$GPU_ENABLED" == "true") ]]; then
    PACKAGE="${PACKAGE}-gpu"
fi

PACKAGE="${PACKAGE}==$TF_VERSION"

pip install $PACKAGE

echo "End of $0"
