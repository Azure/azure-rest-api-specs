import "./common.tsp";
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;

@doc("L2Isolation Domain Properties defines the properties of the resource.")
model L2IsolationDomainProperties {
  ...AnnotationResource;

  @doc("ARM Resource ID of the Network Fabric.")
  networkFabricId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("Vlan Identifier of the Network Fabric. Example: 501.")
  @maxValue(4094)
  @minValue(100)
  vlanId: int32;

  @doc("Maximum transmission unit. Default value is 1500.")
  @maxValue(9200)
  @minValue(64)
  mtu?: int32 = 1500;

  @added(Versions.v2024_06_15_preview)
  @doc("Extended VLAN status, default value is Disabled.")
  extendedVlan?: ExtendedVlan = ExtendedVlan.Disabled;

  @added(Versions.v2024_06_15_preview)
  @doc("ARM Resource ID of the networkToNetworkInterconnectId of the L2 ISD resource.")
  networkToNetworkInterconnectId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics/networkToNetworkInterconnects";
    }
  ]>;

  @doc("Details of the last operation performed on the resource")
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_06_15_preview)
  lastOperation?: LastOperationProperties;

  @doc("Configuration state of the resource.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

@doc("The L2 Isolation Domain patch resource definition.")
model L2IsolationDomainPatch {
  ...TagsUpdate;

  @doc("Resource properties.")
  properties?: L2IsolationDomainPatchProperties;
}

@doc("L2 Isolation Domain Patch Properties defines the patchable properties of the resource.")
@withoutDefaultValues
model L2IsolationDomainPatchProperties {
  ...AnnotationResource;

  @doc("Maximum transmission unit. Default value is 1500.")
  @maxValue(9200)
  @minValue(64)
  mtu?: int32;

  @doc("Extended VLAN status.")
  @added(Versions.v2024_06_15_preview)
  extendedVlan?: ExtendedVlan;

  @added(Versions.v2024_06_15_preview)
  @doc("ARM Resource ID of the networkToNetworkInterconnectId of the L2 ISD resource.")
  networkToNetworkInterconnectId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics/networkToNetworkInterconnects";
    }
  ]>;
}

@doc("Extended VLAN status.")
union ExtendedVlan {
  @doc("Extended VLAN is enabled.")
  Enabled: "Enabled",

  @doc("Extended VLAN is disabled.")
  Disabled: "Disabled",

  string,
}
