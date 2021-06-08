## Target State

| Scenario  | Solution | DNS Suffix |
| ------------- | ------------- |-------------|
| Name resolution between VMs located in the same virtual network, or Azure Cloud Services role instances in the same cloud service.  | Azure DNS private zones or Azure-provided name resolution  | Hostname or FQDN
| Name resolution between VMs in different virtual networks or role instances in different cloud services.  | Azure DNS private zones or, Customer-managed DNS servers forwarding queries between virtual networks for resolution by Azure (DNS proxy). See Name resolution using your own DNS server.  |FQDN only|

These are depicted by (1) and (2) in the DNS Flow Diagram

## Name Resolution Flows Detailed
1. Resolution between VMs in the same VNet
   - nslookup vm-dns-dev02.az-hubinternal.net from vm-dns-dev01.az-hubinternal.net
   - DNS Server of the VNET is configured to be 10.0.5.4 (Custom DNS Server)
   - Custom DNS Server has a forwarder configured to send same private zone requests(and anything by default) to 168.63.129.16 (Note: this DNS server does not host any forward lookup zones)
   - Azure provided DNS maps the domain name in the request (az-hubinternal.net) to the private DNS Zone az-hubinternal.net
   - Request is then sent to the private DNS zone. Resolution of the FQDN happens here because of the availability of the A record in the DNS Zone
    - A vm-dns-dev02 10.0.5.5
2. Similar to the flow explained in #1 except that the lookup is for and from within the Spoke Network
3. Resolution between VMs in different Vnets
   - nslookup vm-dns-dev02.az-spoke1-internal.net from vm-dns-dev01.az-hubinternal.net
   - DNS Server of the VNET is configured to be 10.0.5.4 (Custom DNS Server)
   - Custom DNS Server has a conditional forwarder configured to forward NS requests of az-spoke1-internal.net to 10.1.0.4 (Custom DNS server of Spoke 1 Vnet)
   - Custom DNS Server 10.1.0.4 in the spoke has a forwarder configured to send same private zone requests(and anything by default) to 168.63.129.16 (Note: this DNS server does not host any forward lookup zones)
   - Azure provided DNS maps the domain name in the request (az-spoke1-internal.net) to the private DNS Zone az-spoke1-internal.net
   - Request is then sent to the private DNS zone. Resolution of the FQDN happens here because of the availability of the A record in the DNS Zone
    - A vm-dns-dev02 10.1.0.5
  4. Similar to flow explained in #3 except that the lookup is for a VM in the hub initiated from a VM in the spoke
     - Note: The Custom DNS server 10.1.0.4 in the spoke should be configured to conditionaly forward requests to the Hub's Custom DNS server
     - **Add-DnsServerConditionalForwarderZone -Name 'az-hubinternal.net' -MasterServers 10.0.5.4 -PassThru**
