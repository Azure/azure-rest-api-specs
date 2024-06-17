import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

/**
 * RoutePolicyProperties defines the resource properties.
 */
model RoutePolicyProperties {
  ...AnnotationResource;

  /**
   * Default action that needs to be applied when no condition is matched. Example: Permit | Deny.
   */
  defaultAction?: CommunityActionTypes = CommunityActionTypes.Deny;

  /**
   * Route Policy statements.
   */
  @OpenAPI.extension("x-ms-identifiers", ["sequenceNumber"])
  statements: RoutePolicyStatementProperties[];

  /**
   * Arm Resource ID of Network Fabric.
   */
  networkFabricId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  /**
   * AddressFamilyType. This parameter decides whether the given ipv4 or ipv6 route policy.
   */
  addressFamilyType?: AddressFamilyType = AddressFamilyType.IPv4;

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
 * Route Policy patchable properties.
 */
@withoutDefaultValues
model RoutePolicyPatchableProperties {
  /**
   * Default action that needs to be applied when no condition is matched. Example: Permit | Deny.
   */
  defaultAction?: CommunityActionTypes;

  /**
   * Route Policy statements.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  statements?: RoutePolicyStatementPatchProperties[];
}

/**
 * Route Policy Statement properties.
 */
model RoutePolicyStatementProperties {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...AnnotationResource;

  /**
   * Sequence to insert to/delete from existing route.
   */
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber: int64;

  /**
   * Route policy condition properties.
   */
  condition: StatementConditionProperties;

  /**
   * Route policy action properties.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  action: StatementActionProperties;
}

/**
 * Route Policy Statement properties.
 */
model RoutePolicyStatementPatchProperties {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...AnnotationResource;

  /**
   * Sequence to insert to/delete from existing route.
   */
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber: int64;

  /**
   * Route policy condition properties.
   */
  condition: StatementConditionPatchProperties;

  /**
   * Route policy action properties.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  action: StatementActionPatchProperties;
}

/**
 * Route policy statement condition properties.
 */
model StatementConditionProperties {
  @doc("List of IP Community resource IDs.")
  ipCommunityIds?: string[];

  @doc("List of IP Extended Community resource IDs.")
  ipExtendedCommunityIds?: string[];

  /**
   * Type of the condition used.
   */
  type?: RoutePolicyConditionType = RoutePolicyConditionType.Or;

  /**
   * Arm Resource Id of IpPrefix.
   */
  ipPrefixId?: string;
}

/**
 * Route policy statement condition properties.
 */
model StatementConditionPatchProperties {
  @doc("List of IP Community resource IDs.")
  ipCommunityIds?: string[];

  @doc("List of IP Extended Community resource IDs.")
  ipExtendedCommunityIds?: string[];

  /**
   * Type of the condition used.
   */
  type?: RoutePolicyConditionType;

  /**
   * Arm Resource Id of IpPrefix.
   */
  ipPrefixId?: string;
}

/**
 * IP Community ID list properties.
 */
model IpCommunityIdList {
  /**
   * List of IP Community resource IDs.
   */
  ipCommunityIds?: string[];
}

/**
 * IP Extended Community Id list properties.
 */
model IpExtendedCommunityIdList {
  /**
   * List of IP Extended Community resource IDs.
   */
  ipExtendedCommunityIds?: string[];
}

/**
 * Route policy action properties.
 */
model StatementActionProperties {
  /**
   * Local Preference of the route policy.
   */
  @maxValue(4294967295)
  @minValue(0)
  localPreference?: int64;

  /**
   * Action type. Example: Permit | Deny | Continue.
   */
  actionType: RoutePolicyActionType;

  /**
   * IP Community Properties.
   */
  ipCommunityProperties?: ActionIpCommunityProperties;

  /**
   * IP Extended Community Properties.
   */
  ipExtendedCommunityProperties?: ActionIpExtendedCommunityProperties;
}

@doc("Route policy action properties")
model StatementActionPatchProperties {
  /**
   * Local Preference of the route policy.
   */
  @maxValue(4294967295)
  @minValue(0)
  localPreference?: int64;

  /**
   * Action type. Example: Permit | Deny | Continue.
   */
  actionType: RoutePolicyActionType;

  /**
   * IP Community Properties.
   */
  ipCommunityProperties?: ActionIpCommunityPatchProperties;

  /**
   * IP Extended Community Properties.
   */
  ipExtendedCommunityProperties?: ActionIpExtendedCommunityPatchProperties;
}

/**
 * IP Community Properties.
 */
model ActionIpCommunityProperties {
  /**
   * List of IP Community IDs.
   */
  add?: IpCommunityIdList;

  /**
   * List of IP Community IDs.
   */
  delete?: IpCommunityIdList;

  /**
   * List of IP Community IDs.
   */
  set?: IpCommunityIdList;
}

@doc("IP Community Properties.")
model ActionIpCommunityPatchProperties is ActionIpCommunityProperties;

/**
 * IP Extended Community Properties.
 */
model ActionIpExtendedCommunityProperties {
  /**
   * List of IP Extended Community IDs.
   */
  add?: IpExtendedCommunityIdList;

  /**
   * List of IP Extended Community IDs.
   */
  delete?: IpExtendedCommunityIdList;

  /**
   * List of IP Extended Community IDs.
   */
  set?: IpExtendedCommunityIdList;
}

@doc("IP Extended Community Properties.")
model ActionIpExtendedCommunityPatchProperties
  is ActionIpExtendedCommunityProperties;

/**
 * The Route Policy patch resource definition.
 */
model RoutePolicyPatch {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...TagsUpdate;

  /**
   * The RoutePolicy patchable properties.
   */
  properties?: RoutePolicyPatchableProperties;
}

/**
 * The extended location.
 */
model ExtendedLocation {
  /**
   * The extended location type.
   */
  type?: string;

  /**
   * The extended location name.
   */
  name?: string;
}

/**
 * Type of the condition used.
 */
union RoutePolicyConditionType {
  @doc("RoutePolicyConditionType-Or")
  Or: "Or",

  @doc("RoutePolicyConditionType-And")
  And: "And",

  string,
}

/**
 * Action type. Example: Permit | Deny | Continue.
 */
union RoutePolicyActionType {
  @doc("RoutePolicyActionType-Permit")
  Permit: "Permit",

  @doc("RoutePolicyActionType-Deny")
  Deny: "Deny",

  @doc("RoutePolicyActionType-Continue")
  Continue: "Continue",

  string,
}

/**
 * Polling type.
 */
union PollingType {
  @doc("PollingType-Pull")
  Pull: "Pull",

  @doc("PollingType-Push")
  Push: "Push",

  string,
}
