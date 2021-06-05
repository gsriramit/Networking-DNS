# Azure Networking - DNS Scenarios
This repository hosts the templates and scripts that deploy Azure Cloud Services for a variety of Azure DNS scenarios. The deployments would be done in multiple steps to be able to create and simulate multiple independent scenarios while keeping the base infrastructure components reusable. The following table lists the scenarios that we will be targeting

## References
1. [Name Resolutions for VMs & Cloud Services](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)
2. [Private DNS Scenarios](https://docs.microsoft.com/en-us/azure/dns/private-dns-scenarios)
3. [Azure PrivateEndPoint DNS Configuration Scenarios](https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-dns#dns-configuration-scenarios)


## Name Resoltion Scenarios - Hybrid Network & Private DNS Zones

| Scenario  | Solution | DNS Suffix |
| ------------- | ------------- |-------------|
| Name resolution between VMs located in the same virtual network, or Azure Cloud Services role instances in the same cloud service.  | Azure DNS private zones or Azure-provided name resolution  | Hostname or FQDN
| Name resolution between VMs in different virtual networks or role instances in different cloud services.  | Azure DNS private zones or, Customer-managed DNS servers forwarding queries between virtual networks for resolution by Azure (DNS proxy). See Name resolution using your own DNS server.  |FQDN only|
| Name resolution from an Azure App Service (Web App, Function, or Bot) using virtual network integration to role instances or VMs in the same virtual network.|Customer-managed DNS servers forwarding queries between virtual networks for resolution by Azure (DNS proxy). See Name resolution using your own DNS server.|FQDN only|
|Name resolution from App Service Web Apps to VMs in the same virtual network.|Customer-managed DNS servers forwarding queries between virtual networks for resolution by Azure (DNS proxy). See Name resolution using your own DNS server.|FQDN only|
|Name resolution from App Service Web Apps in one virtual network to VMs in a different virtual network.|Customer-managed DNS servers forwarding queries between virtual networks for resolution by Azure (DNS proxy). See Name resolution using your own DNS server.|FQDN only|
|Resolution of on-premises computer and service names from VMs or role instances in Azure.|Customer-managed DNS servers (on-premises domain controller, local read-only domain controller, or a DNS secondary synced using zone transfers, for example). See Name resolution using your own DNS server.|FQDN only|
|Resolution of Azure hostnames from on-premises computers.|Forward queries to a customer-managed DNS proxy server in the corresponding virtual network, the proxy server forwards queries to Azure for resolution. See Name resolution using your own DNS server.	|FQDN only|


## Network Architecture Diagram
![AzureVPNConcepts - DNS Scenarios-NetworkArchitecture](https://user-images.githubusercontent.com/13979783/120890838-d6ced900-c622-11eb-9db7-a4954c95c569.png)

## Name Resolution- Flow Diagram
![AzureVPNConcepts - DNS Scenarios-NameResolveFlows](https://user-images.githubusercontent.com/13979783/120890848-e6e6b880-c622-11eb-8c39-936e5796ffce.png)






