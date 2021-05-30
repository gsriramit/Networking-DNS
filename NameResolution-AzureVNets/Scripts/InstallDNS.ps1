#Update the Powershell version in the DNS Server if using older OS versions (e.g. Windows Server 2012) - Optional Step
if($PSVersionTable.PSVersion.Major -eq '5.0'){
    # script to download and install latest version of PS
}

function SetDNS {
    param (
        [Parameter(Mandatory = $true, Position =1)]
        [string] $domainName,        
        [Parameter(Mandatory = $true, Position =2)]
        [string] $forwarderDNSServerIP
    )

    #Variables
 $AzureDNSServerIP = 168.63.129.16

# Install the DNS Server Role in the Windows Machine
Install-WindowsFeature -Name DNS -IncludeManagementTools

#Add the DNS Forwarder to forward queries from the same VNET to the Azure Managed DNS Server
Add-DnsServerForwarder -IPAddress $AzureDNSServerIP -PassThru

#Add the Conditional DNS Forwarder to the Custom DNS Server in the Spoke VM
Add-DnsServerConditionalForwarderZone -Name $domainName `
-MasterServers $forwarderDNSServerIP -PassThru 
    
}

#Invoke the function 
SetDNS -domainName $args[0] -forwarderDNSServerIP $args[1]
