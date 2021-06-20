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
All the scenarios that have been discussed from Steps 1 through 5 with only a architectural change of deploying more than 1 DNS proxy server in the Azure VNETS

## Implementation 
Not intending to reinvent the wheel and also provide the credits to the author for such an amazing article and github artifacts, please refer to the following article.[DNS Load Balancing in Azure](https://thetechl33t.com/2020/12/21/dns-load-balancing-in-azure/) by @matthansen0

## Reference Architecture Diagram


