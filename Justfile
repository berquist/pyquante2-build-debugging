venv-nocython:
    -deactivate
    -rm -r venv_311_nocython
    # git clean -Xdf .
    python -m venv ./venv_311_nocython
    source ./venv_311_nocython/bin/activate && \
        bash ./venv.bash >& nocython.log && \
        deactivate

venv-cython:
    -deactivate
    -rm -r venv_311_cython
    # git clean -Xdf .
    python -m venv ./venv_311_cython
    source ./venv_311_cython/bin/activate && \
    python -m pip install 'Cython<3' && \
        bash ./venv.bash >& cython.log && \
        deactivate
# python -m pip install 'Cython<3' && \

venv-not-avail-requested:
    -deactivate
    -rm -r venv_not_avail_requested
    python -m venv ./venv_not_avail_requested
    source ./venv_not_avail_requested/bin/activate && \
        bash ./venv.bash | tee not_avail_requested.log && \
        deactivate

venv-not-avail-not-requested:
    -deactivate
    -rm -r venv_not_avail_not_requested
    python -m venv ./venv_not_avail_not_requested
    source ./venv_not_avail_not_requested/bin/activate && \
        PYQUANTE_CYTHON_DISABLED=true \
        bash ./venv.bash | tee not_avail_not_requested.log && \
        deactivate

venv-avail-requested:
    -deactivate
    -rm -r venv_avail_requested
    python -m venv ./venv_avail_requested
    source ./venv_avail_requested/bin/activate && \
    python -m pip install 'Cython<3' && \
        bash ./venv.bash | tee avail_requested.log && \
        deactivate

venv-avail-not-requested:
    -deactivate
    -rm -r venv_avail_not_requested
    python -m venv ./venv_avail_not_requested
    source ./venv_avail_not_requested/bin/activate && \
    python -m pip install 'Cython<3' && \
        PYQUANTE_CYTHON_DISABLED=true \
        bash ./venv.bash | tee  avail_not_requested.log && \
        deactivate

image-build:
    podman pull docker.io/library/archlinux:latest
    podman build -t pyquante2/base:latest -f Dockerfile.base .
    podman build -t pyquante2/not_avail_requested -f Dockerfile.not_avail_requested .
    podman build -t pyquante2/not_avail_not_requested -f Dockerfile.not_avail_not_requested .
    podman build -t pyquante2/avail_requested -f Dockerfile.avail_requested .
    podman build -t pyquante2/avail_not_requested -f Dockerfile.avail_not_requested .

image-shell:
    podman run --rm -it pyquante2/base:latest /bin/bash
