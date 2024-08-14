resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "kubernetes_namespace" "tester" {
  metadata {
    name = "tester"
  }
}

resource "kubernetes_manifest" "cronjob" {
  manifest = yamldecode(file("${path.module}/cronjob.yaml"))
}
