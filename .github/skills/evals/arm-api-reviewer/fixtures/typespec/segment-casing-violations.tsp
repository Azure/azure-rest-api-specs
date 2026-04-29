// TypeSpec fixture: @segment casing violations (TSP-SEGMENT-CASE)
// Seeded violations:
//   - @segment("connectorgateways") should be camelCase: "connectorGateways"
//   - @segment("virtualnetworks") should be camelCase: "virtualNetworks"
//   - PATCH operation named "patch" instead of "update" (TSP-PATCH-NAME)
//   - @operationId override used instead of restructuring interface
//   - enum used instead of union (no-enum)
//   - Missing doc comments on union members

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Connector Gateway Service",
})
@versioned(Versions)
namespace Microsoft.ConnectorGateway;

/** API versions */
enum Versions {
  /** 2025-01-01 version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_01_01: "2025-01-01",
}

// Violation: @segment uses all-lowercase instead of camelCase (TSP-SEGMENT-CASE)
@segment("connectorgateways")
model ConnectorGateway is TrackedResource<ConnectorGatewayProperties> {
  @key("connectorGatewayName")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

/** Properties of a connector gateway. */
model ConnectorGatewayProperties {
  /** The display name of the gateway. */
  displayName?: string;

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  // Violation: using enum instead of union (no-enum rule)
  /** The status of the gateway. */
  status?: GatewayStatus;
}

// Violation: should use union, not enum, for extensible Azure enums
enum GatewayStatus {
  Active,
  Inactive,
  Degraded,
}

// Violation: @segment uses all-lowercase instead of camelCase (TSP-SEGMENT-CASE)
@parentResource(ConnectorGateway)
@segment("virtualnetworks")
model VirtualNetwork is ProxyResource<VirtualNetworkProperties> {
  @key("virtualNetworkName")
  name: string;
}

/** Properties of a virtual network connection. */
model VirtualNetworkProperties {
  /** The resource ID of the target virtual network. */
  // Violation: using plain string instead of armResourceIdentifier (TSP-ARM-RESOURCE-ID)
  targetVnetId?: string;
}

@armResourceOperations
interface ConnectorGateways {
  get is ArmResourceRead<ConnectorGateway>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ConnectorGateway>;
  // Violation: PATCH named "patch" instead of "update" (TSP-PATCH-NAME)
  patch is ArmResourcePatchAsync<ConnectorGateway, ConnectorGatewayProperties>;
  delete is ArmResourceDeleteAsync<ConnectorGateway>;
  listByResourceGroup is ArmResourceListByParent<ConnectorGateway>;
  listBySubscription is ArmListBySubscription<ConnectorGateway>;
}

@armResourceOperations
interface VirtualNetworks {
  get is ArmResourceRead<VirtualNetwork>;
  // Violation: @operationId override instead of restructuring interface
  @operationId("VNetConnections_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VirtualNetwork>;
  listByParent is ArmResourceListByParent<VirtualNetwork>;
}

interface Operations extends Azure.ResourceManager.Operations {}
