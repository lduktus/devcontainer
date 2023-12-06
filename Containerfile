FROM cgr.dev/chainguard/wolfi-base AS base
RUN set -euo pipefail; \
    apk update --no-cache && \
    apk add --no-cache \
        bash \
        curl \
        fd \
        git \
        libstdc++ \
        make \
        ripgrep && \
    rm -rf /var/cache/apk/*

FROM base AS micromamba
ENV MAMBA_ROOT_PREFIX="/opt/conda"
ENV MAMBA_EXE="/bin/micromamba"
COPY ./micromamba/mambarc /etc/conda/condarc.d/mambarc
WORKDIR /
RUN set -euo pipefail; curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba; \
    mkdir -pv "$MAMBA_ROOT_PREFIX/conda-meta" \
    && chmod -R a+rwx "$MAMBA_ROOT_PREFIX"
CMD ["/bin/micromamba"]