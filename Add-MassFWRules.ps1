# Define the rules as an array of hashtables with obfuscated values
$rules = @(
    @{
        Source = "SRC1"
        SourceSubnet = "SUBNET1"
        Destination = "DST1"
        DestinationSubnet = "SUBNET2"
        Protocol = "TCP"
        Ports = 3389,443
        Description = "DESC1"
    },
    @{
        Source = "SRC1"
        SourceSubnet = "SUBNET1"
        Destination = "DST2"
        DestinationSubnet = "SUBNET3"
        Protocol = "TCP"
        Ports = "3389"
        Description = "DESC2"
    },
    @{
        Source = "SRC2"
        SourceSubnet = "SUBNET2"
        Destination = "DST2"
        DestinationSubnet = "SUBNET2"
        Protocol = "TCP"
        Ports = 443,135,5985,5986
        Description = "DESC3"
    },
    @{
        Source = "SRC2"
        SourceSubnet = "SUBNET2"
        Destination = "DST2"
        DestinationSubnet = "SUBNET3"
        Protocol = "TCP"
        Ports = 3389,135,"49152-65535"
        Description = "DESC4"
    },
    @{
        Source = "SRC2"
        SourceSubnet = "SUBNET2"
        Destination = "DST3"
        DestinationSubnet = "SUBNET4"
        Protocol = "TCP"
        Ports = "1433"
        Description = "DESC5"
    },
    @{
        Source = "SRC2"
        SourceSubnet = "SUBNET2"
        Destination = "DST4"
        DestinationSubnet = "SUBNET5"
        Protocol = "TCP"
        Ports = "445"
        Description = "DESC6"
    },
    @{
        Source = "SRC3"
        SourceSubnet = "SUBNET3"
        Destination = "DST2"
        DestinationSubnet = "SUBNET2"
        Protocol = "TCP"
        Ports = 3389,135,"49152-65535"
        Description = "DESC7"
    },
    @{
        Source = "SRC3"
        SourceSubnet = "SUBNET3"
        Destination = "DST4"
        DestinationSubnet = "SUBNET5"
        Protocol = "TCP"
        Ports = "445"
        Description = "DESC8"
    },
    @{
        Source = "SRC3"
        SourceSubnet = "SUBNET3"
        Destination = "DST3"
        DestinationSubnet = "SUBNET3"
        Protocol = "TCP"
        Ports = 3389,135,5985,5986,"49152-65535"
        Description = "DESC9"
    },
    @{
        Source = "SRC4"
        SourceSubnet = "SUBNET4"
        Destination = "DST4"
        DestinationSubnet = "SUBNET4"
        Protocol = "TCP"
        Ports = 1433,4022,1434,5022,135,5985,5986,"49152-65535"
        Description = "DESC10"
    },
    @{
        Source = "SRC4"
        SourceSubnet = "SUBNET4"
        Destination = "DST2"
        DestinationSubnet = "SUBNET2"
        Protocol = "TCP"
        Ports = "1433"
        Description = "DESC11"
    },
    @{
        Source = "SRC5"
        SourceSubnet = "SUBNET5"
        Destination = "DST5"
        DestinationSubnet = "SUBNET5"
        Protocol = "TCP"
        Ports = 445,135,5722,5985,5986,"49152-65535"
        Description = "DESC12"
    },
    @{
        Source = "SRC5"
        SourceSubnet = "SUBNET5"
        Destination = "DST3"
        DestinationSubnet = "SUBNET3"
        Protocol = "TCP"
        Ports = "445"
        Description = "DESC13"
    },
    @{
        Source = "SRC5"
        SourceSubnet = "SUBNET5"
        Destination = "DST2"
        DestinationSubnet = "SUBNET2"
        Protocol = "TCP"
        Ports = "445"
        Description = "DESC14"
    }
)

# Create firewall rules based on the defined rules
foreach ($rule in $rules) {
    $name = "[$($rule.Source)] -> [$($rule.Destination)] $($rule.Protocol):$($rule.Ports)"
    $description = $rule.Description
    
    New-NetFirewallRule -DisplayName $name -Description $description -Direction Inbound -LocalAddress $rule.DestinationSubnet -RemoteAddress $rule.SourceSubnet -Protocol $rule.Protocol -LocalPort $rule.Ports -Action Allow
}
