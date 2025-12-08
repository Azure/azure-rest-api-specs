import "./common.tsp";
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

@doc("RoutePolicyProperties defines the resource properties.")
model RoutePolicyProperties {
  ...AnnotationResource;

  @doc("Default action that needs to be applied when no condition is matched. Example: Permit | Deny.")
  defaultAction?: CommunityActionTypes = CommunityActionTypes.Deny;

  @doc("Route Policy statements.")
  @Azure.ResourceManager.identifiers(#["sequenceNumber"])
  statements: RoutePolicyStatementProperties[];

  @doc("Arm Resource ID of Network Fabric.")
  networkFabricId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("AddressFamilyType. This parameter decides whether the given ipv4 or ipv6 route policy.")
  addressFamilyType?: AddressFamilyType = AddressFamilyType.IPv4;

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

@doc("Route Policy patchable properties.")
@withoutDefaultValues
model RoutePolicyPatchableProperties {
  @doc("Default action that needs to be applied when no condition is matched. Example: Permit | Deny.")
  defaultAction?: CommunityActionTypes;

  @doc("Route Policy statements.")
  @Azure.ResourceManager.identifiers(#[])
  statements?: RoutePolicyStatementPatchProperties[];
}

@doc("Route Policy Statement properties.")
model RoutePolicyStatementProperties {
  ...AnnotationResource;

  @doc("Sequence to insert to/delete from existing route.")
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber: int64;

  @doc("Route policy condition properties.")
  condition: StatementConditionProperties;

  @doc("Route policy action properties.")
  action: StatementActionProperties;
}

@doc("Route Policy Statement properties.")
model RoutePolicyStatementPatchProperties {
  ...AnnotationResource;

  @doc("Sequence to insert to/delete from existing route.")
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber: int64;

  @doc("Route policy condition properties.")
  condition: StatementConditionPatchProperties;

  @doc("Route policy action properties.")
  action: StatementActionPatchProperties;
}

@doc("Route policy statement condition properties.")
model StatementConditionProperties {
  @doc("List of IP Community resource IDs.")
  ipCommunityIds?: string[];

  @doc("List of IP Extended Community resource IDs.")
  ipExtendedCommunityIds?: string[];

  @doc("Type of the condition used.")
  type?: RoutePolicyConditionType = RoutePolicyConditionType.Or;

  @doc("Arm Resource Id of IpPrefix.")
  ipPrefixId?: string;
}

@doc("Route policy statement condition properties.")
model StatementConditionPatchProperties {
  @doc("List of IP Community resource IDs.")
  ipCommunityIds?: string[];

  @doc("List of IP Extended Community resource IDs.")
  ipExtendedCommunityIds?: string[];

  @doc("Type of the condition used.")
  type?: RoutePolicyConditionType;

  @doc("Arm Resource Id of IpPrefix.")
  ipPrefixId?: string;
}

@doc("IP Community ID list properties.")
model IpCommunityIdList {
  @doc("List of IP Community resource IDs.")
  ipCommunityIds?: string[];
}

@doc("IP Extended Community Id list properties.")
model IpExtendedCommunityIdList {
  @doc("List of IP Extended Community resource IDs.")
  ipExtendedCommunityIds?: string[];
}

@doc("Route policy action properties.")
model StatementActionProperties {
  @doc("Local Preference of the route policy.")
  @maxValue(4294967295)
  @minValue(0)
  localPreference?: int64;

  @doc("Action type. Example: Permit | Deny | Continue.")
  actionType: RoutePolicyActionType;

  @doc("IP Community Properties.")
  ipCommunityProperties?: ActionIpCommunityProperties;

  @doc("IP Extended Community Properties.")
  ipExtendedCommunityProperties?: ActionIpExtendedCommunityProperties;
}

@doc("Route policy action properties")
model StatementActionPatchProperties {
  @doc("Local Preference of the route policy.")
  @maxValue(4294967295)
  @minValue(0)
  localPreference?: int64;

  @doc("Action type. Example: Permit | Deny | Continue.")
  actionType: RoutePolicyActionType;

  @doc("IP Community Properties.")
  ipCommunityProperties?: ActionIpCommunityPatchProperties;

  @doc("IP Extended Community Properties.")
  ipExtendedCommunityProperties?: ActionIpExtendedCommunityPatchProperties;
}

@doc("IP Community Properties.")
model ActionIpCommunityProperties {
  @doc("List of IP Community IDs.")
  add?: IpCommunityIdList;

  @doc("List of IP Community IDs.")
  delete?: IpCommunityIdList;

  @doc("List of IP Community IDs.")
  set?: IpCommunityIdList;
}

@doc("IP Community Properties.")
model ActionIpCommunityPatchProperties is ActionIpCommunityProperties;

@doc("IP Extended Community Properties.")
model ActionIpExtendedCommunityProperties {
  @doc("List of IP Extended Community IDs.")
  add?: IpExtendedCommunityIdList;

  @doc("List of IP Extended Community IDs.")
  delete?: IpExtendedCommunityIdList;

  @doc("List of IP Extended Community IDs.")
  set?: IpExtendedCommunityIdList;
}

@doc("IP Extended Community Properties.")
model ActionIpExtendedCommunityPatchProperties
  is ActionIpExtendedCommunityProperties;

@doc("The Route Policy patch resource definition.")
model RoutePolicyPatch {
  ...TagsUpdate;

  @doc("The RoutePolicy patchable properties.")
  properties?: RoutePolicyPatchableProperties;
}

@doc("The extended location.")
model ExtendedLocation {
  @doc("The extended location type.")
  type?: string;

  @doc("The extended location name.")
  name?: string;
}

@doc("Type of the condition used.")
union RoutePolicyConditionType {
  @doc("RoutePolicyConditionType-Or")
  Or: "Or",

  @doc("RoutePolicyConditionType-And")
  And: "And",

  string,
}

@doc("Action type. Example: Permit | Deny | Continue.")
union RoutePolicyActionType {
  @doc("RoutePolicyActionType-Permit")
  Permit: "Permit",

  @doc("RoutePolicyActionType-Deny")
  Deny: "Deny",

  @doc("RoutePolicyActionType-Continue")
  Continue: "Continue",

  string,
}

@doc("Polling type.")
union PollingType {
  @doc("PollingType-Pull")
  Pull: "Pull",

  @doc("PollingType-Push")
  Push: "Push",

  string,
}
