function CreateS2SVpnConnection {
    param (
        [Parameter(Mandatory = $true, Position = 1)]
        [string] $resourceGroupName,        
        [Parameter(Mandatory = $true, Position = 2)]
        [string] $deploymentLocation,
        [Parameter(Mandatory = $true, Position = 3)]
        [string] $vpnGatewayName,
        [Parameter(Mandatory = $true, Position = 4)]
        [string] $localGatewayName,
        [Parameter(Mandatory = $true, Position = 5)]
        [string] $vpnConnectionType,
        [Parameter(Mandatory = $true, Position = 6)]
        [string] $sharedKey
    )


    # Get the Az VPN Gateway Object
    $vpnGateway = Get-AzVirtualNetworkGateway -Name $vpnGatewayName -ResourceGroupName $resourceGroupName
    #Get the Az Local Network Gateway Object 
    # This object in azure should virtually represent the On-Prem VPN device that the connection would be created with
    $localNetworkGateway = Get-AzLocalNetworkGateway -Name $localGatewayName -ResourceGroupName $resourceGroupName
    # Convert the shared key to a secret string
    $sharedSecretKey = ConvertTo-SecureString $sharedKey -AsPlainText -Force

    New-AzVirtualNetworkGatewayConnection -Name HubVnettoSite1 `
        -ResourceGroupName $resourceGroupName  -Location $deploymentLocation `
        -VirtualNetworkGateway1 $vpnGateway `
        -LocalNetworkGateway2 $localNetworkGateway `
        -ConnectionType $vpnConnectionType `
        -RoutingWeight 10 -SharedKey $sharedSecretKey
}

CreateS2SVpnConnection -resourceGroupName $args[0] -deploymentLocation $args[1] -vpnGatewayName $args[2] -localGatewayName $args[3] -vpnConnectionType $args[4] -sharedKey $args[5]
