resource "null_resource" "configure-kubectl-local" {

  provisioner "local-exec" {
    command = "az account set --subscription ${var.app-subscription-id}"

  }

  provisioner "local-exec" {
    command = "az aks get-credentials --resource-group ${var.app-cluster-resource-group} --name ${var.app-cluster-name} --overwrite-existing"
  }

  provisioner "local-exec" {
    command = "kubelogin convert-kubeconfig -l azurecli"
  }

  provisioner "local-exec" {
    command = "kubectl apply -f innovation-search-chaiapi-namespace.yaml"
  }


  provisioner "local-exec" {
    command = "kubelogin convert-kubeconfig -l azurecli"

  }

  provisioner "local-exec" {
    command = "kubectl apply -f innovation-search-chaiapi-argo-application-secret.yaml"
  }
  provisioner "local-exec" {
    command = "kubectl apply -f innovation-search-chaiapi-argo-application.yaml"
  }
}
