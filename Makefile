all:
	docker pull fedora:26
	docker build -t lazyfrosch/mock --rm .
