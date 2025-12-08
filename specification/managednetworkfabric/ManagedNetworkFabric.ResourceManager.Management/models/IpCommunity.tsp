import "./common.tsp";

using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;
@doc("IP Community Properties defines the resource properties.")
model IpCommunityProperties {
  ...AnnotationResource;

  @added(Versions.v2024_06_15_preview)
  @doc("ARM Resource ID of the Network Fabric.")
  @visibility(Lifecycle.Read)
  networkFabricId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("List of IP Community Rules.")
  @Azure.ResourceManager.identifiers(#[])
  ipCommunityRules: IpCommunityRule[];

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

@doc("IP Community patchable properties.")
model IpCommunityPatchableProperties {
  @doc("List of IP Community Rules.")
  @Azure.ResourceManager.identifiers(#[])
  ipCommunityRules?: IpCommunityRule[];
}

@doc("IP Community patchable properties.")
model IpCommunityRule {
  @doc("Action to be taken on the configuration. Example: Permit | Deny.")
  action: CommunityActionTypes;

  @doc("Sequence to insert to/delete from existing route. Prefix lists are evaluated starting with the lowest sequence number and continue down the list until a match is made. Once a match is made, the permit or deny statement is applied to that network and the rest of the list is ignored.")
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber: int64;

  @doc("Supported well known Community List.")
  wellKnownCommunities?: WellKnownCommunities[];

  @doc("List the community members of IP Community.")
  @minItems(1)
  communityMembers: string[];
}

@doc("The IP Community patch resource definition.")
model IpCommunityPatch {
  ...TagsUpdate;

  @doc("IP Community patchable properties.")
  properties?: IpCommunityPatchableProperties;
}

/**
 *
 * `Internet` - Advertise routes to internet community.
 *  `LocalAS` - Advertise routes to only localAS peers.
 *  `NoAdvertise` - Don't advertise routes to any peer.
 * `NoExport` - Don't export to next AS.
 * `GShut` - Graceful Shutdown (GSHUT) withdraw routes before terminating BGP connection.
 *
 */
union WellKnownCommunities {
  @doc("WellKnownCommunities-Internet")
  Internet: "Internet",

  @doc("WellKnownCommunities-LocalAS")
  LocalAS: "LocalAS",

  @doc("WellKnownCommunities-NoAdvertise")
  NoAdvertise: "NoAdvertise",

  @doc("WellKnownCommunities-NoExport")
  NoExport: "NoExport",

  @doc("WellKnownCommunities-GShut")
  GShut: "GShut",

  string,
}
