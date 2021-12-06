module "vpc" {
  source = "./vpc"
  name   = var.name
  region = var.region
}

module "eks-cluster" {
   source = "./eks-cluster"
   name   = var.name
   region = var.region
   private_subs = "${module.vpc.private_subnets}"
 }

 module "aws-ecr" {
   source = "./aws-ecr"
   name = var.name
   source_path = "aws-ecr/app/src"
   image_name = "nginx-pccm-app"
 }

 module "eks-app" {
   source = "./eks-app"
   cluster_id = "${module.eks-cluster.cluster_id}"
   region = var.region
  #  tag = "latest"
  #  image_name = "nginx-pccm-app"
 }

 module "eks-cloudfront-waf" {
   source = "./eks-cloudfront-waf"
   lb_dns = "${module.eks-app.lb_dns}"
   name = var.name
 }




 
