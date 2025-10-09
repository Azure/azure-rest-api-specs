import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models/base.tsp";
import "./models/common/aliases.tsp";
import "./models/instance.tsp";
import "./models/broker/brokers.tsp";
import "./models/broker/authentications.tsp";
import "./models/broker/authorizations.tsp";
import "./models/broker/listeners.tsp";
import "./models/dataflows/dataflowEndpoints.tsp";
import "./models/dataflows/dataflowProfiles.tsp";
import "./models/dataflows/dataflows.tsp";
import "./models/dataflows/dataflowGraphs.tsp";
import "./models/registryEndpoints/registryEndpoint.tsp";
import "./models/akri/connectorTemplate.tsp";
import "./models/akri/connector.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@armProviderNamespace
@service(#{ title: "Microsoft.IoTOperations management service." })
@doc("Microsoft.IoTOperations Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.IoTOperations;

/** Api versions */
enum Versions {
  /** 2024-11-01 version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-11-01`,

  /** 2025-04-01 version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2025-04-01`,

  /** 2025-07-01-preview */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2025-07-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

// /instances resource Operations
@armResourceOperations
interface Instance {
  get is ArmResourceRead<InstanceResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<InstanceResource>;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<InstanceResource, InstancePatchModel>;
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
interface DataflowProfile {
  get is ArmResourceRead<DataflowProfileResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataflowProfileResource>;
  delete is ArmResourceDeleteWithoutOkAsync<DataflowProfileResource>;
  listByResourceGroup is ArmResourceListByParent<DataflowProfileResource>;
}

// /instance/dataflowProfiles/dataflows resource Operations
@armResourceOperations
interface Dataflow {
  get is ArmResourceRead<DataflowResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataflowResource>;
  delete is ArmResourceDeleteWithoutOkAsync<DataflowResource>;
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Dataflow_ListByProfileResource")
  listByResourceGroup is ArmResourceListByParent<DataflowResource>;
}

// /instance/dataflowEndpoints resource Operations
@armResourceOperations
interface DataflowEndpoint {
  get is ArmResourceRead<DataflowEndpointResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataflowEndpointResource>;
  delete is ArmResourceDeleteWithoutOkAsync<DataflowEndpointResource>;
  listByResourceGroup is ArmResourceListByParent<DataflowEndpointResource>;
}

// /instance/dataflowProfiles/dataflowGraphs resource Operations

@armResourceOperations
@added(Versions.`2025-07-01-preview`)
interface DataflowGraph {
  get is ArmResourceRead<DataflowGraphResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataflowGraphResource>;
  delete is ArmResourceDeleteWithoutOkAsync<DataflowGraphResource>;
  listByDataflowProfile is ArmResourceListByParent<DataflowGraphResource>;
}

// /instance/registryEndpoints resource Operations
@armResourceOperations
@added(Versions.`2025-07-01-preview`)
interface RegistryEndpoint {
  get is ArmResourceRead<RegistryEndpointResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<RegistryEndpointResource>;
  delete is ArmResourceDeleteWithoutOkAsync<RegistryEndpointResource>;
  listByInstanceResource is ArmResourceListByParent<RegistryEndpointResource>;
}

// /instance/akriConnectorTemplates resource Operations
@armResourceOperations
@added(Versions.`2025-07-01-preview`)
interface AkriConnectorTemplate {
  get is ArmResourceRead<AkriConnectorTemplateResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AkriConnectorTemplateResource>;
  delete is ArmResourceDeleteWithoutOkAsync<AkriConnectorTemplateResource>;
  listByInstanceResource is ArmResourceListByParent<AkriConnectorTemplateResource>;
}

// /instance/akriConnectorTemplates/connectors resource Operations
@armResourceOperations
@added(Versions.`2025-07-01-preview`)
interface AkriConnector {
  get is ArmResourceRead<AkriConnectorResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AkriConnectorResource>;
  delete is ArmResourceDeleteWithoutOkAsync<AkriConnectorResource>;
  listByTemplate is ArmResourceListByParent<AkriConnectorResource>;
}
