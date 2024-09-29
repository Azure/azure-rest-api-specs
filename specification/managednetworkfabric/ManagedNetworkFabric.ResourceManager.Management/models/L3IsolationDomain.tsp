import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

/**
 * L3 Isolation Domain Properties defines the properties of the resource.
 */
model L3IsolationDomainProperties {
  ...AnnotationResource;

  /**
   * Advertise Connected Subnets. Ex: "True" | "False".
   */
  redistributeConnectedSubnets?: RedistributeConnectedSubnets = RedistributeConnectedSubnets.True;

  /**
   * Advertise Static Routes. Ex: "True" | "False".
   */
  redistributeStaticRoutes?: RedistributeStaticRoutes = RedistributeStaticRoutes.False;

  /**
   * Aggregate route configurations.
   */
  aggregateRouteConfiguration?: AggregateRouteConfiguration;

  /**
   * Connected Subnet RoutePolicy
   */
  connectedSubnetRoutePolicy?: ConnectedSubnetRoutePolicy;

  /**
   * ARM Resource ID of the Network Fabric.
   */
  @visibility("read", "create")
  networkFabricId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

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
 * List of IPv4 and IPv6 aggregate routes.
 */
model AggregateRouteConfiguration {
  /**
   * List of IPv4 Route prefixes.
   */
  @OpenAPI.extension("x-ms-identifiers", ["prefix"])
  @minItems(1)
  ipv4Routes?: AggregateRoute[];

  /**
   * List of Ipv6Routes prefixes.
   */
  @OpenAPI.extension("x-ms-identifiers", ["prefix"])
  @minItems(1)
  ipv6Routes?: AggregateRoute[];
}

/**
 * List of IPv4 and IPv6 aggregate routes.
 */
model AggregateRoutePatchConfiguration {
  /**
   * List of IPv4 Route prefixes.
   */
  @OpenAPI.extension("x-ms-identifiers", ["prefix"])
  @minItems(1)
  ipv4Routes?: AggregateRoute[];

  /**
   * List of Ipv6Routes prefixes.
   */
  @OpenAPI.extension("x-ms-identifiers", ["prefix"])
  @minItems(1)
  ipv6Routes?: AggregateRoute[];
}

/**
 * aggregateIpv4Route model.
 */
model AggregateRoute {
  /**
   * IPv4 Prefix of the aggregate Ipv4Route.
   */
  @minLength(1)
  prefix: string;
}

@doc("Aggregate Route Patch Model.")
model AggregateRoutePatch is AggregateRoute;
/**
 * Connected Subnet Route Policy properties.
 */
model ConnectedSubnetRoutePolicy {
  /**
   * ARM Resource ID of the Route Policy. This is used for the backward compatibility.
   */
  exportRoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * Array of ARM Resource ID of the RoutePolicies.
   */
  exportRoutePolicy?: L3ExportRoutePolicy;
}

@doc("Connected Subnet Route Policy properties.")
model ConnectedSubnetRoutePolicyPatch {
  /**
   * ARM Resource ID of the Route Policy. This is used for the backward compatibility.
   */
  exportRoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * Array of ARM Resource ID of the RoutePolicies.
   */
  exportRoutePolicy?: L3ExportRoutePolicyPatch;
}

/**
 * Array of ARM Resource ID of the RoutePolicies.
 */
model L3ExportRoutePolicy {
  /**
   * ARM Resource ID of the RoutePolicy.
   */
  exportIpv4RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * ARM Resource ID of the RoutePolicy.
   */
  exportIpv6RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

@doc("Array of ARM Resource ID of the RoutePolicies.")
model L3ExportRoutePolicyPatch is L3ExportRoutePolicy;

/**
 * The L3 Isolation Domain patch resource definition.
 */
model L3IsolationDomainPatch {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...TagsUpdate;

  /**
   * Resource properties.
   */
  properties?: L3IsolationDomainPatchProperties;
}

/**
 * Resource properties.
 */
model L3IsolationDomainPatchProperties {
  ...AnnotationResource;

  /**
   * Advertise Connected Subnets. Ex: "True" | "False".
   */
  redistributeConnectedSubnets?: RedistributeConnectedSubnets;

  /**
   * Advertise Static Routes. Ex: "True" | "False".
   */
  redistributeStaticRoutes?: RedistributeStaticRoutes;

  /**
   * Aggregate route configurations.
   */
  aggregateRouteConfiguration?: AggregateRouteConfiguration;

  /**
   * Connected Subnet RoutePolicy
   */
  connectedSubnetRoutePolicy?: ConnectedSubnetRoutePolicy;
}

/**
 * Advertise Connected Subnets. Ex: "True" | "False".
 */
union RedistributeConnectedSubnets {
  @doc("RedistributeConnectedSubnets-True")
  True: "True",

  @doc("RedistributeConnectedSubnets-False")
  False: "False",

  string,
}

/**
 * Advertise Static Routes. Ex: "True" | "False".
 */
union RedistributeStaticRoutes {
  @doc("RedistributeStaticRoutes-True")
  True: "True",

  @doc("RedistributeStaticRoutes-False")
  False: "False",

  string,
}
