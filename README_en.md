# PrivateGPT on GPU from Radeon in docker

<h4 align="center">
    <p>
        <a href="https://github.com/HardAndHeavy/private-gpt-rocm-docker">Русский</a> |
        <b>English</b>
    </p>
</h4>

[PrivateGPT](https://github.com/zylon-ai/private-gpt) project in a [Docker container with GPU Radeon support](https://hub.docker.com/repository/docker/hardandheavy/private-gpt-rocm/general). Tested on AMD Radeon 7900 GTX.

### Requirements
- Ubuntu
- make
- Docker
- git
- ROCm (see the installation in [transformers-rocm-docker](https://github.com/HardAndHeavy/transformers-rocm-docker?tab=readme-ov-file#install-rocm))

### Launch
- `git clone https://github.com/HardAndHeavy/private-gpt-rocm-docker`
- `cd private-gpt-rocm-docker`
- `make gen`
- `make run`

At the first launch, there will be a long process of downloading the model. When this process is completed, PrivateGTP will be available at http://localhost
After downloading, privat-gt will be available at http://localhost

### Examples of settings
#### llm
`bge-small`:
```
huggingface:
  embedding_hf_model_name: BAAI/bge-small-en-v1.5
```
`multilingual-e5`:
```
huggingface:
  embedding_hf_model_name: intfloat/multilingual-e5-large
```
#### llamacpp
`mistral-ru`:
```
tokenizer: mistralai/Mistral-7B-Instruct-v0.2
llm_hf_repo_id: IlyaGusev/saiga_mistral_7b_gguf
llm_hf_model_file: model-q8_0.gguf
```
`llama2-ru`:
```
tokenizer: TheBloke/Llama-2-13B-fp16
llm_hf_repo_id: IlyaGusev/saiga2_13b_gguf
llm_hf_model_file: model-q8_0.gguf
```
`gemma-ru`:
```
tokenizer: IlyaGusev/saiga_gemma_9b
llm_hf_repo_id: NightFox/saiga_gemma_9b_GGUF
llm_hf_model_file: saiga_gemma_9b-Q8_0.gguf
```
`codellama2-ru`:
```
tokenizer: OpenBuddy/openbuddy-codellama2-34b-v11.1-bf16
llm_hf_repo_id: LeeEric/openbuddy-codellama2-34b-v11.1-GGUF
llm_hf_model_file: openbuddy-codellama2-34b-v11.1-Q4_K_M.gguf
```
