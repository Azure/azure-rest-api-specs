import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models/datalakeconnector.tsp";
import "./models/diagnosticservice.tsp";
import "./models/mqttbroker.tsp";
import "./models/mqttbridgeconnector.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Microsoft.AlicespringsDataplane management service",
  version: "2023-10-04-preview",
})
@doc("Microsoft.AlicespringsDataplane Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AlicespringsDataplane;

interface Operations extends Azure.ResourceManager.Operations {}

// /e4k resource Operations
@armResourceOperations
interface E4k {
  get is ArmResourceRead<E4kResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<E4kResource>;
  update is ArmResourcePatchSync<E4kResource, E4kProperties>;
  delete is ArmResourceDeleteAsync<E4kResource>;
  listByResourceGroup is ArmResourceListByParent<E4kResource>;
  listBySubscription is ArmListBySubscription<E4kResource>;
}

// /e4k/broker resource Operations
@armResourceOperations
interface Broker {
  get is ArmResourceRead<BrokerResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BrokerResource>;
  update is ArmResourcePatchSync<BrokerResource, BrokerProperties>;
  delete is ArmResourceDeleteAsync<BrokerResource>;
  listByResourceGroup is ArmResourceListByParent<BrokerResource>;
}

// /e4k/broker/listener resource Operations
@armResourceOperations
interface BrokerListener {
  get is ArmResourceRead<BrokerListenerResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BrokerListenerResource>;
  update is ArmResourcePatchSync<
    BrokerListenerResource,
    BrokerListenerProperties
  >;
  delete is ArmResourceDeleteAsync<BrokerListenerResource>;
  listByResourceGroup is ArmResourceListByParent<BrokerListenerResource>;
}

// /e4k/broker/authentication resource Operations
@armResourceOperations
interface BrokerAuthentication {
  get is ArmResourceRead<BrokerAuthenticationResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BrokerAuthenticationResource>;
  update is ArmResourcePatchSync<
    BrokerAuthenticationResource,
    BrokerAuthenticationProperties
  >;
  delete is ArmResourceDeleteAsync<BrokerAuthenticationResource>;
  listByResourceGroup is ArmResourceListByParent<BrokerAuthenticationResource>;
}

// /e4k/broker/authorization resource Operations
@armResourceOperations
interface BrokerAuthorization {
  get is ArmResourceRead<BrokerAuthorizationResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BrokerAuthorizationResource>;
  update is ArmResourcePatchSync<
    BrokerAuthorizationResource,
    BrokerAuthorizationProperties
  >;
  delete is ArmResourceDeleteAsync<BrokerAuthorizationResource>;
  listByResourceGroup is ArmResourceListByParent<BrokerAuthorizationResource>;
}

// /e4k/mqttbridgeconnector resource Operations
@armResourceOperations
interface MqttBridgeConnector {
  get is ArmResourceRead<MqttBridgeConnectorResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MqttBridgeConnectorResource>;
  update is ArmResourcePatchSync<
    MqttBridgeConnectorResource,
    MqttBridgeConnectorProperties
  >;
  delete is ArmResourceDeleteAsync<MqttBridgeConnectorResource>;
  listByResourceGroup is ArmResourceListByParent<MqttBridgeConnectorResource>;
}

// /e4k/mqttbridgeconnector/mqttbridgetopicmap resource Operations
@armResourceOperations
interface MqttBridgeTopicMap {
  get is ArmResourceRead<MqttBridgeTopicMapResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MqttBridgeTopicMapResource>;
  update is ArmResourcePatchSync<
    MqttBridgeTopicMapResource,
    MqttBridgeTopicMapProperties
  >;
  delete is ArmResourceDeleteAsync<MqttBridgeTopicMapResource>;
  listByResourceGroup is ArmResourceListByParent<MqttBridgeTopicMapResource>;
}

// /e4k/diagnosticservice resource Operations
@armResourceOperations
interface DiagnosticService {
  get is ArmResourceRead<DiagnosticServiceResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DiagnosticServiceResource>;
  update is ArmResourcePatchSync<
    DiagnosticServiceResource,
    DiagnosticServiceProperties
  >;
  delete is ArmResourceDeleteAsync<DiagnosticServiceResource>;
  listByResourceGroup is ArmResourceListByParent<DiagnosticServiceResource>;
}

// /e4k/datalakeconnector resource Operations
@armResourceOperations
interface DatalakeConnector {
  get is ArmResourceRead<DatalakeConnectorResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DatalakeConnectorResource>;
  update is ArmResourcePatchSync<
    DatalakeConnectorResource,
    DatalakeConnectorProperties
  >;
  delete is ArmResourceDeleteAsync<DatalakeConnectorResource>;
  listByResourceGroup is ArmResourceListByParent<DatalakeConnectorResource>;
}

// /e4k/datalakeconnector/topicmap resource Operations
@armResourceOperations
interface DatalakeConnectorTopicMap {
  get is ArmResourceRead<DatalakeConnectorTopicMapResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DatalakeConnectorTopicMapResource>;
  update is ArmResourcePatchSync<
    DatalakeConnectorTopicMapResource,
    DatalakeConnectorTopicMapProperties
  >;
  delete is ArmResourceDeleteAsync<DatalakeConnectorTopicMapResource>;
  listByResourceGroup is ArmResourceListByParent<DatalakeConnectorTopicMapResource>;
}
