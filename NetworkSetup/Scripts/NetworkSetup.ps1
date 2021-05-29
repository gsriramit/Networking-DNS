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
#    create the networks, 
#   create VNET peering
#   create the private DNS zones for each and setup for auto-registration 
$resourceGroupName = 'Az360-SharedSvcs-rg'
$hubNetworkTemplate = 'Hub&SpokeNetworks-Template.json'
$hubNetworkParamters = 'Hub&SpokeNetworks-Parameters.json'


New-AzResourceGroupDeployment -Name HubNSpokeNetworkDeployment -ResourceGroupName $resourceGroupName `
-WhatIf `
  -TemplateFile $hubNetworkTemplate `
  -TemplateParameterFile $hubNetworkParamters







