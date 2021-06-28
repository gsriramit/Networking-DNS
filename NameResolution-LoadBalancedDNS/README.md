# Step 5: Making the DNS Server Highly Available
#### As in the case with any IAAS solution that is built and managed by the customer, the DNS server(s) in addition to be being patched and protected have to be made highly available. Azure provides a few options to make the services deployed in VMs provide a high SLO. Refer to [Azure VMs SLA](https://www.azure.cn/en-us/support/sla/virtual-machines/) for details of the SLO with each of the options
#### Single region DNS options include the Availability Set (AS) and Availability Zones(AZ). With both the cases we need to have a load balancer (mostly an internal LB) that fronts these DNS servers and receives the queries at its private IP frontend. The queries are then load balanced among the DNS servers that are added to the backed pool.
**Note: The configuration of the forwarders and the conditional forwarders will have to be done in every VM that is a member of the DNS Proxy Cluster.** 
The choice of the ILB differs depending on the placement of the proxy servers. The following table provides a quick summary

| DNS Server Placement | ILB Min Requirement |
| ---------------------|-----------------|
| Availability Set     | Basic (Standard is adviced for prod)|
| Availability Zones   | Standard        |


## Target State
All the scenarios that have been discussed from Steps 1 through 5 with only a architectural change of deploying more than 1 DNS proxy server in the Azure VNETS. The implementation that we have illustrated here (also the templates have been added for) has a Virtual Machine Scale Set starting with 2 VMs (that can be increased through manual scaling) distributed across multiple availability zones, all 3 if we have a minimum of 3 DNS servers. One advantage of using a Vmss as opposed to a VM is that one prebuilt golden image of a Windows/Linux DNS machine can be uploaded to Azure as a **managed disk** or to the **Shared Image Gallery** and the same can be made the base image of the scale-set. So when we scale-out, the same image would be used to created the new instance(s).

## Implementation 
Not intending to reinvent the wheel and also provide the credits to the author for a nice article and github artifacts, please refer to the following article.[DNS Load Balancing in Azure](https://thetechl33t.com/2020/12/21/dns-load-balancing-in-azure/) by @matthansen0 for an implementation using Availability Sets.
Modifying the deployment templates to place the DNS proxy servers in 2 to 3 AZs (Depending on the number of DNS servers that you use in your setup) will get you a **higher SLO of 99.99%**.

## Reference Architecture Diagram
![LoadBalancedDNSServers](https://user-images.githubusercontent.com/13979783/123664011-972b9380-d854-11eb-8d9e-48b0c493c665.png)

## Flow Explained
1. The conditional forwarder IP in the spoke's and On-Prem's DNS servers are modified to point to the ILB private IP (10.0.5.25)
2. The default DNS server of the Hub-VNET is modified to point to 10.0.5.25 (the static private IP of the ILB). This can also be made at the NIC level if that seems more appropriate. This helps the VM within the same subnet resolve Domain Names from the On-Premise and the Spoke-Vnet from a single access point
3. The Scale-Set instances have the same setup to forward the queries for az-spoke-1-internal.net to the ILB's private IP in the Spoke VNET (not implemented in this case)
   - nslookup for vm-dns-dev01.az-spoke-1-internal.net will be forwarded to 10.1.0.25 
4. A name resolution request for vm-dns-dev05.az-hubinternal.net from the On-Premise DNS server would be sent to 10.0.5.25
5. The Load Balancer's routing rule would route the request to one of the machines in the scale-set at port 53 (10.0.5.25:53 to 10.0.5.6/7 :53)
6. The DNS servers forwards the request to the Azure Managed DNS Server (168.63.129.16)
7. Azure DNS forwards the request to the appropriate Private DNS Zone (az-hubinternal.net) in this case
8. The Private DNS Zone having the "A" records for the registered VMs would be able to resolve the Domain Name to an IP









