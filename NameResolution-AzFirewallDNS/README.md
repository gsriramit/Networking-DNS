# Step 6: DNS resolution between Azure VNETS using Azure Firewall DNS Proxy 
### Important Note: Only the scenario of name resolution within the Hub VNet(where the Azure Firewall is hosted) and between peered virtual networks(from spoke to hub) is considered to keep the architecture simple. Firewall DNS Proxy can be configured to forward inbound DNS queries to a set of Custom DNS Servers.

## Target State

| Scenario  | Solution | DNS Suffix |
| ------------- | ------------- |-------------|
| Resolution of VMs and Cloud Services within the Vnet hosting the Firewall | Azure Firewall DNS Proxy  | FQDN
| Resolution of VMs and Cloud Services in the Vnet hosting the Firewall from a Peered Vnet | Azure Firewall DNS Proxy  | FQDN

## Reference Architecture Diagram
![AzureVPNConcepts - firewalldns](https://user-images.githubusercontent.com/13979783/124374250-649bf380-dcb7-11eb-96bc-cd0b3f4189b2.png)

## Name Resolution Flows Detailed
1. Resolution of VMs in the Hub from within the same VNet
   - nslookup vm-dns-dev02.az-hubinternal.net from vm-client2.az-hubinternal.net or a connected PAAS Service
   - DNS of the hub Vnet is configured with a custom DNS server pointing to the private ip of the Azure Firewall (10.0.6.4)
   - DNS queries for the private Dns Zone az-hubinternal.net are first sent to the Azure Firewall
   - The query is then forwarded to the Azure Provided DNS (az-hubinternal.net) to complete the private DNS zone lookup
2. Resolution of VMs in the Hub from the spoke VNET 
    - nslookup of vm-client2.az-hubinternal.internal from vm-dns-dev02.az-spoke1-internal.net
    - DNS of the spoke Vnet is configured with a custom DNS server (10.1.0.4)
    - DNS proxy server in the spoke VNET is configured with a conditional forwarder for az-hubinternal.net with the private ip of the Azure Firewall (10.0.6.4)
    - DNS queries for the private Dns Zone az-hubinternal.net are first sent to the Azure Firewall
    - The query is then forwarded to the Azure Provided DNS (az-hubinternal.net) to complete the private DNS zone lookup

## Question: What benefit does this setup bring? 
1. The firewall can act as the DNS proxy server in the Hub Network for Name resolutions requests that need to be sent to Azure Managed DNS (168.63.129.16) and any private DNS Zone (through the Azure Managed DNS)
2. Firewall being a managed service, is by default **scaled out to be highly available**
3. Extension of the base scenario can be to forward requests to Custom DNS Servers from within the firewall  proxy. This can be used when resolution from (168.63.129.16) and private DNS zones would not cut it


    
