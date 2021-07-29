build:
	docker build -t hellowarp -f ./Dockerfile .
run:
	docker run -it --init -p 8080:8080 hellowarp
