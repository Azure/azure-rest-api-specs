import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;
/**
 * IP Community Properties defines the resource properties.
 */
model IpCommunityProperties {
  ...AnnotationResource;

  /**
   * List of IP Community Rules.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  ipCommunityRules: IpCommunityRule[];

  /**
   * Configuration state of the resource.
   */
  @visibility("read")
  configurationState?: ConfigurationState;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility("read")
  administrativeState?: AdministrativeState;
}

/**
 * IP Community patchable properties.
 */
model IpCommunityPatchableProperties {
  /**
   * List of IP Community Rules.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  ipCommunityRules?: IpCommunityRule[];
}

/**
 * IP Community patchable properties.
 */
model IpCommunityRule {
  /**
   * Action to be taken on the configuration. Example: Permit | Deny.
   */
  action: CommunityActionTypes;

  /**
   * Sequence to insert to/delete from existing route. Prefix lists are evaluated starting with the lowest sequence number and continue down the list until a match is made. Once a match is made, the permit or deny statement is applied to that network and the rest of the list is ignored.
   */
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber: int64;

  /**
   * Supported well known Community List.
   */
  wellKnownCommunities?: WellKnownCommunities[];

  /**
   * List the community members of IP Community.
   */
  @minItems(1)
  communityMembers: string[];
}

/**
 * The IP Community patch resource definition.
 */
model IpCommunityPatch {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...TagsUpdate;

  /**
   * IP Community patchable properties.
   */
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
