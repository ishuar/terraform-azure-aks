.Phony: docs validate

docs:
	terraform-docs .

fmt:
	terraform fmt --recursive