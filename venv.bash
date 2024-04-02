#!/bin/bash

set -euo pipefail
set -x

python -m pip install -U pip setuptools pytest
# build-system.requires normally handles this, but setup.py build_ext -i
# standalone needs it.
# python -m pip install numpy
echo "pip freeze"
python -m pip freeze

# Running tests requires being in the install directory, but also requires the
# compiled extensions.  We get those by building them in-place.
# python setup.py build_ext -i
# find . -type f -name "*.so" -exec rm '{}' +

python -m pip install -v -e .
python -m pytest -v . || true
python -m pip uninstall -y pyquante2

# We also need to check that installation works and import of the compiled
# extensions works.
python -m pip install -v .
pushd "${HOME}"
python -c 'import pyquante2 as _; print(_.__path__[0])'
python -c 'from pyquante2.ints import integrals; from pyquante2.grid import grid'
popd
