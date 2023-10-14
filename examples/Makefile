## Determine the Makefile's directory
## * dir function -> https://www.gnu.org/software/make/manual/html_node/File-Name-Functions.html#index-dir
## * abspath -> https://www.gnu.org/software/make/manual/html_node/File-Name-Functions.html#index-abspath-1
## * lastword -> http://gnu.ist.utl.pt/software/make/manual/html_node/Text-Functions.html#Text-Functions
## * MAKEFILE_LIST -> https://ftp.gnu.org/old-gnu/Manuals/make-3.80/html_node/make_17.html
MKFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.Phony: init
init:
	terraform init

.Phony: initlock
initlock: init
	terraform providers lock -platform=darwin_arm64 -platform=darwin_amd64 -platform=linux_amd64 -platform=linux_arm64

.Phony: fmt
fmt:
	terraform fmt -recursive

.Phony: format
format: fmt

.Phony: lock
lock: initlock

.Phony: clean
clean:
	find . -type d -name ".terraform" -prune -exec rm -rf {} \;

.Phony: clean-all
clean-all: clean
	find . -name ".terraform.lock.hcl" -prune -exec rm -rf {} \;
	az logout
	az account clear
