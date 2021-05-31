using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# Test the name resolution of the Conditional DNS Server hosted in the Hub Vnet
$server = "vm-customdns-de.az-hubinternal.net"
$address = [System.Net.Dns]::GetHostAddresses($server)
Write-Host "address is $address"

# Test the name resolution of the Conditional DNS Server hosted in the Spoke Vnet
# Note that the FunctionApp is integrated only with the Hub. Resolution of the Spoke VM works because of the presence of the conditional forwarder in the Hub
$peerednetworkserver = "vm-customdns-de.az-spoke1-internal.net"
$remoteserveraddress = [System.Net.Dns]::GetHostAddresses($peerednetworkserver)
Write-Host "address is $remoteserveraddress"