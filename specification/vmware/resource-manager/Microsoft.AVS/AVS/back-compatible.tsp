import "@azure-tools/typespec-client-generator-core";
import "./workloadNetworks.tsp";
import "./workloadNetworks-vmGroups.tsp";
import "./workloadNetworks-virtualMachines.tsp";
import "./workloadNetworks-segments.tsp";
import "./workloadNetworks-publicIPs.tsp";
import "./workloadNetworks-portMirroringProfiles.tsp";
import "./workloadNetworks-gateways.tsp";
import "./workloadNetworks-dnsZones.tsp";
import "./workloadNetworks-dnsServices.tsp";
import "./workloadNetworks-dhcpConfigurations.tsp";

using Azure.ClientGenerator.Core;

using Microsoft.AVS;

@@clientLocation(WorkloadNetworkVmGroups.list, WorkloadNetworks, "!csharp");
@@clientLocation(WorkloadNetworkVmGroups.get, WorkloadNetworks, "!csharp");
@@clientLocation(WorkloadNetworkVmGroups.create, WorkloadNetworks, "!csharp");
@@clientLocation(WorkloadNetworkVmGroups.update, WorkloadNetworks, "!csharp");
@@clientLocation(WorkloadNetworkVmGroups.delete, WorkloadNetworks, "!csharp");

@@clientLocation(WorkloadNetworkVirtualMachines.list,
  WorkloadNetworks,
  "!csharp"
);
@@clientLocation(WorkloadNetworkVirtualMachines.get,
  WorkloadNetworks,
  "!csharp"
);

@@clientLocation(WorkloadNetworkSegments.list, WorkloadNetworks, "!csharp");
@@clientLocation(WorkloadNetworkSegments.get, WorkloadNetworks, "!csharp");
@@clientLocation(WorkloadNetworkSegments.create, WorkloadNetworks, "!csharp");
@@clientLocation(WorkloadNetworkSegments.update, WorkloadNetworks, "!csharp");
@@clientLocation(WorkloadNetworkSegments.deleteSegment,
  WorkloadNetworks,
  "!csharp"
);

@@clientLocation(WorkloadNetworkPublicIps.list, WorkloadNetworks, "!csharp");
@@clientLocation(WorkloadNetworkPublicIps.get, WorkloadNetworks, "!csharp");
@@clientLocation(WorkloadNetworkPublicIps.create, WorkloadNetworks, "!csharp");
@@clientLocation(WorkloadNetworkPublicIps.delete, WorkloadNetworks, "!csharp");

@@clientLocation(WorkloadNetworkPortMirroringProfiles.list,
  WorkloadNetworks,
  "!csharp"
);
@@clientLocation(WorkloadNetworkPortMirroringProfiles.get,
  WorkloadNetworks,
  "!csharp"
);
@@clientLocation(WorkloadNetworkPortMirroringProfiles.create,
  WorkloadNetworks,
  "!csharp"
);
@@clientLocation(WorkloadNetworkPortMirroringProfiles.update,
  WorkloadNetworks,
  "!csharp"
);
@@clientLocation(WorkloadNetworkPortMirroringProfiles.delete,
  WorkloadNetworks,
  "!csharp"
);

@@clientLocation(WorkloadNetworkGateways.list, WorkloadNetworks, "!csharp");
@@clientLocation(WorkloadNetworkGateways.get, WorkloadNetworks, "!csharp");

@@clientLocation(WorkloadNetworkDnsZones.list, WorkloadNetworks, "!csharp");
@@clientLocation(WorkloadNetworkDnsZones.get, WorkloadNetworks, "!csharp");
@@clientLocation(WorkloadNetworkDnsZones.create, WorkloadNetworks, "!csharp");
@@clientLocation(WorkloadNetworkDnsZones.update, WorkloadNetworks, "!csharp");
@@clientLocation(WorkloadNetworkDnsZones.delete, WorkloadNetworks, "!csharp");

@@clientLocation(WorkloadNetworkDnsServices.list, WorkloadNetworks, "!csharp");
@@clientLocation(WorkloadNetworkDnsServices.get, WorkloadNetworks, "!csharp");
@@clientLocation(WorkloadNetworkDnsServices.create,
  WorkloadNetworks,
  "!csharp"
);
@@clientLocation(WorkloadNetworkDnsServices.update,
  WorkloadNetworks,
  "!csharp"
);
@@clientLocation(WorkloadNetworkDnsServices.delete,
  WorkloadNetworks,
  "!csharp"
);

@@clientLocation(WorkloadNetworkDhcpConfigurations.list,
  WorkloadNetworks,
  "!csharp"
);
@@clientLocation(WorkloadNetworkDhcpConfigurations.get,
  WorkloadNetworks,
  "!csharp"
);
@@clientLocation(WorkloadNetworkDhcpConfigurations.create,
  WorkloadNetworks,
  "!csharp"
);
@@clientLocation(WorkloadNetworkDhcpConfigurations.update,
  WorkloadNetworks,
  "!csharp"
);
@@clientLocation(WorkloadNetworkDhcpConfigurations.delete,
  WorkloadNetworks,
  "!csharp"
);

// Flatten properties for backward compatibility
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CloudLink.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Cluster.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Datastore.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExpressRouteAuthorization.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GlobalReachConnection.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(HcxEnterpriseSite.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(IscsiPath.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateCloud.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProvisionedNetwork.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PureStoragePolicy.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScriptCmdlet.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScriptExecution.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScriptPackage.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachine.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadNetworkDnsService.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadNetworkDnsZone.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadNetworkGateway.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadNetworkPortMirroring.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadNetwork.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadNetworkPublicIP.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadNetworkSegment.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadNetworkVMGroup.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadNetworkVirtualMachine.properties,
  "autorest"
);
