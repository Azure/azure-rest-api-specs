import "./common.tsp";
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;

@doc("L3 Isolation Domain Properties defines the properties of the resource.")
model L3IsolationDomainProperties {
  ...AnnotationResource;

  @doc("Advertise Connected Subnets. Ex: \"True\" | \"False\".")
  redistributeConnectedSubnets?: RedistributeConnectedSubnets = RedistributeConnectedSubnets.True;

  @doc("Advertise Static Routes. Ex: \"True\" | \"False\".")
  redistributeStaticRoutes?: RedistributeStaticRoutes = RedistributeStaticRoutes.False;

  @doc("Aggregate route configurations.")
  aggregateRouteConfiguration?: AggregateRouteConfiguration;

  @doc("Connected Subnet RoutePolicy")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "connectedSubnetRoutePolicy")
  connectedSubnetRoutePolicyDeprecated?: ConnectedSubnetRoutePolicy;

  @doc("Connected Subnet RoutePolicy")
  @added(Versions.v2024_06_15_preview)
  connectedSubnetRoutePolicy?: ConnectedSubnetRoutePolicy;

  @doc("ARM Resource ID of the Network Fabric.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkFabricId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("Static Route - route policy.")
  @added(Versions.v2024_06_15_preview)
  staticRouteRoutePolicy?: StaticRouteRoutePolicy;

  @doc("Unique Route Distinguisher configuration")
  @added(Versions.v2024_06_15_preview)
  uniqueRdConfiguration?: L3UniqueRouteDistinguisherProperties;

  @doc("VRF Limit configuration.")
  @added(Versions.v2024_06_15_preview)
  @removed(Versions.v2025_07_15)
  routePrefixLimit?: RoutePrefixLimitProperties;

  @doc("IPv4 VRF Limit configuration.")
  @added(Versions.v2025_07_15)
  v4routePrefixLimit?: RoutePrefixLimitProperties;

  @doc("IPv6 VRF Limit configuration.")
  @added(Versions.v2025_07_15)
  v6routePrefixLimit?: RoutePrefixLimitProperties;

  @doc("Details of the last operation performed on the resource")
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_06_15_preview)
  lastOperation?: LastOperationProperties;

  @doc("BMP Export Policy configuration.")
  @added(Versions.v2025_07_15)
  exportPolicyConfiguration?: BmpExportPolicyProperties;

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

@doc("List of IPv4 and IPv6 aggregate routes.")
model AggregateRouteConfiguration {
  @doc("List of IPv4 Route prefixes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  @minItems(1)
  ipv4Routes?: AggregateRoute[];

  @doc("List of Ipv6Routes prefixes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  @minItems(1)
  ipv6Routes?: AggregateRoute[];
}

@doc("List of IPv4 and IPv6 aggregate routes.")
model AggregateRoutePatchConfiguration {
  @doc("List of IPv4 Route prefixes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  @minItems(1)
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "ipv4Routes")
  ipv4RoutesDeprecated?: AggregateRoute[];

  @doc("List of IPv4 Route prefixes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  @added(Versions.v2025_07_15)
  ipv4Routes?: AggregateRoute[];

  @doc("List of Ipv6Routes prefixes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  @minItems(1)
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "ipv6Routes")
  ipv6RoutesDeprecated?: AggregateRoute[];

  @doc("List of Ipv6Routes prefixes.")
  @Azure.ResourceManager.identifiers(#["prefix"])
  @added(Versions.v2025_07_15)
  ipv6Routes?: AggregateRoute[];
}

@doc("aggregateIpv4Route model.")
model AggregateRoute {
  @doc("IPv4 Prefix of the aggregate Ipv4Route.")
  @minLength(1)
  prefix: string;
}

@doc("Aggregate Route Patch Model.")
model AggregateRoutePatch is AggregateRoute;

@doc("Connected Subnet Route Policy properties.")
model ConnectedSubnetRoutePolicy {
  @doc("ARM Resource ID of the Route Policy. This is used for the backward compatibility.")
  @removed(Versions.v2024_06_15_preview)
  exportRoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("Array of ARM Resource ID of the RoutePolicies.")
  exportRoutePolicy?: L3ExportRoutePolicy;
}

@doc("Connected Subnet Route Policy properties.")
model ConnectedSubnetRoutePolicyPatch {
  @doc("ARM Resource ID of the Route Policy. This is used for the backward compatibility.")
  @removed(Versions.v2024_06_15_preview)
  exportRoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("Array of ARM Resource ID of the RoutePolicies.")
  exportRoutePolicy?: L3ExportRoutePolicyPatch;
}

@doc("Static Route - route policy properties.")
@added(Versions.v2024_06_15_preview)
model StaticRouteRoutePolicy {
  @doc("Array of ARM Resource ID of the RoutePolicies.")
  exportRoutePolicy?: L3ExportRoutePolicy;
}

@doc("Static Route - route policy properties.")
@added(Versions.v2024_06_15_preview)
model StaticRouteRoutePolicyPatch {
  @doc("Array of ARM Resource ID of the RoutePolicies.")
  exportRoutePolicy?: L3ExportRoutePolicyPatch;
}

@doc("Array of ARM Resource ID of the RoutePolicies.")
model L3ExportRoutePolicy {
  @doc("ARM Resource ID of the RoutePolicy.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "exportIpv4RoutePolicyId")
  exportIpv4RoutePolicyIdDeprecated?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("ARM Resource ID of the RoutePolicy.")
  @added(Versions.v2024_06_15_preview)
  exportIpv4RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("ARM Resource ID of the RoutePolicy.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "exportIpv6RoutePolicyId")
  exportIpv6RoutePolicyIdDeprecated?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  @doc("ARM Resource ID of the RoutePolicy.")
  @added(Versions.v2024_06_15_preview)
  exportIpv6RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

@doc("Array of ARM Resource ID of the RoutePolicies.")
model L3ExportRoutePolicyPatch is L3ExportRoutePolicy;

@doc("The L3 Isolation Domain patch resource definition.")
model L3IsolationDomainPatch {
  ...TagsUpdate;

  @doc("Resource properties.")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "properties")
  propertiesDeprecated?: L3IsolationDomainPatchProperties;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @doc("L3 Isolation Domain resource patch properties.")
  @added(Versions.v2025_07_15)
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: L3IsolationDomainPatchProperties;

  @added(Versions.v2025_07_15)
  @doc("The managed service identities assigned to this resource.")
  identity?: ManagedServiceIdentityPatch;
}

@doc("Resource properties.")
model L3IsolationDomainPatchProperties {
  ...AnnotationResource;

  @doc("Advertise Connected Subnets. Ex: \"True\" | \"False\".")
  redistributeConnectedSubnets?: RedistributeConnectedSubnets;

  @doc("Advertise Static Routes. Ex: \"True\" | \"False\".")
  redistributeStaticRoutes?: RedistributeStaticRoutes;

  @doc("Aggregate route configurations.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "aggregateRouteConfiguration")
  aggregateRouteConfigurationDeprecated?: AggregateRouteConfiguration;

  @doc("Aggregate route configurations.")
  @added(Versions.v2024_06_15_preview)
  aggregateRouteConfiguration?: AggregateRoutePatchConfiguration;

  @doc("Connected Subnet RoutePolicy")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "connectedSubnetRoutePolicy")
  connectedSubnetRoutePolicyDeprecated?: ConnectedSubnetRoutePolicy;

  @doc("Connected Subnet RoutePolicy")
  @added(Versions.v2024_06_15_preview)
  connectedSubnetRoutePolicy?: ConnectedSubnetRoutePolicyPatch;

  @doc("Static Route - route policy.")
  @added(Versions.v2024_06_15_preview)
  staticRouteRoutePolicy?: StaticRouteRoutePolicyPatch;

  @doc("Virtual Routing and Forwarding (VRF) Limit configuration.")
  @added(Versions.v2024_06_15_preview)
  @removed(Versions.v2025_07_15)
  routePrefixLimit?: RoutePrefixLimitPatchProperties;

  @doc("IPv4 VRF Limit configuration.")
  @added(Versions.v2025_07_15)
  v4routePrefixLimit?: RoutePrefixLimitPatchProperties;

  @doc("IPv6 VRF Limit configuration.")
  @added(Versions.v2025_07_15)
  v6routePrefixLimit?: RoutePrefixLimitPatchProperties;

  @doc("BMP Export Policy configuration.")
  @added(Versions.v2025_07_15)
  exportPolicyConfiguration?: BmpExportPolicyPatchProperties;
}

@doc("Advertise Connected Subnets. Ex: \"True\" | \"False\".")
union RedistributeConnectedSubnets {
  @doc("RedistributeConnectedSubnets-True")
  True: "True",

  @doc("RedistributeConnectedSubnets-False")
  False: "False",

  string,
}

@doc("Advertise Static Routes. Ex: \"True\" | \"False\".")
union RedistributeStaticRoutes {
  @doc("RedistributeStaticRoutes-True")
  True: "True",

  @doc("RedistributeStaticRoutes-False")
  False: "False",

  string,
}

@doc("Layer3 Route prefix limit configuration.")
@added(Versions.v2024_06_15_preview)
model RoutePrefixLimitProperties {
  @doc("Hard limit for the routes.")
  hardLimit?: int32;

  @doc("Threshold for the routes.")
  threshold?: int32;
}

@doc("VRP Limit patch configuration.")
@added(Versions.v2024_06_15_preview)
model RoutePrefixLimitPatchProperties is RoutePrefixLimitProperties;

@doc("Unique Route Distinguisher properties.")
@added(Versions.v2024_06_15_preview)
model L3UniqueRouteDistinguisherProperties {
  @doc("List of Unique Route Distinguisher addresses.")
  @added(Versions.v2024_06_15_preview)
  @visibility(Lifecycle.Read)
  uniqueRds?: string[];
}
