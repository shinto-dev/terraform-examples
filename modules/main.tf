provider "aws" {
  region = "eu-central-1"
}

module "ec2" {
  source = "./ec2" # This can be remote module as well.
  ec2name = "Name From Module"
}

output "module_output" {
  value = module.ec2.instance_id
}
