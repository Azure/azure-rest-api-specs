import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

/**
 * IP Prefix Properties defines the properties of the resource.
 */
model IpPrefixProperties {
  ...AnnotationResource;

  /**
   * The list of IP Prefix Rules.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  ipPrefixRules: IpPrefixRule[];

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
 * IP Prefix Rule properties.
 */
model IpPrefixRule {
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
   * Network Prefix specifying IPv4/IPv6 packets to be permitted or denied. Example: 1.1.1.0/24 | 3FFE:FFFF:0:CD30::/126
   */
  networkPrefix: string;

  /**
   * Specify prefix-list bounds.
   */
  condition?: Condition;

  /**
   * SubnetMaskLength gives the minimum NetworkPrefix length to be matched. Possible values for IPv4 are 1 - 32 . Possible values of IPv6 are 1 - 128.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  subnetMaskLength?: string;
}

/**
 * The IP Prefix patch resource definition.
 */
model IpPrefixPatch {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...TagsUpdate;

  /**
   * IP Prefix patchable properties.
   */
  properties?: IpPrefixPatchProperties;
}

/**
 * IP Prefix patchable properties.
 */
model IpPrefixPatchProperties {
  ...AnnotationResource;

  /**
   * The list of IP Prefix Rules.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  ipPrefixRules?: IpPrefixRule[];
}

/**
 * Specify prefix-list bounds.
 */
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
