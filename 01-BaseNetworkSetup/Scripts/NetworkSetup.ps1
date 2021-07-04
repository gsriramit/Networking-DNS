
#Optional Step - Install the Az Module if migrating from AzureRM to Az
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force -AllowClobber 
#Connect to the Azure Account
Connect-AzAccount
#Set the Subscription Context
#Declare the variables
$tenantId = ''
$subscriptionId= ''
#Set the exact tenant and subscription context if you have access to multiple tenants and subscriptions
Set-AzContext -Tenant $tenantId -Subscription $subscriptionId

#Deploy the Hub & Spoke VNets
#Note: The template will
#    create the networks, subnets and the NSGs required for the Custom DNS Servers
#   create VNET peering
#   create the private DNS zones for each and setup for auto-registration 
$resourceGroupName = ''
$hubNetworkTemplate = 'Hub&SpokeNetworks-Template.json'
$hubNetworkParamters = 'Hub&SpokeNetworks-Parameters.json'

# Remove the WhatIf switch after verifying the correctness of the template
New-AzResourceGroupDeployment -Name HubNSpokeNetworkDeployment  `
-WhatIf `
-ResourceGroupName $resourceGroupName `
  -TemplateFile $hubNetworkTemplate `
  -TemplateParameterFile $hubNetworkParamters







