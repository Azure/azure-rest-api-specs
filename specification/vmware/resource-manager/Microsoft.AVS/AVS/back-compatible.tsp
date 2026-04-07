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

@@clientLocation(WorkloadNetworkVmGroups.list, WorkloadNetworks);
@@clientLocation(WorkloadNetworkVmGroups.get, WorkloadNetworks);
@@clientLocation(WorkloadNetworkVmGroups.create, WorkloadNetworks);
@@clientLocation(WorkloadNetworkVmGroups.update, WorkloadNetworks);
@@clientLocation(WorkloadNetworkVmGroups.delete, WorkloadNetworks);

@@clientLocation(WorkloadNetworkVirtualMachines.list, WorkloadNetworks);
@@clientLocation(WorkloadNetworkVirtualMachines.get, WorkloadNetworks);

@@clientLocation(WorkloadNetworkSegments.list, WorkloadNetworks);
@@clientLocation(WorkloadNetworkSegments.get, WorkloadNetworks);
@@clientLocation(WorkloadNetworkSegments.create, WorkloadNetworks);
@@clientLocation(WorkloadNetworkSegments.update, WorkloadNetworks);
@@clientLocation(WorkloadNetworkSegments.deleteSegment, WorkloadNetworks);

@@clientLocation(WorkloadNetworkPublicIps.list, WorkloadNetworks);
@@clientLocation(WorkloadNetworkPublicIps.get, WorkloadNetworks);
@@clientLocation(WorkloadNetworkPublicIps.create, WorkloadNetworks);
@@clientLocation(WorkloadNetworkPublicIps.delete, WorkloadNetworks);

@@clientLocation(WorkloadNetworkPortMirroringProfiles.list, WorkloadNetworks);
@@clientLocation(WorkloadNetworkPortMirroringProfiles.get, WorkloadNetworks);
@@clientLocation(WorkloadNetworkPortMirroringProfiles.create, WorkloadNetworks);
@@clientLocation(WorkloadNetworkPortMirroringProfiles.update, WorkloadNetworks);
@@clientLocation(WorkloadNetworkPortMirroringProfiles.delete, WorkloadNetworks);

@@clientLocation(WorkloadNetworkGateways.list, WorkloadNetworks);
@@clientLocation(WorkloadNetworkGateways.get, WorkloadNetworks);

@@clientLocation(WorkloadNetworkDnsZones.list, WorkloadNetworks);
@@clientLocation(WorkloadNetworkDnsZones.get, WorkloadNetworks);
@@clientLocation(WorkloadNetworkDnsZones.create, WorkloadNetworks);
@@clientLocation(WorkloadNetworkDnsZones.update, WorkloadNetworks);
@@clientLocation(WorkloadNetworkDnsZones.delete, WorkloadNetworks);

@@clientLocation(WorkloadNetworkDnsServices.list, WorkloadNetworks);
@@clientLocation(WorkloadNetworkDnsServices.get, WorkloadNetworks);
@@clientLocation(WorkloadNetworkDnsServices.create, WorkloadNetworks);
@@clientLocation(WorkloadNetworkDnsServices.update, WorkloadNetworks);
@@clientLocation(WorkloadNetworkDnsServices.delete, WorkloadNetworks);

@@clientLocation(WorkloadNetworkDhcpConfigurations.list, WorkloadNetworks);
@@clientLocation(WorkloadNetworkDhcpConfigurations.get, WorkloadNetworks);
@@clientLocation(WorkloadNetworkDhcpConfigurations.create, WorkloadNetworks);
@@clientLocation(WorkloadNetworkDhcpConfigurations.update, WorkloadNetworks);
@@clientLocation(WorkloadNetworkDhcpConfigurations.delete, WorkloadNetworks);

@@clientName(WorkloadNetworkVmGroups.list, "ListVMGroups");
@@clientName(WorkloadNetworkVmGroups.get, "GetVMGroup");
@@clientName(WorkloadNetworkVmGroups.create, "CreateVMGroup");
@@clientName(WorkloadNetworkVmGroups.update, "UpdateVMGroup");
@@clientName(WorkloadNetworkVmGroups.delete, "DeleteVMGroup");

@@clientName(WorkloadNetworkVirtualMachines.list, "ListVirtualMachines");
@@clientName(WorkloadNetworkVirtualMachines.get, "GetVirtualMachine");

@@clientName(WorkloadNetworkSegments.list, "ListSegments");
@@clientName(WorkloadNetworkSegments.get, "GetSegment");
@@clientName(WorkloadNetworkSegments.create, "CreateSegments");
@@clientName(WorkloadNetworkSegments.update, "UpdateSegments");
@@clientName(WorkloadNetworkSegments.deleteSegment, "DeleteSegment");

@@clientName(WorkloadNetworkPublicIps.list, "ListPublicIPs");
@@clientName(WorkloadNetworkPublicIps.get, "GetPublicIP");
@@clientName(WorkloadNetworkPublicIps.create, "CreatePublicIP");
@@clientName(WorkloadNetworkPublicIps.delete, "DeletePublicIP");

@@clientName(WorkloadNetworkPortMirroringProfiles.list, "ListPortMirroring");
@@clientName(WorkloadNetworkPortMirroringProfiles.get, "GetPortMirroring");
@@clientName(WorkloadNetworkPortMirroringProfiles.create,
  "CreatePortMirroring"
);
@@clientName(WorkloadNetworkPortMirroringProfiles.update,
  "UpdatePortMirroring"
);
@@clientName(WorkloadNetworkPortMirroringProfiles.delete,
  "DeletePortMirroring"
);

@@clientName(WorkloadNetworkGateways.list, "ListGateways");
@@clientName(WorkloadNetworkGateways.get, "GetGateway");

@@clientName(WorkloadNetworkDnsZones.list, "ListDnsZones");
@@clientName(WorkloadNetworkDnsZones.get, "GetDnsZone");
@@clientName(WorkloadNetworkDnsZones.create, "CreateDnsZone");
@@clientName(WorkloadNetworkDnsZones.update, "UpdateDnsZone");
@@clientName(WorkloadNetworkDnsZones.delete, "DeleteDnsZone");

@@clientName(WorkloadNetworkDnsServices.list, "ListDnsServices");
@@clientName(WorkloadNetworkDnsServices.get, "GetDnsService");
@@clientName(WorkloadNetworkDnsServices.create, "CreateDnsService");
@@clientName(WorkloadNetworkDnsServices.update, "UpdateDnsService");
@@clientName(WorkloadNetworkDnsServices.delete, "DeleteDnsService");

@@clientName(WorkloadNetworkDhcpConfigurations.list, "ListDhcp");
@@clientName(WorkloadNetworkDhcpConfigurations.get, "GetDhcp");
@@clientName(WorkloadNetworkDhcpConfigurations.create, "CreateDhcp");
@@clientName(WorkloadNetworkDhcpConfigurations.update, "UpdateDhcp");
@@clientName(WorkloadNetworkDhcpConfigurations.delete, "DeleteDhcp");

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
