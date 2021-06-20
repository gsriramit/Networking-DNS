# Step1: Base Network Setup
Completing this step helps in setting up the base network setup. The network components are explained below

## Network Components

| Virtual Network  | Subnet | IP Prefix |
| ------------- | ------------- |-------------|
| hub-vnet(10.0.0.0/16)      | GatewaySubnet | 10.0.2.0/27 |
|               | BastionSubnet | 10.0.3.0/25 |
|               | MgmtSubnet    | 10.0.5.0/24 |
|               | ServiceIntegrationSubnet  | 10.0.4.0/24 |
| spoke-vnet (10.1.0.0/16)    | WorkloadSubnet  | 10.1.0.0/24 |
|               | BastionSubnet   | 10.1.3.0/25 |



| Virtual Network  | Private DNS Zones | VM Auto-Registration |
| ------------- | ------------- | ------------- |
| hub-vnet      | az-hubinternal.net | true |
| spoke-vnet    | az-spoke1-internal.net  | true  |

## Target State
- Hub and Spoke Networks
- Peering between the Azure VNets
- Links to the appropriate Private DNS Zone links from the networks
- Bastion Hosts in each of the networks
- Public IP Addresses to be used with the Bastion Hosts
