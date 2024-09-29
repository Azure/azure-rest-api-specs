import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

/**
 * IP Extended Community Properties defines the resource properties.
 */
model IpExtendedCommunityProperties {
  ...AnnotationResource;

  /**
   * List of IP Extended Community Rules.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  ipExtendedCommunityRules: IpExtendedCommunityRule[];

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
 * List of IP Extended Community Rules.
 */
model IpExtendedCommunityRule {
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
   * Route Target List.The expected formats are ASN(plain):NN >> example 4294967294:50, ASN.ASN:NN >> example 65533.65333:40, IP-address:NN >> example 10.10.10.10:65535. The possible values of ASN,NN are in range of 0-65535, ASN(plain) is in range of 0-4294967295.
   */
  @minItems(1)
  routeTargets: string[];
}

/**
 * The IP Extended Communities patch resource definition.
 */
model IpExtendedCommunityPatch {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...TagsUpdate;

  /**
   * IP Extended Community patchable properties.
   */
  properties?: IpExtendedCommunityPatchProperties;
}

/**
 * IP Extended Community patchable properties.
 */
model IpExtendedCommunityPatchProperties {
  ...AnnotationResource;

  /**
   * List of IP Extended Community Rules.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  ipExtendedCommunityRules?: IpExtendedCommunityRule[];
}
