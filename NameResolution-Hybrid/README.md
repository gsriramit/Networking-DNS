# Step 4: DNS resolution between Azure VNETS and a connected On-Premise Network
### Note: The connection can be an IKE VPN or an express route. The DNS queries are directed to a DNS proxy server to its private IP address. This setup helps in preparing DNS solutions for production-kind network requirements

## Target State

| Scenario  | Solution | DNS Suffix |
| ------------- | ------------- |-------------|
| Resolution of on-premises computer and service names from VMs or role instances in Azure.  | Customer-managed DNS servers (on-premises domain controller, local read-only domain controller, or a DNS secondary synced using zone transfers, for example). See Name resolution using your own DNS server.  | FQDN only |
| Resolution of Azure hostnames from on-premises computers.  | Forward queries to a customer-managed DNS proxy server in the corresponding virtual network, the proxy server forwards queries to Azure for resolution. See Name resolution using your own DNS server. |FQDN only|

These are depicted by (4) in the DNS Flow Diagram

## Name Resolution Flows Detailed
1. Resolution of VMs in the Azure VNET(Hub or Spoke) from a VM On-Premise
   - nslookup vm-dns-dev02.az-hubinternal.net (or) vm-dns-dev02.az-spoke-1-internal.net from vm-client2.azexp.internal (192.168.29.5)
   - DNS of the On-Prem environment is configured with a conditional forwarder for az-hubinternal.net and az-spoke-1-internal.net
   - DNS queries for both the Azure Private DNS zones are forwarded to the DNS proxy server in the hub (10.0.5.4)
   - Query for the VM in the hub is then forwarded to the Azure Provided DNS (az-hubintern.net) to complete the private DNS zone lookup
   - Query for the VM in the spoke is then forwarded by the hub proxy DNS server to the spoke proxy DNS server (10.1.0.4)
   - The spoke DNS server forwards the query to the Azure provided DNS which then forwards the same for private DNS zone lookup (az-spoke-1-internal.net)
2. Resolution of VMs On-Premise from the Azure VNET 
    - nslookup vm-client2-azexp.internal from vm-dns-dev02.az-hubinternal.net
    - DNS proxy server in the HUB VNET is configured with a conditional forwarded for azexp.internal
    - DNS quries for the On-Premise domain zones are forwarded to the DNS server On-Premise (192.168.29.4)
    - On-Premise DNS server has A records in its forward lookup zone
    - **A vm-client2.azexp.internal 192.168.29.5**
    
