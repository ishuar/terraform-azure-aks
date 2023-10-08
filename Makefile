.Phony: docs validate

docs:
	terraform-docs --config .config/.terraform-docs.yml .

fmt:
	terraform fmt --recursive