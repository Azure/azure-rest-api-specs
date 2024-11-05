import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models/base.tsp";
import "./models/auth.tsp";
import "./models/instance.tsp";
import "./models/broker/brokers.tsp";
import "./models/broker/authentications.tsp";
import "./models/broker/authorizations.tsp";
import "./models/broker/listeners.tsp";
import "./models/dataflows/dataflowEndpoints.tsp";
import "./models/dataflows/dataflowProfiles.tsp";
import "./models/dataflows/dataflows.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@armProviderNamespace
@service({
  title: "Microsoft.IoTOperations management service.",
})
@doc("Microsoft.IoTOperations Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.IoTOperations;

/** Api versions */
enum Versions {
  /** 2024-07-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-07-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

// /instances resource Operations
@armResourceOperations
interface Instance {
  get is ArmResourceRead<InstanceResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<InstanceResource>;
  update is ArmTagsPatchSync<InstanceResource>;
  delete is ArmResourceDeleteWithoutOkAsync<InstanceResource>;
  listByResourceGroup is ArmResourceListByParent<InstanceResource>;
  listBySubscription is ArmListBySubscription<InstanceResource>;
}

// /instances/brokers resource Operations
@armResourceOperations
interface Broker {
  get is ArmResourceRead<BrokerResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BrokerResource>;
  delete is ArmResourceDeleteWithoutOkAsync<BrokerResource>;
  listByResourceGroup is ArmResourceListByParent<BrokerResource>;
}

// /instances/brokers/listeners resource Operations
@armResourceOperations
interface BrokerListener {
  get is ArmResourceRead<BrokerListenerResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BrokerListenerResource>;
  delete is ArmResourceDeleteWithoutOkAsync<BrokerListenerResource>;
  listByResourceGroup is ArmResourceListByParent<BrokerListenerResource>;
}

// /instances/brokers/authentications resource Operations
@armResourceOperations
interface BrokerAuthentication {
  get is ArmResourceRead<BrokerAuthenticationResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BrokerAuthenticationResource>;
  delete is ArmResourceDeleteWithoutOkAsync<BrokerAuthenticationResource>;
  listByResourceGroup is ArmResourceListByParent<BrokerAuthenticationResource>;
}

// /instances/brokers/authorizations resource Operations
@armResourceOperations
interface BrokerAuthorization {
  get is ArmResourceRead<BrokerAuthorizationResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BrokerAuthorizationResource>;
  delete is ArmResourceDeleteWithoutOkAsync<BrokerAuthorizationResource>;
  listByResourceGroup is ArmResourceListByParent<BrokerAuthorizationResource>;
}
// /instances/dataflowProfiles resource Operations
@armResourceOperations
interface DataFlowProfile {
  get is ArmResourceRead<DataFlowProfileResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataFlowProfileResource>;
  delete is ArmResourceDeleteWithoutOkAsync<DataFlowProfileResource>;
  listByResourceGroup is ArmResourceListByParent<DataFlowProfileResource>;
}

// /instance/dataflowProfiles/dataflows resource Operations
@armResourceOperations
interface DataFlow {
  get is ArmResourceRead<DataFlowResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataFlowResource>;
  delete is ArmResourceDeleteWithoutOkAsync<DataFlowResource>;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataFlow_ListByProfileResource")
  listByResourceGroup is ArmResourceListByParent<DataFlowResource>;
}

// /instance/dataflowEndpoints resource Operations
@armResourceOperations
interface DataFlowEndpoint {
  get is ArmResourceRead<DataFlowEndpointResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataFlowEndpointResource>;
  delete is ArmResourceDeleteWithoutOkAsync<DataFlowEndpointResource>;
  listByResourceGroup is ArmResourceListByParent<DataFlowEndpointResource>;
}
