import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

/**
 * NetworkFabricControllerProperties defines the resource properties.
 */
model NetworkFabricControllerProperties {
  ...AnnotationResource;

  /**
   * As part of an update, the Infrastructure ExpressRoute CircuitID should be provided to create and Provision a NFC. This Express route is dedicated for Infrastructure services. (This is a Mandatory attribute)
   */
  @OpenAPI.extension("x-ms-identifiers", ["expressRouteCircuitId"])
  infrastructureExpressRouteConnections?: ExpressRouteConnectionInformation[];

  /**
   * As part of an update, the workload ExpressRoute CircuitID should be provided to create and Provision a NFC. This Express route is dedicated for Workload services. (This is a Mandatory attribute).
   */
  @OpenAPI.extension("x-ms-identifiers", ["expressRouteCircuitId"])
  workloadExpressRouteConnections?: ExpressRouteConnectionInformation[];

  /**
   * InfrastructureServices IP ranges.
   */
  @visibility("read")
  infrastructureServices?: ControllerServices;

  /**
   * WorkloadServices IP ranges.
   */
  @visibility("read")
  workloadServices?: ControllerServices;

  /**
   * Managed Resource Group configuration properties.
   */
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  /**
   * The NF-ID will be an input parameter used by the NF to link and get associated with the parent NFC Service.
   */
  @visibility("read")
  networkFabricIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>[];

  @doc("A workload management network is required for all the tenant (workload) traffic. This traffic is only dedicated for Tenant workloads which are required to access internet or any other MSFT/Public endpoints. This is used for the backward compatibility.")
  @visibility("read")
  workloadManagementNetwork?: boolean = true;

  /**
   * A workload management network is required for all the tenant (workload) traffic. This traffic is only dedicated for Tenant workloads which are required to access internet or any other MSFT/Public endpoints.
   */
  isWorkloadManagementNetworkEnabled?: IsWorkloadManagementNetworkEnabled = IsWorkloadManagementNetworkEnabled.True;

  /**
   * List of tenant InternetGateway resource IDs
   */
  @visibility("read")
  tenantInternetGatewayIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/internetGateways";
    }
  ]>[];

  /**
   * IPv4 Network Fabric Controller Address Space.
   */
  @minLength(1)
  ipv4AddressSpace?: string = "10.0.0.0/19";

  /**
   * IPv6 Network Fabric Controller Address Space.
   */
  @minLength(1)
  ipv6AddressSpace?: string = "FC00::/59";

  /**
   * Network Fabric Controller SKU.
   */
  nfcSku?: NfcSku = NfcSku.Standard;

  /**
   * Provides you the latest status of the NFC service, whether it is Accepted, updating, Succeeded or Failed. During this process, the states keep changing based on the status of NFC provisioning.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Network Fabric Controller services.
 */
model ControllerServices {
  /**
   * The IPv4 Address space is optional, if the value is not defined at the time of NFC creation, then the default value 10.0.0.0/19 is considered. The IPV4 address subnet is an optional attribute.
   */
  ipv4AddressSpaces?: string[];

  /**
   * The IPv6 is not supported right now.
   */
  ipv6AddressSpaces?: string[];
}

/**
 * Managed Resource Group configuration properties.
 */
model ManagedResourceGroupConfiguration {
  /**
   * The NFC service will be hosted in a Managed resource group.
   */
  name?: string;

  /**
   * Managed resource group location.
   */
  @visibility("read", "create")
  location?: string;
}

/**
 * The ExpressRoute circuit ID and the Auth Key are required for you to successfully deploy NFC service.
 */
model ExpressRouteConnectionInformation {
  /**
   * The express route circuit Azure resource ID, must be of type Microsoft.Network/expressRouteCircuits/circuitName. The ExpressRoute Circuit is a mandatory attribute.
   */
  expressRouteCircuitId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/expressRouteCircuits";
    }
  ]>;

  /**
   * Authorization key for the circuit, must be of type Microsoft.Network/expressRouteCircuits/authorizations. The Auth Key is a mandatory attribute.
   */
  @secret
  expressRouteAuthorizationKey: string;
}

/**
 * The Network Fabric Controller Patch payload definition.
 */
model NetworkFabricControllerPatch {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...TagsUpdate;

  /**
   * Network Fabric Controller patch properties.
   */
  properties?: NetworkFabricControllerPatchProperties;
}

/**
 * Network Fabric Controller patch properties.
 */
model NetworkFabricControllerPatchProperties {
  /**
   * As part of an update, the Infrastructure ExpressRoute CircuitID should be provided to create and Provision a NFC. This Express route is dedicated for Infrastructure services. (This is a Mandatory attribute)
   */
  @OpenAPI.extension("x-ms-identifiers", ["expressRouteCircuitId"])
  infrastructureExpressRouteConnections?: ExpressRouteConnectionInformation[];

  /**
   * As part of an update, the workload ExpressRoute CircuitID should be provided to create and Provision a NFC. This Express route is dedicated for Workload services. (This is a Mandatory attribute).
   */
  @OpenAPI.extension("x-ms-identifiers", ["expressRouteCircuitId"])
  workloadExpressRouteConnections?: ExpressRouteConnectionInformation[];
}

/**
 * A workload management network is required for all the tenant (workload) traffic. This traffic is only dedicated for Tenant workloads which are required to access internet or any other MSFT/Public endpoints.
 */
union IsWorkloadManagementNetworkEnabled {
  @doc("IsWorkloadManagementNetworkEnabled-True")
  True: "True",

  @doc("IsWorkloadManagementNetworkEnabled-False")
  False: "False",

  string,
}

/**
 * Network Fabric Controller SKU.
 */
union NfcSku {
  @doc("NfcSku-Basic")
  Basic: "Basic",

  @doc("NfcSku-Standard")
  Standard: "Standard",

  @doc("NfcSku-HighPerformance")
  HighPerformance: "HighPerformance",

  string,
}
