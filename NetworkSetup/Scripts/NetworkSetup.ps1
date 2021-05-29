Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force -AllowClobber 
#Connect to the Azure Account
Connect-AzAccount
#Set the Subscription Context
#Declare the variables
$tenantId = ''
$subscriptionId= ''
#Set the exact tenant and subscription context if you have access to multiple tenants and subscriptions
Set-AzContext -Tenant $tenantId -Subscription $subscriptionId

#Deploy the Hub Vnet
$resourceGroupName = 'Az360-SharedSvcs-rg'
$hubNetworkTemplate = '.\Hub-template.json'
$hubNetworkParamters = '.\Hub-parameters.json'

New-AzResourceGroupDeployment -Name HubNetworkDeployment -ResourceGroupName $resourceGroupName `
-WhatIf `
  -TemplateFile $hubNetworkTemplate `
  -TemplateParameterFile $hubNetworkParamters





