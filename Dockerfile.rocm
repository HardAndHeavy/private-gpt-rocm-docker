FROM hardandheavy/transformers-rocm:2.0.3

ENV PORT=8080
EXPOSE 8080

RUN mkdir local_data
RUN mkdir models

RUN pip install poetry
# https://python-poetry.org/docs/configuration/#virtualenvsin-project
ENV POETRY_VIRTUALENVS_IN_PROJECT=true

ENV PRIVATE_GPT_VERSION=0.4.0
RUN git clone https://github.com/zylon-ai/private-gpt /app && \
    cd /app && \
    git checkout v${PRIVATE_GPT_VERSION}
WORKDIR /app
RUN poetry install --extras "ui llms-llama-cpp embeddings-huggingface vector-stores-qdrant"

# https://docs.amd.com/projects/radeon/en/latest/docs/install/install-pytorch.html
RUN wget https://repo.radeon.com/rocm/manylinux/rocm-rel-6.0/torch-2.1.1%2Brocm6.0-cp311-cp311-linux_x86_64.whl
RUN poetry run pip install --force-reinstall --no-cache-dir torch-2.1.1+rocm6.0-cp311-cp311-linux_x86_64.whl

ENV LLAMA_CPP_PYTHON_VERSION=0.2.56
ENV DAMDGPU_TARGETS=gfx900;gfx906;gfx908;gfx90a;gfx1030;gfx1100;gfx1101;gfx940;gfx941;gfx942
RUN CMAKE_ARGS="-DLLAMA_HIPBLAS=ON -DCMAKE_C_COMPILER=/opt/rocm/llvm/bin/clang -DCMAKE_CXX_COMPILER=/opt/rocm/llvm/bin/clang++ -DAMDGPU_TARGETS=${DAMDGPU_TARGETS}" poetry run pip install --force-reinstall --no-cache-dir llama-cpp-python==${LLAMA_CPP_PYTHON_VERSION}

CMD poetry run python scripts/setup && \
    make run
