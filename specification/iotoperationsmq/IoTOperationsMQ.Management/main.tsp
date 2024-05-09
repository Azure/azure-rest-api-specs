import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models/datalakeconnector.tsp";
import "./models/diagnosticservice.tsp";
import "./models/mqttbroker.tsp";
import "./models/mqttbridgeconnector.tsp";
import "./models/kafkaconnector.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@armProviderNamespace
@service({
  title: "Microsoft.IoTOperationsMQ management service",
})
@versioned(Versions)
@doc("Microsoft.IoTOperationsMQ Resource Provider management API.")
namespace Microsoft.IoTOperationsMQ;

/** Api versions */
enum Versions {
  /** 2023-10-04-preview preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2023-10-04-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

// /mq resource Operations
@armResourceOperations
interface Mq {
  get is ArmResourceRead<MqResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MqResource>;
  update is ArmResourcePatchSync<MqResource, MqProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<MqResource>;
  listByResourceGroup is ArmResourceListByParent<MqResource>;
  listBySubscription is ArmListBySubscription<MqResource>;
}

// /mq/broker resource Operations
@armResourceOperations
interface Broker {
  get is ArmResourceRead<BrokerResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BrokerResource>;
  update is ArmResourcePatchSync<BrokerResource, BrokerProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<BrokerResource>;
  listByResourceGroup is ArmResourceListByParent<BrokerResource>;
}

// /mq/broker/listener resource Operations
@armResourceOperations
interface BrokerListener {
  get is ArmResourceRead<BrokerListenerResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BrokerListenerResource>;
  update is ArmResourcePatchSync<
    BrokerListenerResource,
    BrokerListenerProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<BrokerListenerResource>;
  listByResourceGroup is ArmResourceListByParent<BrokerListenerResource>;
}

// /mq/broker/authentication resource Operations
@armResourceOperations
interface BrokerAuthentication {
  get is ArmResourceRead<BrokerAuthenticationResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BrokerAuthenticationResource>;
  update is ArmResourcePatchSync<
    BrokerAuthenticationResource,
    BrokerAuthenticationProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<BrokerAuthenticationResource>;
  listByResourceGroup is ArmResourceListByParent<BrokerAuthenticationResource>;
}

// /mq/broker/authorization resource Operations
@armResourceOperations
interface BrokerAuthorization {
  get is ArmResourceRead<BrokerAuthorizationResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BrokerAuthorizationResource>;
  update is ArmResourcePatchSync<
    BrokerAuthorizationResource,
    BrokerAuthorizationProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<BrokerAuthorizationResource>;
  listByResourceGroup is ArmResourceListByParent<BrokerAuthorizationResource>;
}

// /mq/mqttbridgeConnector resource Operations
@armResourceOperations
interface MqttBridgeConnector {
  get is ArmResourceRead<MqttBridgeConnectorResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MqttBridgeConnectorResource>;
  update is ArmResourcePatchSync<
    MqttBridgeConnectorResource,
    MqttBridgeConnectorProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<MqttBridgeConnectorResource>;
  listByResourceGroup is ArmResourceListByParent<MqttBridgeConnectorResource>;
}

// /mq/mqttbridgeConnector/topicMap resource Operations
@armResourceOperations
interface MqttBridgeTopicMap {
  get is ArmResourceRead<MqttBridgeTopicMapResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MqttBridgeTopicMapResource>;
  update is ArmResourcePatchSync<
    MqttBridgeTopicMapResource,
    MqttBridgeTopicMapProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<MqttBridgeTopicMapResource>;
  listByResourceGroup is ArmResourceListByParent<MqttBridgeTopicMapResource>;
}

// /mq/diagnosticService resource Operations
@armResourceOperations
interface DiagnosticService {
  get is ArmResourceRead<DiagnosticServiceResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DiagnosticServiceResource>;
  update is ArmResourcePatchSync<
    DiagnosticServiceResource,
    DiagnosticServiceProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DiagnosticServiceResource>;
  listByResourceGroup is ArmResourceListByParent<DiagnosticServiceResource>;
}

// /mq/datalakeConnector resource Operations
@armResourceOperations
interface DataLakeConnector {
  get is ArmResourceRead<DataLakeConnectorResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataLakeConnectorResource>;
  update is ArmResourcePatchSync<
    DataLakeConnectorResource,
    DataLakeConnectorProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DataLakeConnectorResource>;
  listByResourceGroup is ArmResourceListByParent<DataLakeConnectorResource>;
}

// /mq/dataLakeconnector/topicMap resource Operations
@armResourceOperations
interface DataLakeConnectorTopicMap {
  get is ArmResourceRead<DataLakeTopicMapResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataLakeTopicMapResource>;
  update is ArmResourcePatchSync<
    DataLakeTopicMapResource,
    DataLakeConnectorTopicMapProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DataLakeTopicMapResource>;
  listByResourceGroup is ArmResourceListByParent<DataLakeTopicMapResource>;
}

// /mq/kafkaConnector resource Operations
@armResourceOperations
interface KafkaConnector {
  get is ArmResourceRead<KafkaConnectorResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<KafkaConnectorResource>;
  update is ArmResourcePatchSync<
    KafkaConnectorResource,
    KafkaConnectorProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<KafkaConnectorResource>;
  listByResourceGroup is ArmResourceListByParent<KafkaConnectorResource>;
}

// /mq/kafkaConnector/topicMap resource Operations
@armResourceOperations
interface KafkaConnectorTopicMap {
  get is ArmResourceRead<KafkaTopicMapResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<KafkaTopicMapResource>;
  update is ArmResourcePatchSync<
    KafkaTopicMapResource,
    KafkaTopicMapProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<KafkaTopicMapResource>;
  listByResourceGroup is ArmResourceListByParent<KafkaTopicMapResource>;
}
