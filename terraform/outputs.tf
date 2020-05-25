output "ssh_key" {
  value = tls_private_key.vault.private_key_pem
  sensitive = true
}
