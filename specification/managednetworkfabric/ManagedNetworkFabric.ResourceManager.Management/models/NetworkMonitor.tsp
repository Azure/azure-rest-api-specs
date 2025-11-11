import "./common.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;

@doc("Network Monitor Properties defines the properties of the resource.")
@added(Versions.v2024_06_15_preview)
model NetworkMonitorProperties {
  ...AnnotationResource;

  @doc("BMP Configurations for the Network Fabric.")
  bmpConfiguration?: BmpConfigurationProperties;

  @doc("Details of the last operation performed on the resource")
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_06_15_preview)
  lastOperation?: LastOperationProperties;

  @doc("Configuration state of the resource.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  @doc("Provides you the latest status of the NetworkMonitor resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

@doc("Station Configuration State.")
union StationConfigurationState {
  @doc("StationConfigurationState Enabled")
  Enabled: "Enabled",

  @doc("StationConfigurationState Disabled")
  Disabled: "Disabled",

  string,
}

@doc("Station Connection Mode.")
union StationConnectionMode {
  @doc("StationConnectionMode Active")
  Active: "Active",

  @doc("StationConnectionMode Passive")
  Passive: "Passive",

  string,
}

@doc("Station Connection Properties.")
model StationConnectionProperties {
  @doc("Connection keepalive idle time in seconds")
  @maxValue(3600)
  @minValue(1)
  keepaliveIdleTime?: int32 = 180;

  @doc("Probe interval in seconds, default value is 60")
  @maxValue(3600)
  @minValue(1)
  probeInterval?: int32 = 60;

  @doc("Probe count, default value is 10")
  @maxValue(100)
  @minValue(1)
  probeCount?: int32 = 10;
}

@doc("Station Connection PATCH Properties.")
model StationConnectionPatchProperties {
  @doc("Connection keepalive idle time in seconds")
  @maxValue(3600)
  @minValue(1)
  keepaliveIdleTime?: int32;

  @doc("Probe interval in seconds, default value is 60")
  @maxValue(3600)
  @minValue(1)
  probeInterval?: int32;

  @doc("Probe count, default value is 10")
  @maxValue(100)
  @minValue(1)
  probeCount?: int32;
}

@doc("Export Policy for the BGP Monitoring Protocol (BMP) Configuration.")
union BmpExportPolicy {
  @doc("BMP ExportPolicy Pre-Policy")
  PrePolicy: "Pre-Policy",

  @doc("BMP ExportPolicy Post-Policy")
  PostPolicy: "Post-Policy",

  @doc("BMP ExportPolicy All")
  All: "All",

  string,
}

@doc("Monitored Address Family.")
union BmpMonitoredAddressFamily {
  @doc("IPv4 Unicast")
  ipv4Unicast: "ipv4Unicast",

  @doc("IPv6 Unicast")
  ipv6Unicast: "ipv6Unicast",

  @doc("VPN IPv4")
  vpnIpv4: "vpnIpv4",

  @doc("VPN IPv6")
  vpnIpv6: "vpnIpv6",

  @doc("All Address Families")
  All: "All",

  string,
}

@doc("BGP Monitoring Protocol (BMP) Configuration properties.")
model BmpConfigurationProperties {
  @doc("Enabling a station. Either True/False.")
  stationConfigurationState?: StationConfigurationState;

  @doc("Scope resource ARM Identifier.")
  scopeResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("Name of the station.")
  stationName?: string;

  @doc("IP Address of the station.")
  stationIp?: string;

  @doc("Port of the station. Default value is 5000.")
  @maxValue(65535)
  @minValue(1)
  stationPort?: int32 = 5000;

  @doc("Station Connection Mode.")
  stationConnectionMode?: StationConnectionMode;

  @doc("Station Connection Properties.")
  stationConnectionProperties?: StationConnectionProperties;

  @doc("Network of the station")
  stationNetwork?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/l3Isolationdomains/internalNetwork";
    },
    {
      type: "Microsoft.ManagedNetworkFabric/l3Isolationdomains/externalNetwork";
    }
  ]>;

  @doc("The List of Network ID's that need to be monitored.")
  monitoredNetworks?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/l3IsolationDomains";
    }
  ]>[];

  @doc("Export Policy for the BMP Configuration.")
  exportPolicy?: BmpExportPolicy = BmpExportPolicy.All;

  @doc("Monitored Address Families for the BMP Configuration.")
  monitoredAddressFamilies?: BmpMonitoredAddressFamily[] = #[
    BmpMonitoredAddressFamily.All
  ];
}

@doc("BMP Configuration patch properties.")
model BmpConfigurationPatchProperties {
  @doc("Enabling a station. Either True/False.")
  stationConfigurationState?: StationConfigurationState;

  @doc("Scope resource ARM Identifier.")
  scopeResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("Name of the station.")
  stationName?: string;

  @doc("IP Address of the station.")
  stationIp?: string;

  @doc("Port of the station. Default value is 5000.")
  @maxValue(65535)
  @minValue(1)
  stationPort?: int32;

  @doc("Station Connection Mode.")
  stationConnectionMode?: StationConnectionMode;

  @doc("Station Connection Properties.")
  stationConnectionProperties?: StationConnectionPatchProperties;

  @doc("Network of the station")
  stationNetwork?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/l3Isolationdomains/internalNetwork";
    },
    {
      type: "Microsoft.ManagedNetworkFabric/l3Isolationdomains/externalNetwork";
    }
  ]>;

  @doc("The List of Network ID's that need to be monitored.")
  monitoredNetworks?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/l3IsolationDomains";
    }
  ]>[];

  @doc("Export Policy for the BMP Configuration.")
  exportPolicy?: BmpExportPolicy;

  @doc("Monitored Address Families for the BMP Configuration.")
  monitoredAddressFamilies?: BmpMonitoredAddressFamily[];
}

@doc("The Network Monitor Patch resource definition.")
@added(Versions.v2024_06_15_preview)
model NetworkMonitorPatch {
  ...TagsUpdate;

  @doc("Network Monitor Patch properties.")
  properties?: NetworkMonitorPatchProperties;
}

@doc("The Network Monitor Patch Properties.")
model NetworkMonitorPatchProperties {
  @doc("BGP Monitoring Protocol (BMP) Configurations for the Network Monitor.")
  bmpConfiguration?: BmpConfigurationPatchProperties;
}
