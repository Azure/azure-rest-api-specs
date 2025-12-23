import "./common.tsp";

using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

@doc("IP Prefix Properties defines the properties of the resource.")
model IpPrefixProperties {
  ...AnnotationResource;

  @added(Versions.v2024_06_15_preview)
  @doc("ARM Resource ID of the Network Fabric.")
  @visibility(Lifecycle.Read)
  networkFabricId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("The list of IP Prefix Rules.")
  @Azure.ResourceManager.identifiers(#[])
  ipPrefixRules: IpPrefixRule[];

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

@doc("IP Prefix Rule properties.")
model IpPrefixRule {
  @doc("Action to be taken on the configuration. Example: Permit | Deny.")
  action: CommunityActionTypes;

  @doc("Sequence to insert to/delete from existing route. Prefix lists are evaluated starting with the lowest sequence number and continue down the list until a match is made. Once a match is made, the permit or deny statement is applied to that network and the rest of the list is ignored.")
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber: int64;

  @doc("Network Prefix specifying IPv4/IPv6 packets to be permitted or denied. Example: 1.1.1.0/24 | 3FFE:FFFF:0:CD30::/126")
  networkPrefix: string;

  @doc("Specify prefix-list bounds.")
  condition?: Condition;

  @doc("SubnetMaskLength gives the minimum NetworkPrefix length to be matched. Possible values for IPv4 are 1 - 32 . Possible values of IPv6 are 1 - 128.")
  subnetMaskLength?: string;
}

@doc("The IP Prefix patch resource definition.")
model IpPrefixPatch {
  ...TagsUpdate;

  @doc("IP Prefix patchable properties.")
  properties?: IpPrefixPatchProperties;
}

@doc("IP Prefix patchable properties.")
model IpPrefixPatchProperties {
  ...AnnotationResource;

  @doc("The list of IP Prefix Rules.")
  @Azure.ResourceManager.identifiers(#[])
  ipPrefixRules?: IpPrefixRule[];
}

@doc("Specify prefix-list bounds.")
union Condition {
  @doc("Condition-EqualTo")
  EqualTo: "EqualTo",

  @doc("Condition-GreaterThanOrEqualTo")
  GreaterThanOrEqualTo: "GreaterThanOrEqualTo",

  @doc("Condition-LesserThanOrEqualTo")
  LesserThanOrEqualTo: "LesserThanOrEqualTo",

  @doc("Condition-Range")
  Range: "Range",

  string,
}
