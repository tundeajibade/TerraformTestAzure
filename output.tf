output "azure_vm_password" {
  value = nonsensitive(resource.random_password.password.result)
}
