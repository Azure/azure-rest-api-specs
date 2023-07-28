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
  version: "2023-07-17-preview",
})
@doc("Microsoft.AlicespringsDataplane Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AlicespringsDataplane;

interface Operations extends Azure.ResourceManager.Operations {}

/*Temporary ArmResourceCreateOrUpdateSync until Typespec library updates*/

/** Compliant create or update template */ 
/**
 * A long-running resource CreateOrUpdate (PUT)
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" "This is a valid template"
@autoRoute
@doc("Create a {name}", TResource)
@armResourceCreateOrUpdate(TResource)
@put
op ArmResourceCreateOrUpdate2Sync<
  TResource extends Azure.ResourceManager.Foundations.ArmResource,
  TBaseParameters = Azure.ResourceManager.Foundations.BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @body
  resource: TResource,
): ArmUpdatedResponse<TResource> | ArmCreatedResponseSync<TResource> | ErrorResponse;

@doc("Arm resource update successful")
model ArmUpdatedResponse<TResource extends Azure.ResourceManager.Foundations.ArmResource> 
  is ArmResponse<TResource> {}

@doc("Arm resource create successful")
model ArmCreatedResponseSync<TResource extends Azure.ResourceManager.Foundations.ArmResource> 
  is Body<TResource>{
  ...CreatedResponse;
}



// /e4k resource Operations
@armResourceOperations
interface E4k {
  get is ArmResourceRead<E4kResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Sync<E4kResource>;
  update is ArmResourcePatchSync<E4kResource, E4kProperties>;
  delete is ArmResourceDeleteSync<E4kResource>;
  listByResourceGroup is ArmResourceListByParent<E4kResource>;
  listBySubscription is ArmListBySubscription<E4kResource>;
}

// /e4k/broker resource Operations
@armResourceOperations
interface Broker {
  get is ArmResourceRead<BrokerResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Sync<BrokerResource>;
  update is ArmResourcePatchSync<BrokerResource, BrokerProperties>;
  delete is ArmResourceDeleteSync<BrokerResource>;
  listByResourceGroup is ArmResourceListByParent<BrokerResource>;
}

// /e4k/broker/listener resource Operations
@armResourceOperations
interface BrokerListener {
  get is ArmResourceRead<BrokerListenerResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Sync<BrokerListenerResource>;
  update is ArmResourcePatchSync<
    BrokerListenerResource,
    BrokerListenerProperties
  >;
  delete is ArmResourceDeleteSync<BrokerListenerResource>;
  listByResourceGroup is ArmResourceListByParent<BrokerListenerResource>;
}

// /e4k/broker/authentication resource Operations
@armResourceOperations
interface BrokerAuthentication {
  get is ArmResourceRead<BrokerAuthenticationResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Sync<BrokerAuthenticationResource>;
  update is ArmResourcePatchSync<
    BrokerAuthenticationResource,
    BrokerAuthenticationProperties
  >;
  delete is ArmResourceDeleteSync<BrokerAuthenticationResource>;
  listByResourceGroup is ArmResourceListByParent<BrokerAuthenticationResource>;
}

// /e4k/broker/authorization resource Operations
@armResourceOperations
interface BrokerAuthorization {
  get is ArmResourceRead<BrokerAuthorizationResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Sync<BrokerAuthorizationResource>;
  update is ArmResourcePatchSync<
    BrokerAuthorizationResource,
    BrokerAuthorizationProperties
  >;
  delete is ArmResourceDeleteSync<BrokerAuthorizationResource>;
  listByResourceGroup is ArmResourceListByParent<BrokerAuthorizationResource>;
}

// /e4k/mqttbridgeconnector resource Operations
@armResourceOperations
interface MqttBridgeConnector {
  get is ArmResourceRead<MqttBridgeConnectorResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Sync<MqttBridgeConnectorResource>;
  update is ArmResourcePatchSync<
    MqttBridgeConnectorResource,
    MqttBridgeConnectorProperties
  >;
  delete is ArmResourceDeleteSync<MqttBridgeConnectorResource>;
  listByResourceGroup is ArmResourceListByParent<MqttBridgeConnectorResource>;
}

// /e4k/mqttbridgeconnector/mqttbridgetopicmap resource Operations
@armResourceOperations
interface MqttBridgeTopicMap {
  get is ArmResourceRead<MqttBridgeTopicMapResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Sync<MqttBridgeTopicMapResource>;
  update is ArmResourcePatchSync<
    MqttBridgeTopicMapResource,
    MqttBridgeTopicMapProperties
  >;
  delete is ArmResourceDeleteSync<MqttBridgeTopicMapResource>;
  listByResourceGroup is ArmResourceListByParent<MqttBridgeTopicMapResource>;
}

// /e4k/diagnosticservice resource Operations
@armResourceOperations
interface DiagnosticService {
  get is ArmResourceRead<DiagnosticServiceResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Sync<DiagnosticServiceResource>;
  update is ArmResourcePatchSync<
    DiagnosticServiceResource,
    DiagnosticServiceProperties
  >;
  delete is ArmResourceDeleteSync<DiagnosticServiceResource>;
  listByResourceGroup is ArmResourceListByParent<DiagnosticServiceResource>;
}

// /e4k/datalakeconnector resource Operations
@armResourceOperations
interface DatalakeConnector {
  get is ArmResourceRead<DatalakeConnectorResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Sync<DatalakeConnectorResource>;
  update is ArmResourcePatchSync<
    DatalakeConnectorResource,
    DatalakeConnectorProperties
  >;
  delete is ArmResourceDeleteSync<DatalakeConnectorResource>;
  listByResourceGroup is ArmResourceListByParent<DatalakeConnectorResource>;
}

// /e4k/datalakeconnector/topicmap resource Operations
@armResourceOperations
interface DatalakeConnectorTopicMap {
  get is ArmResourceRead<DatalakeConnectorTopicMapResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Sync<DatalakeConnectorTopicMapResource>;
  update is ArmResourcePatchSync<
    DatalakeConnectorTopicMapResource,
    DatalakeConnectorTopicMapProperties
  >;
  delete is ArmResourceDeleteSync<DatalakeConnectorTopicMapResource>;
  listByResourceGroup is ArmResourceListByParent<DatalakeConnectorTopicMapResource>;
}
