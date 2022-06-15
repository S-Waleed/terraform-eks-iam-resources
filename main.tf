locals {
  cluster_name       = "aws001-sandbox-eks"
  current_ip_address = "${chomp(data.http.myip.body)}/32"
}
