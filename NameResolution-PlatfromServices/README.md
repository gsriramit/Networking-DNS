## Target State

| Scenario  | Solution | DNS Suffix |
| ------------- | ------------- |-------------|
| Name resolution from an Azure App Service (Web App, Function, or Bot) using virtual network integration to role instances or VMs in the same virtual network.  | Customer-managed DNS servers forwarding queries between virtual networks for resolution by Azure (DNS proxy). See Name resolution using your own DNS server.  | FQDN only |
| Name resolution from App Service Web Apps to VMs in the same virtual network.  | Customer-managed DNS servers forwarding queries between virtual networks for resolution by Azure (DNS proxy). See Name resolution using your own DNS server. |FQDN only|
| Name resolution from App Service Web Apps in one virtual network to VMs in a different virtual network. | Customer-managed DNS servers forwarding queries between virtual networks for resolution by Azure (DNS proxy). See Name resolution using your own DNS server. | FQDN only |

These are depicted by (3) in the DNS Flow Diagram

## Name Resolution Flows Detailed
1. Resolution of VMs in the Azure VNET(Hub or Spoke) from an Azure Function App
   - nslookup of vm-dns-dev02.az-hubinternal.net (or) vm-dns-dev02.az-spoke-1-internal.net from a function app that is integrated with the Hub-Vnet
   - DNS queries for hubinternal.net are sent to the Azure provided DNS and then sent to the Private DNS Zone for lookup
   - Resolution is completed at this point as the private DNS zone hosts the A records for hubinternal.net
   - DNS queries for spoke-1-internal.net are sent to the DNS proxy server in the spoke network. The DNS proxy server sends the query for Private zone lookup through Azure provided DNS
   - Resolution is completed at this point as the private DNS zone hosts the A records for spoke-1-internal.net

    
