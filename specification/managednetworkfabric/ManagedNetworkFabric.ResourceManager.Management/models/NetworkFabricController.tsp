import "./common.tsp";

using TypeSpec.Versioning;
using TypeSpec.Reflection;

namespace Microsoft.ManagedNetworkFabric;

@doc("NetworkFabricControllerProperties defines the resource properties.")
model NetworkFabricControllerProperties {
  ...AnnotationResource;

  @doc("As part of an update, the Infrastructure ExpressRoute CircuitID should be provided to create and Provision a NFC. This Express route is dedicated for Infrastructure services. (This is a Mandatory attribute)")
  @Azure.ResourceManager.identifiers(#["expressRouteCircuitId"])
  infrastructureExpressRouteConnections?: ExpressRouteConnectionInformation[];

  @doc("As part of an update, the workload ExpressRoute CircuitID should be provided to create and Provision a NFC. This Express route is dedicated for Workload services. (This is a Mandatory attribute).")
  @Azure.ResourceManager.identifiers(#["expressRouteCircuitId"])
  workloadExpressRouteConnections?: ExpressRouteConnectionInformation[];

  @doc("InfrastructureServices IP ranges.")
  @visibility(Lifecycle.Read)
  infrastructureServices?: ControllerServices;

  @doc("WorkloadServices IP ranges.")
  @visibility(Lifecycle.Read)
  workloadServices?: ControllerServices;

  @doc("Managed Resource Group configuration properties.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @doc("The NF-ID will be an input parameter used by the NF to link and get associated with the parent NFC Service.")
  @visibility(Lifecycle.Read)
  networkFabricIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>[];

  @doc("A workload management network is required for all the tenant (workload) traffic. This traffic is only dedicated for Tenant workloads which are required to access internet or any other MSFT/Public endpoints. This is used for the backward compatibility.")
  @visibility(Lifecycle.Read)
  @removed(Versions.v2024_06_15_preview)
  workloadManagementNetwork?: boolean = true;

  @doc("A workload management network is required for all the tenant (workload) traffic. This traffic is only dedicated for Tenant workloads which are required to access internet or any other MSFT/Public endpoints.")
  isWorkloadManagementNetworkEnabled?: IsWorkloadManagementNetworkEnabled = IsWorkloadManagementNetworkEnabled.True;

  @doc("List of tenant InternetGateway resource IDs")
  @visibility(Lifecycle.Read)
  tenantInternetGatewayIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/internetGateways";
    }
  ]>[];

  @doc("IPv4 Network Fabric Controller Address Space.")
  @minLength(1)
  ipv4AddressSpace?: string = "10.0.0.0/19";

  @doc("IPv6 Network Fabric Controller Address Space.")
  @minLength(1)
  ipv6AddressSpace?: string = "FC00::/59";

  @doc("Network Fabric Controller SKU.")
  nfcSku?: NfcSku = NfcSku.Standard;

  @doc("Details of the last operation performed on the resource")
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_06_15_preview)
  lastOperation?: LastOperationProperties;

  @doc("Provides you the latest status of the NFC service, whether it is Accepted, updating, Succeeded or Failed. During this process, the states keep changing based on the status of NFC provisioning.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Network Fabric Controller services.")
model ControllerServices {
  @doc("The IPv4 Address space is optional, if the value is not defined at the time of NFC creation, then the default value 10.0.0.0/19 is considered. The IPV4 address subnet is an optional attribute.")
  ipv4AddressSpaces?: string[];

  @doc("The IPv6 is not supported right now.")
  ipv6AddressSpaces?: string[];
}

@doc("Managed Resource Group configuration properties.")
model ManagedResourceGroupConfiguration {
  @doc("The NFC service will be hosted in a Managed resource group.")
  name?: string;

  @doc("Managed resource group location.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

@doc("The ExpressRoute circuit ID and the Auth Key are required for you to successfully deploy NFC service.")
model ExpressRouteConnectionInformation {
  @doc("The express route circuit Azure resource ID, must be of type Microsoft.Network/expressRouteCircuits/circuitName. The ExpressRoute Circuit is a mandatory attribute.")
  expressRouteCircuitId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/expressRouteCircuits";
    }
  ]>;

  @doc("Authorization key for the circuit, must be of type Microsoft.Network/expressRouteCircuits/authorizations. The Auth Key is a mandatory attribute.")
  @secret
  expressRouteAuthorizationKey: string;
}

@doc("The Network Fabric Controller Patch payload definition.")
model NetworkFabricControllerPatch {
  ...TagsUpdate;

  @doc("Network Fabric Controller patch properties.")
  properties?: NetworkFabricControllerPatchProperties;
}

@doc("Network Fabric Controller patch properties.")
model NetworkFabricControllerPatchProperties {
  @doc("As part of an update, the Infrastructure ExpressRoute CircuitID should be provided to create and Provision a NFC. This Express route is dedicated for Infrastructure services. (This is a Mandatory attribute)")
  @Azure.ResourceManager.identifiers(#["expressRouteCircuitId"])
  infrastructureExpressRouteConnections?: ExpressRouteConnectionInformation[];

  @doc("As part of an update, the workload ExpressRoute CircuitID should be provided to create and Provision a NFC. This Express route is dedicated for Workload services. (This is a Mandatory attribute).")
  @Azure.ResourceManager.identifiers(#["expressRouteCircuitId"])
  workloadExpressRouteConnections?: ExpressRouteConnectionInformation[];
}

@doc("A workload management network is required for all the tenant (workload) traffic. This traffic is only dedicated for Tenant workloads which are required to access internet or any other MSFT/Public endpoints.")
union IsWorkloadManagementNetworkEnabled {
  @doc("IsWorkloadManagementNetworkEnabled-True")
  True: "True",

  @doc("IsWorkloadManagementNetworkEnabled-False")
  False: "False",

  string,
}

@doc("Network Fabric Controller SKU.")
union NfcSku {
  @doc("NfcSku-Basic")
  Basic: "Basic",

  @doc("NfcSku-Standard")
  Standard: "Standard",

  @doc("NfcSku-HighPerformance")
  HighPerformance: "HighPerformance",

  string,
}
