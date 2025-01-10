variable "cidr" {
    description = "This is the deafault cidr range for "
    default = ["10.0.0.0/16"]
}
variable "Subent_cidr"{
    default =  ["10.0.0.0/24"]
}
variable "region" {
    default = "eastus"
}
variable "resource_group_name" {
    default = "m"
  
}