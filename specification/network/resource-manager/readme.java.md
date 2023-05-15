## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.network
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-network
directive:
  - rename-operation:
      from: VirtualHubBgpConnection_Get
      to: VirtualHubBgpConnections_Get
  - rename-operation:
      from: VirtualHubBgpConnection_CreateOrUpdate
      to: VirtualHubBgpConnections_CreateOrUpdate
  - rename-operation:
      from: VirtualHubBgpConnection_Delete
      to: VirtualHubBgpConnections_Delete
  - rename-operation:
      from: InboundSecurityRule_CreateOrUpdate
      to: InboundSecurityRuleOperation_CreateOrUpdate
  - from: vmssNetworkInterface.json
    where: '$.info'
    transform: >
      $["version"] = "2018-10-01";
  - from: vmssNetworkPublicIpAddress.json
    where: '$.info'
    transform: >
      $["version"] = "2018-10-01";
  - from: applicationGateway.json
    where: '$.definitions.ApplicationGatewayFirewallExclusion'
    transform: >
      $["required"] = ["matchVariable"]
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-06
  - tag: package-2020-05
  - tag: package-2020-04
  - tag: package-2020-03
  - tag: package-2019-09
  - tag: package-2019-08
  - tag: package-2019-07
  - tag: package-2019-06
  - tag: package-2019-04
  - tag: package-2019-02
  - tag: package-2018-11
```

### Tag: package-2020-06 and java

These settings apply only when `--tag=package-2020-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2020_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/network/mgmt-v2020_06_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2020-05 and java

These settings apply only when `--tag=package-2020-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2020_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/network/mgmt-v2020_05_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2020-04 and java

These settings apply only when `--tag=package-2020-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2020_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/network/mgmt-v2020_04_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2020-03 and java

These settings apply only when `--tag=package-2020-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2020_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/network/mgmt-v2020_03_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2019-09 and java

These settings apply only when `--tag=package-2019-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2019_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/network/mgmt-v2019_09_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2019-08 and java

These settings apply only when `--tag=package-2019-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2019_08_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/network/mgmt-v2019_08_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2019-07 and java

These settings apply only when `--tag=package-2019-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2019_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/network/mgmt-v2019_07_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2019-06 and java

These settings apply only when `--tag=package-2019-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2019_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/network/mgmt-v2019_06_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2019-04 and java

These settings apply only when `--tag=package-2019-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2019_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/network/mgmt-v2019_04_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2019-02 and java

These settings apply only when `--tag=package-2019-02 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2019_02_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/network/mgmt-v2019_02_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2018-12 and java

These settings apply only when `--tag=package-2018-12 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2018_12_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/network/mgmt-v2018_12_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2018-11 and java

These settings apply only when `--tag=package-2018-11 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-11' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2018_11_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/network/mgmt-v2018_11_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2018-08 and java

These settings apply only when `--tag=package-2018-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2018_08_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/network/mgmt-v2018_08_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2018-07 and java

These settings apply only when `--tag=package-2018-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2018_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/network/mgmt-v2018_07_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2018-06 and java

These settings apply only when `--tag=package-2018-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2018_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/network/mgmt-v2018_06_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2018-04 and java

These settings apply only when `--tag=package-2018-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2018_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/network/mgmt-v2018_04_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2017-10 and java

These settings apply only when `--tag=package-2017-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2017_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/network/mgmt-v2017_10_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: profile-hybrid-2019-03-01

These settings apply only when `--tag=profile-hybrid-2019-03-01` is specified on the command line.
Creating this tag to pick proper resources from the hybrid profile.

``` yaml $(tag) == 'profile-hybrid-2019-03-01'
input-file:
- Microsoft.Network/stable/2017-10-01/loadBalancer.json
- Microsoft.Network/stable/2017-10-01/virtualNetworkGateway.json
- Microsoft.Network/stable/2017-10-01/network.json
- Microsoft.Network/stable/2017-10-01/networkInterface.json
- Microsoft.Network/stable/2017-10-01/networkSecurityGroup.json
- Microsoft.Network/stable/2017-10-01/operation.json
- Microsoft.Network/stable/2017-10-01/publicIpAddress.json
- Microsoft.Network/stable/2017-10-01/routeTable.json
- Microsoft.Network/stable/2017-10-01/virtualNetwork.json
```

### Tag: profile-hybrid-2020-09-01 and java

These settings apply only when `--tag=profile-hybrid-2020-09-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'profile-hybrid-2020-09-01' && $(java)
input-file:
  - Microsoft.Network/stable/2018-11-01/applicationGateway.json
  - Microsoft.Network/stable/2018-11-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2018-11-01/availableDelegations.json
  - Microsoft.Network/stable/2018-11-01/azureFirewall.json
  - Microsoft.Network/stable/2018-11-01/azureFirewallFqdnTag.json
  - Microsoft.Network/stable/2018-11-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2018-11-01/ddosCustomPolicy.json
  - Microsoft.Network/stable/2018-11-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2018-11-01/endpointService.json
  - Microsoft.Network/stable/2018-11-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2018-11-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2018-11-01/expressRouteGateway.json
  - Microsoft.Network/stable/2018-11-01/expressRoutePort.json
  - Microsoft.Network/stable/2018-11-01/interfaceEndpoint.json
  - Microsoft.Network/stable/2018-11-01/loadBalancer.json
  - Microsoft.Network/stable/2018-11-01/network.json
  - Microsoft.Network/stable/2018-11-01/networkInterface.json
  - Microsoft.Network/stable/2018-11-01/networkProfile.json
  - Microsoft.Network/stable/2018-11-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2018-11-01/networkWatcher.json
  - Microsoft.Network/stable/2018-11-01/operation.json
  - Microsoft.Network/stable/2018-11-01/publicIpAddress.json
  - Microsoft.Network/stable/2018-11-01/publicIpPrefix.json
  - Microsoft.Network/stable/2018-11-01/routeFilter.json
  - Microsoft.Network/stable/2018-11-01/routeTable.json
  - Microsoft.Network/stable/2018-11-01/serviceCommunity.json
  - Microsoft.Network/stable/2018-11-01/serviceEndpointPolicy.json
  - Microsoft.Network/stable/2018-11-01/usage.json
  - Microsoft.Network/stable/2018-11-01/virtualNetwork.json
  - Microsoft.Network/stable/2018-11-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2018-11-01/virtualNetworkTap.json
  - Microsoft.Network/stable/2018-11-01/virtualWan.json
  - Microsoft.Network/stable/2018-11-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2018-11-01/vmssPublicIpAddress.json
directive:
  - from: loadBalancer.json
    where: $.definitions.OutboundRulePropertiesFormat.properties.protocol
    transform: > 
      $['x-ms-enum'] = {
        name: 'LoadBalancerOutboundRuleProtocol',
        modelAsString: true,
      };
```
