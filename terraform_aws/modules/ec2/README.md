## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| pubSG_id | Public Security Group ID | string | - |
| vpc_id | VPC ID | string | - |
| spoonPubA_id | AZ a, Public Subnet ID | string | - |
| spoonPubC_id | AZ c, Public Subnet ID | string | - |
| spoonWasA_id | AZ a, WAS Server Subnet ID | string | - |
| spoonWasC_id | AZ c, WAS Server Subnet ID | string | - |
| spoonWebA_id | AZ a, WEB Server Subnet ID | string | - |
| spoonWebC_id | AZ c, WEB Server Subnet ID | string | - |
| spoonDBA_id | AZ a, DB Server Subnet ID | string | - |
| spoonDBC_id | AZ c, DB Server Subnet iD | string | - |
| wasServerSG_id | Security Group for WAS Server | string | - |
| webServerSG_id | Security Group for WEB Server | string | - |
| dbServerSG_id | Security Group for DB Server | string | - |
| avail_zones | Availability Zones | list | - |

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
