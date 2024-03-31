#!/bin/bash

set -euo pipefail
set -x

python -m pip install -U pip setuptools pytest
echo "pip freeze"
python -m pip freeze

# Running tests requires being in the install directory, but also requires the
# compiled extensions.  We get those by building them in-place.
# python setup.py build_ext -i
python -m pip install -vvv -e .
python -m pytest -v .
# python -m pip uninstall .

# We also need to check that installation works and import of the compiled
# extensions works.
python -m pip install -vvv .
pushd "${HOME}"
python -c 'import pyquante2 as _; print(_.__path__[0])'
python -c 'from pyquante2.ints import integrals; from pyquante2.grid import grid'
popd
