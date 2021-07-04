# Azure Networking - DNS Scenarios
This repository hosts the templates and scripts that deploy Azure Cloud Services for a variety of Azure DNS scenarios. The deployments would be done in multiple steps to be able to create and simulate multiple independent scenarios while keeping the base infrastructure components reusable. The following table lists the scenarios that we will be targeting


## Name Resolution Scenarios - Hybrid Network & Private DNS Zones

| Scenario  | Solution | DNS Suffix |
| ------------- | ------------- |-------------|
| Name resolution between VMs located in the same virtual network, or Azure Cloud Services role instances in the same cloud service.  | Azure DNS private zones or Azure-provided name resolution  | Hostname or FQDN
| Name resolution between VMs in different virtual networks or role instances in different cloud services.  | Azure DNS private zones or, Customer-managed DNS servers forwarding queries between virtual networks for resolution by Azure (DNS proxy). See Name resolution using your own DNS server.  |FQDN only|
| Name resolution from an Azure App Service (Web App, Function, or Bot) using virtual network integration to role instances or VMs in the same virtual network.|Customer-managed DNS servers forwarding queries between virtual networks for resolution by Azure (DNS proxy). See Name resolution using your own DNS server.|FQDN only|
|Name resolution from App Service Web Apps to VMs in the same virtual network.|Customer-managed DNS servers forwarding queries between virtual networks for resolution by Azure (DNS proxy). See Name resolution using your own DNS server.|FQDN only|
|Name resolution from App Service Web Apps in one virtual network to VMs in a different virtual network.|Customer-managed DNS servers forwarding queries between virtual networks for resolution by Azure (DNS proxy). See Name resolution using your own DNS server.|FQDN only|
|Resolution of on-premises computer and service names from VMs or role instances in Azure.|Customer-managed DNS servers (on-premises domain controller, local read-only domain controller, or a DNS secondary synced using zone transfers, for example). See Name resolution using your own DNS server.|FQDN only|
|Resolution of Azure hostnames from on-premises computers.|Forward queries to a customer-managed DNS proxy server in the corresponding virtual network, the proxy server forwards queries to Azure for resolution. See Name resolution using your own DNS server.	|FQDN only|

### Name Resolution Scenarios - Architecture Choices
| Scenario  | Solution | DNS Suffix |
| ------------- | ------------- |-------------|
| All Scenarios involving Custom DNS Servers | Multiple DNS Servers load balanced by Std ILB  | FQDN
| All Scenarios with Azure Provided DNS | Azure Firewall DNS Proxy  | FQDN
| All Scenarios with Azure Provided DNS & Custom DNS Servers | Azure Firewall DNS Proxy with Custom DNS Servers | FQDN



## Network Architecture Diagram
![AzureVPNConcepts - DNS Scenarios-NetworkArchitecture](https://user-images.githubusercontent.com/13979783/120890838-d6ced900-c622-11eb-9db7-a4954c95c569.png)

## Name Resolution- Flow Diagram
![AzureVPNConcepts - DNS Scenarios-NameResolveFlows](https://user-images.githubusercontent.com/13979783/120890848-e6e6b880-c622-11eb-8c39-936e5796ffce.png)

### Flows Explained
- 1.1 to 1.3 - Name resolution of private DNS Zone names of VMs within a private network 
  - Uses the Custom DNS Server of the Virtual Network
  - e.g name resolution of vm-dns-dev01.az-hubinternal.net from vm-dns-dev02.az-hubinternal.net
- 2.1 to 2.4 - Name resolution of private DNS Zone names of VMs in a peered Virtual Network
  - Uses the Custom DNS Server of source VNET and the peered VNET
  - e.g. name resolution of vm-dns-dev01.az-spoke1-internal.net from vm-dns-dns-dev02.az-hubinternal.net
- 3.1 to 3.3 - Name resolution of a FQDN of a VM hosted in a VNET that an App-Service or a Function-App is integrated with (regional integration)
  - Uses the Custom DNS Server of the VNET that the function app is integrated with
  - e.g name resolution of vm-dns-dev02.az-hubinternal.net from a powershell script running in the Function App
  - Note: The name resolution of vm-dns-dev02.az-spoke1-internal.net should also work from the app
- 4.1 to 4.4 - Name resolution of a FQDN of VMs hosted in the Hub Vnet and the directly peered Spoke VNet 
  - Uses the Custom DNS Server in the Hub VNet
  - e.g name resolution of vm-dns-dev02.az-hubinternal.net from an On-prem VM with the FQDN of vm-dc-primary.azhybrid.internal & the other way around
  - Note: This should work both the ways if the resolution of Network Resources in the On-Prem network from Azure is also needed. This can be made possible by configuring the On-Prem Domain based conditional forwarding in the Hub Vnet's Custom DNS Server


## References
1. [Name Resolutions for VMs & Cloud Services](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)
2. [Private DNS Scenarios](https://docs.microsoft.com/en-us/azure/dns/private-dns-scenarios)
3. [App Service Regional & Global VNET Integration](https://docs.microsoft.com/en-us/azure/app-service/web-sites-integrate-with-vnet#how-regional-vnet-integration-works)
4. [Azure PrivateEndPoint DNS Configuration Scenarios](https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-dns#dns-configuration-scenarios)
5. [Azure Firewall DNS Proxy](https://azure.microsoft.com/en-us/blog/new-enhanced-dns-features-in-azure-firewall-now-generally-available/)


## Known Issues
1. The Custom Script Extention in the VM deployment to configure a forwarder with 168.63.129.16 for the private DNS Zone fails. This has to be done manually after the VM deployment is completed.

## Important Note
The ARM Templates and Scripts should not be used in production directly. Modify and improve as seen necessary!



