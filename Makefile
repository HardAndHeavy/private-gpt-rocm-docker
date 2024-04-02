build:
	docker build -t private-gpt-rocm:$(tag) -f Dockerfile .

publish:
	docker image tag private-gpt-rocm:$(tag) hardandheavy/private-gpt-rocm:$(tag)
	docker push hardandheavy/private-gpt-rocm:$(tag)
	docker image tag private-gpt-rocm:$(tag) hardandheavy/private-gpt-rocm:latest
	docker push hardandheavy/private-gpt-rocm:latest

bash:
	docker run -it --rm \
		-p 80:8080 \
		-v ./local_data/:/app/local_data \
		-v ./models/:/app/models \
		-e PGPT_PROFILES=gpt \
		-v ./settings-gpt.yaml:/app/settings-gpt.yaml \
		--device=/dev/kfd \
		--device=/dev/dri \
		private-gpt-rocm:$(tag) bash

clean:
	sudo rm -rf models/embedding
	sudo rm -rf local_data/*

gen:
	docker run --rm -it \
		-v $(CURDIR):/ansible \
		-v ./secure:/ansible/secure \
		willhallonline/ansible:latest ansible-playbook ansible/gen.yml \
		-i ansible/gen \
		-vv

run:
	docker run -it --rm \
		-p 80:8080 \
		-v ./local_data/:/app/local_data \
		-v ./models/:/app/models \
		-e PGPT_PROFILES=gpt \
		-v ./settings-gpt.yaml:/app/settings-gpt.yaml \
		--device=/dev/kfd \
		--device=/dev/dri \
		hardandheavy/private-gpt-rocm:latest

build-cpu:
	docker build -t private-gpt-rocm:cpu-$(tag) -f Dockerfile.cpu .

publish-cpu:
	docker image tag private-gpt-rocm:cpu-$(tag) hardandheavy/private-gpt-rocm:cpu-$(tag)
	docker push hardandheavy/private-gpt-rocm:cpu-$(tag)

bash-cpu:
	docker run -it --rm \
		-p 80:8080 \
		-v ./local_data/:/app/local_data \
		-v ./models/:/app/models \
		-e PGPT_PROFILES=gpt \
		-v ./settings-gpt.yaml:/app/settings-gpt.yaml \
		private-gpt-rocm:cpu-$(tag) bash
