import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

import "./base.tsp";
import "./mq.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.IoTOperationsMQ;

/**
 * MQ mqttBridgeConnector resource type model details.
 *
 * Azure Resource - mq/mqttBridgeConnector
 * CRD - MqttBridgeConnector
 * CRD Version - v1alpha4
 */
@doc("MQ mqttBridgeConnector resource")
@parentResource(MqResource)
model MqttBridgeConnectorResource
  is TrackedResource<MqttBridgeConnectorProperties> {
  @doc("Name of MQ mqttBridgeConnector resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("mqttBridgeConnectorName")
  @path
  @segment("mqttBridgeConnector")
  name: string;

  ...ExtendedLocation;
}

@doc("MqttBridgeConnector Properties")
model MqttBridgeConnectorProperties {
  @doc("The number of instances to deploy for a bridge rollout.")
  @minValue(0)
  @maxValue(65535)
  bridgeInstances?: int32;

  @doc("The client id prefix of the dynamically generated client ids.")
  clientIdPrefix?: string;

  @doc("The details of MqttBridge Docker Image.")
  image: ContainerImage;

  @doc("The details for connecting with Local Broker.")
  localBrokerConnection?: LocalBrokerConnectionSpec;

  @doc("The log level of the Bridge Connector instances.")
  logLevel?: string;

  @doc("The Node Tolerations for the Bridge Connector pods.")
  nodeTolerations?: NodeTolerations;

  @doc("The protocol to use for connecting with Brokers.")
  protocol: MqttProtocol;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The details for connecting with Remote Broker.")
  remoteBrokerConnection: MqttBridgeRemoteBrokerConnectionSpec;
}

@doc("MqttBridge RemoteBrokerConnectionSpec details")
model MqttBridgeRemoteBrokerConnectionSpec {
  @doc("The remote broker authentication methods. NOTE - Enum only one method is allowed to be passed.")
  authentication: MqttBridgeRemoteBrokerAuthenticationMethods;

  @doc("The endpoint of remote broker to connect to.")
  endpoint: string;

  @doc("Protocol for remote connection.")
  protocol?: MqttBridgeRemoteBrokerProtocol = MqttBridgeRemoteBrokerProtocol.mqtt;

  @doc("TLS details for Remote broker Connection.")
  tls: MqttBridgeRemoteBrokerConnectionTls;
}

@doc("Protocol for remote connection.")
union MqttBridgeRemoteBrokerProtocol {
  string,

  @doc("MQTT protocol.")
  mqtt: "mqtt",

  @doc("MQTT over WebSocket protocol.")
  webSocket: "webSocket",
}

// GENERATION FIX TEMP - add "minProperties": 1 and "maxProperties": 1 to this property after creation.
@doc("MqttBridge RemoteBrokerConnection Authentication methods. NOTE - Enum only one is allowed to be passed.")
model MqttBridgeRemoteBrokerAuthenticationMethods {
  @doc("X509 remote broker authentication method.")
  x509?: MqttBridgeRemoteBrokerX509Authentication;

  @doc("Managed identity remote broker authentication method.")
  systemAssignedManagedIdentity?: ManagedIdentityAuthentication;
}

@doc("MqttBridge RemoteBroker X509 Authentication properties.")
model MqttBridgeRemoteBrokerX509Authentication {
  @doc("Keyvault X509 secret properties.")
  keyVault?: KeyVaultCertificateProperties;

  @doc("Secret where cert details are stored.")
  secretName?: string;
}

@doc("MqttBridge RemoteBrokerConnection TLS details")
model MqttBridgeRemoteBrokerConnectionTls {
  @doc("Tls Enabled on Remote Broker Connection.")
  tlsEnabled: boolean;

  @doc("Trusted CA certificate name for Remote Broker.")
  trustedCaCertificateConfigMap?: string;
}

/** ******************* */
/**
 * MQ mqttBridgeConnector/topicMap resource type model details.
 *
 * Azure Resource - mq/mqttBridgeConnector/topicMap
 * CRD - MqttBridgeTopicMap
 * CRD Version - v1alpha4
 */
@doc("MQ mqttBridgeTopicMap resource")
@parentResource(MqttBridgeConnectorResource)
model MqttBridgeTopicMapResource
  is TrackedResource<MqttBridgeTopicMapProperties> {
  @doc("Name of MQ mqttBridgeTopicMap resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("topicMapName")
  @path
  @segment("topicMap")
  name: string;

  ...ExtendedLocation;
}

@doc("MqttBridgeTopicMap Properties")
model MqttBridgeTopicMapProperties {
  @doc("The MqttBridgeConnector CRD it refers to.")
  mqttBridgeConnectorRef: string;

  @doc("The route details for MqttBridge connector.")
  @OpenAPI.extension("x-ms-identifiers", [])
  routes?: MqttBridgeRoutes[];

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("MqttBridgeTopicMap route properties")
model MqttBridgeRoutes {
  @doc("Direction of the route.")
  direction: MqttBridgeRouteDirection;

  @doc("Name of the route.")
  name: string;

  @doc("Qos for MQTT connection.")
  @minValue(0)
  @maxValue(2)
  qos?: int32 = 1;

  @doc("Shared subscription topic details.")
  sharedSubscription?: MqttBridgeRouteSharedSubscription;

  @doc("Source topic of the route.")
  source: string;

  @doc("Target topic of the route. Ignore if same as source")
  target?: string;
}

@doc("MqttBridgeRoute direction properties")
union MqttBridgeRouteDirection {
  string,

  @doc("Remote to Local Broker.")
  RemoteToLocal: "remote-to-local",

  @doc("Local to Remote Broker.")
  LocalToRemote: "local-to-remote",
}

@doc("MqttBridgeRoute Shared subscription properties")
model MqttBridgeRouteSharedSubscription {
  @doc("The group shared subscription minimum share number.")
  @minValue(0)
  @maxValue(255)
  groupMinimumShareNumber: int32;

  @doc("The group name for Shared subscription.")
  groupName: string;
}
