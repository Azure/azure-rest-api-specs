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

namespace Microsoft.AVS;

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
