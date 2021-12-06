# README #

This README would normally document whatever steps are necessary to get your application up and running.

### Task ###


1.Create the One EKS cluster 

2.Each cluster having one node group with compute environment

3.Each node group minmum 1 node maximun 1 nodes ( auto scaling group) 

4.VPC,Subnet, secuirty group for EKS( in terraform)

5.Create ECR image (any container image) 

6.Create the pods with  ECR container image ( port 8080)

7.create ingress NLB/ALB  controller 






### Actual work flow ###



internet user ---> CDN---> WAF --> ALB ---> Web proxy Ngnix ---> NLB/ALB ---> ngress controler NLB/ALB ---> EKS cluster container