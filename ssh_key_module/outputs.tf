output "public_ssh_key" {
  # Only output a generated ssh public key
  value = var.public_ssh_key != "" ? "" : tls_private_key.ssh.public_key_openssh
}
output "public_ssh_key_pem" {
  # Only output a generated ssh public key in PEM format
  value = var.public_ssh_key != "" ? "" : tls_private_key.ssh.public_key_pem
}
