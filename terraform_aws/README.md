The provider has module information. It is defined in "provider.tf"

It has 2 Modules. vpc and ec2 module.
The ec2 module consists of 
 - main.tf
 - variable.tf
 - output.tf

 Resources are defined in the "main.tf" file. 
  - EC2
  - AMI
  - Key Pair
  - Load Balancer
  - Auto Scaling

 ec2 module's input data are defined in the "variable.tf" file.
 ec2 module's output data ate defined in the "output.tf" file.


The vpc module consists of
 - main.tf
 - variable.tf
 - output.tf

 Resources are defined in the "main.tf" file.
  - VPC
  - Subnet
  - Routing Table
  - Internet Gateway
  - EIP
  - Security Group
 
 vpc module's input data are defined in the "variable.tf" file.
 vpc module's output data ate defined in the "output.tf" file.
