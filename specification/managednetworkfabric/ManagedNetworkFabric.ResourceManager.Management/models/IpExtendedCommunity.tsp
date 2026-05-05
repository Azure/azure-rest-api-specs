import "./common.tsp";

using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

@doc("IP Extended Community Properties defines the resource properties.")
model IpExtendedCommunityProperties {
  ...AnnotationResource;

  @added(Versions.v2024_06_15_preview)
  @doc("ARM Resource ID of the Network Fabric.")
  @visibility(Lifecycle.Read)
  networkFabricId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("List of IP Extended Community Rules.")
  @Azure.ResourceManager.identifiers(#[])
  ipExtendedCommunityRules: IpExtendedCommunityRule[];

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

@doc("List of IP Extended Community Rules.")
model IpExtendedCommunityRule {
  @doc("Action to be taken on the configuration. Example: Permit | Deny.")
  action: CommunityActionTypes;

  @doc("Sequence to insert to/delete from existing route. Prefix lists are evaluated starting with the lowest sequence number and continue down the list until a match is made. Once a match is made, the permit or deny statement is applied to that network and the rest of the list is ignored.")
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber: int64;

  @doc("Route Target List.The expected formats are ASN(plain):NN >> example 4294967294:50, ASN.ASN:NN >> example 65533.65333:40, IP-address:NN >> example 10.10.10.10:65535. The possible values of ASN,NN are in range of 0-65535, ASN(plain) is in range of 0-4294967295.")
  @minItems(1)
  routeTargets: string[];
}

@doc("The IP Extended Communities patch resource definition.")
model IpExtendedCommunityPatch {
  ...TagsUpdate;

  @doc("IP Extended Community patchable properties.")
  properties?: IpExtendedCommunityPatchProperties;
}

@doc("IP Extended Community patchable properties.")
model IpExtendedCommunityPatchProperties {
  ...AnnotationResource;

  @doc("List of IP Extended Community Rules.")
  @Azure.ResourceManager.identifiers(#[])
  ipExtendedCommunityRules?: IpExtendedCommunityRule[];
}
