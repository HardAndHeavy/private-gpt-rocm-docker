build:
	docker build -t private-gpt-rocm:$(type)-$(ver) -f Dockerfile.$(type) .

publish:
	docker image tag private-gpt-rocm:$(type)-$(ver) hardandheavy/private-gpt-rocm:$(type)-$(ver)
	docker push hardandheavy/private-gpt-rocm:$(type)-$(ver)
	docker image tag private-gpt-rocm:$(type)-$(ver) hardandheavy/private-gpt-rocm:$(type)-latest
	docker push hardandheavy/private-gpt-rocm:$(type)-latest

bash-rocm:
	docker run -it --rm \
		-p 80:8080 \
		-v ./local_data/:/app/local_data \
		-v ./models/:/app/models \
		-e PGPT_PROFILES=gpt \
		-v ./settings-gpt.yaml:/app/settings-gpt.yaml \
		--device=/dev/kfd \
		--device=/dev/dri \
		private-gpt-rocm:rocm-$(ver) bash

bash-cpu:
	docker run -it --rm \
		-p 80:8080 \
		-v ./local_data/:/app/local_data \
		-v ./models/:/app/models \
		-e PGPT_PROFILES=gpt \
		-v ./settings-gpt.yaml:/app/settings-gpt.yaml \
		private-gpt-rocm:cpu-$(ver) bash

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

run-rocm:
	docker run -it --rm \
		-p 80:8080 \
		-v ./local_data/:/app/local_data \
		-v ./models/:/app/models \
		-e PGPT_PROFILES=gpt \
		-v ./settings-gpt.yaml:/app/settings-gpt.yaml \
		--device=/dev/kfd \
		--device=/dev/dri \
		hardandheavy/private-gpt-rocm:rocm-latest

run-cpu:
	docker run -it --rm \
		-p 80:8080 \
		-v ./local_data/:/app/local_data \
		-v ./models/:/app/models \
		-e PGPT_PROFILES=gpt \
		-v ./settings-gpt.yaml:/app/settings-gpt.yaml \
		hardandheavy/private-gpt-rocm:cpu-latest
