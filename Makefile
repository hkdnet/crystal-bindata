build:
	crystal build --release -o crystal-bindata src/main.cr
release:
	make build
	cp -f crystal-bindata /usr/local/bin/crystal-bindata
.PHONY: build
