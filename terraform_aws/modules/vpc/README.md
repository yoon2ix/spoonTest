## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| avail_zones | 사용할 availability zones 리스트 | list | - |
| name | VPC Name | string | - |
| pri_sub_cidr | Private Subnet CIDR Block 리스트 | list | - |
| pub_sub_cidr | Public Subnet CIDR Block 리스트 | list | - |
| vpc_cidr | VPC에 할당한 CIDR Block | string | - |


## Outputs

| Name | Description |
|------|-------------|
| pubSG-id | Security Group ID of Public Subnet |
| spoonPubA-id | AZ a, Public Subnet ID |
| spoonPubC-id | AZ c, Public Subnet ID |
| spoonVPC | VPC ID |
| spoonWasA-id | AZ a, Private Subnet ID for WAS Server |
| spoonWasC-id | AZ C, Private Subnet ID for WAS Server |
| spoonWebA-id | AZ a, Private Subnet ID for WEB Server |
| spoonWebC-id | AZ C, Private Subnet ID for WEB Server |
| spoonDBA-id | AZ a, Private Subnet ID for DB |
| spoonDBC-id | AZ c, Private Subnet ID for DB |
| wasServerSG-id | Security Group ID of WAS Server |
| webServerSG-id | Security Group ID of WEB Server |
| dbServerSG-id | Security Group ID of DB Server |
