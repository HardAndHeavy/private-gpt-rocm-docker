# PrivateGPT для GPU от Radeon в Docker

<h4 align="center">
    <p>
        <b>Русский</b> |
        <a href="https://github.com/HardAndHeavy/private-gpt-rocm-docker/blob/main/README_en.md">English</a>
    </p>
</h4>

[PrivateGPT](https://github.com/zylon-ai/private-gpt) в Docker [контейнере с поддержкой GPU Radeon](https://hub.docker.com/repository/docker/hardandheavy/private-gpt-rocm/general). Проверено на AMD RadeonRX 7900 XTX.

### Необходимое окружение
- Ubuntu
- make
- Docker
- git
- ROCm ([установка](https://github.com/HardAndHeavy/transformers-rocm-docker?tab=readme-ov-file#install-rocm))

### Запуск
- `git clone https://github.com/HardAndHeavy/private-gpt-rocm-docker`
- `cd private-gpt-rocm-docker`
- `make gen`
- `make run`

При первом запуске будет происходить длительный процесс скачивания модели. Когда этот процесс завершится, PrivateGPT станет доступен по адресу http://localhost.

### Примеры настроек
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
