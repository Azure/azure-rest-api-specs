import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.DependencyMap;

@@clientName(Microsoft.DependencyMap, "DependencyMapMgmt", "python");

@@clientName(Microsoft.DependencyMap, "DependencyMapManagementClient", "java");

// CSharp
@@clientName(MapsResource, "DependencyMap", "csharp");
@@clientName(MapsResourceProperties, "DependencyMapProperties", "csharp");
@@clientName(ProvisioningState, "DependencyMapProvisioningState", "csharp");
@@clientName(DiscoverySourceResource, "DependencyMapDiscoverySource", "csharp");
@@clientName(DiscoverySourceResourceProperties,
  "DependencyMapDiscoverySourceProperties",
  "csharp"
);
@@clientName(DateTimeFilter, "DependencyMapDateTimeFilter", "csharp");
@@clientName(DateTimeFilter.startDateTimeUtc, "StartOn", "csharp");
@@clientName(DateTimeFilter.endDateTimeUtc, "EndOn", "csharp");
@@clientName(OffAzureDiscoverySourceResourceProperties,
  "OffAzureDiscoverySourceProperties",
  "csharp"
);
@@clientName(ProcessNameFilter, "DependencyMapProcessNameFilter", "csharp");
@@clientName(ProcessNameFilterOperator,
  "DependencyMapProcessNameFilterOperator",
  "csharp"
);
@@clientName(ExportDependenciesRequest, "ExportDependenciesContent", "csharp");
@@clientName(GetDependencyViewForFocusedMachineRequest,
  "GetDependencyViewForFocusedMachineContent",
  "csharp"
);
@@clientName(GetConnectionsForProcessOnFocusedMachineRequest,
  "GetConnectionsForProcessOnFocusedMachineContent",
  "csharp"
);
@@clientName(GetConnectionsWithConnectedMachineForFocusedMachineRequest,
  "GetConnectionsWithConnectedMachineForFocusedMachineContent",
  "csharp"
);
@@clientName(GetDependencyViewForAllMachinesRequest,
  "GetDependencyViewForAllMachinesContent",
  "csharp"
);
@@alternateType(GetDependencyViewForFocusedMachineRequest.focusedMachineId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(GetConnectionsWithConnectedMachineForFocusedMachineRequest.focusedMachineId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(GetConnectionsWithConnectedMachineForFocusedMachineRequest.connectedMachineId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(GetConnectionsForProcessOnFocusedMachineRequest.focusedMachineId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ExportDependenciesRequest.focusedMachineId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(DiscoverySourceResourceProperties.sourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);
