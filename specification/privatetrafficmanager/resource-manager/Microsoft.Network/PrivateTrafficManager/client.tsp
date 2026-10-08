import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Network, "PrivateTrafficManagerMgmtClient", "python");
@@clientName(
  Microsoft.Network,
  "PrivateTrafficManagerManagementClient",
  "javascript"
);

// C# naming
@@clientName(
  Microsoft.Network.Endpoint,
  "PrivateTrafficManagerEndpoint",
  "csharp"
);
@@clientName(
  Microsoft.Network.EndpointProperties,
  "PrivateTrafficManagerEndpointProperties",
  "csharp"
);
@@clientName(
  Microsoft.Network.EndpointsKind,
  "PrivateTrafficManagerEndpointKind",
  "csharp"
);
@@clientName(
  Microsoft.Network.AdministrativeStatus,
  "EndpointAdministrativeStatus",
  "csharp"
);
@@clientName(Microsoft.Network.AlwaysServe, "EndpointAlwaysServe", "csharp");
@@clientName(Microsoft.Network.Site, "TopologyMapSite", "csharp");
@@clientName(
  Microsoft.Network.SiteProperties,
  "TopologyMapSiteProperties",
  "csharp"
);
@@clientName(Microsoft.Network.CustomHeader, "ProbeCustomHeader", "csharp");
@@clientName(Microsoft.Network.Protocol, "ProbeProtocol", "csharp");
@@clientName(Microsoft.Network.Protocol.HTTP, "Http", "csharp");
@@clientName(Microsoft.Network.Protocol.HTTPS, "Https", "csharp");
@@clientName(Microsoft.Network.Protocol.TCP, "Tcp", "csharp");
@@clientName(
  Microsoft.Network.DnsConfig,
  "PrivateTrafficManagerDnsConfig",
  "csharp"
);
@@clientName(Microsoft.Network.DnsConfig.ttl, "TimeToLiveInSeconds", "csharp");
@@clientName(Microsoft.Network.RecordType, "DnsRecordType", "csharp");
@@clientName(
  Microsoft.Network.ProfileProperties,
  "PrivateTrafficManagerProfileProperties",
  "csharp"
);
@@clientName(
  Microsoft.Network.ProfileStatus,
  "PrivateTrafficManagerProfileStatus",
  "csharp"
);
// Internal envelope name drives the flattened property name (CatchAllSiteName).
@@clientName(
  Microsoft.Network.TopologyMapPatch.properties,
  "CatchAllSite",
  "csharp"
);
