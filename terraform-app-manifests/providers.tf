# Set KUBE_CONFIG_PATH environment variable
provider "kubernetes" {
  config_context = "my-context"
}