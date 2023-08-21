import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-resource-manager";

import "./base.tsp";
import "./e4k.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.AlicespringsDataplane;

/**
 * E4K mqttbridgeconnector resource type model details.
 *
 * Azure Resource - e4k/mqttbridgeconnector
 * CRD - mqttbridgeconnector
 * CRD Version - v1alpha2
 */
@doc("E4K mqttBridgeConnector resource")
@parentResource(E4kResource)
model MqttBridgeConnectorResource
  is TrackedResource<MqttBridgeConnectorProperties> {
  @doc("Name of E4K mqttBridgeConnector resource")
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

  @doc("TLS details for Remote broker Connection.")
  tls: MqttBridgeRemoteBrokerConnectionTls;
}

// GENERATION FIX TEMP - add "minProperties": 1 and "maxProperties": 1 to this property after creation.
@doc("MqttBridge RemoteBrokerConnection Authentication methods. NOTE - Enum only one is allowed to be passed.")
model MqttBridgeRemoteBrokerAuthenticationMethods {
  @doc("Basic remote broker authentication method.")
  basic?: LocalBrokerBasicAuthentication;

  @doc("X509 remote broker authentication method.")
  x509?: MqttBridgeRemoteBrokerX509Authentication;
}

@doc("MqttBridge RemoteBroker X509 Authentication properties.")
model MqttBridgeRemoteBrokerX509Authentication {
  @doc("Client Certificate.")
  clientCertificate?: string = "";

  @doc("Client Extra Certificates.")
  clientExtraCertificates?: string = "";

  @doc("K8s secret name containing certificate.")
  clientK8sSecret: string;

  @doc("K8s secret name client key.")
  clientKey?: string = "";

  @doc("K8s secret mounted path.")
  secretPath?: string = "";
}

@doc("MqttBridge RemoteBrokerConnection TLS details")
model MqttBridgeRemoteBrokerConnectionTls {
  @doc("Tls Enabled on Remote Broker Connection.")
  tlsEnabled: boolean;

  @doc("Trusted CA certificate for Remote Broker.")
  trustedCaCertificate?: string;

  @doc("Trusted CA certificate name for Remote Broker.")
  trustedCaCertificateName?: string;
}

/** ******************* */
/**
 * E4K mqttbridgeconnector/topicmap resource type model details.
 *
 * Azure Resource - e4k/mqttbridgeconnector/topicmap
 * CRD - mqttbridgetopicmap
 * CRD Version - v1alpha2
 */
@doc("E4K mqttBridgeTopicMap resource")
@parentResource(MqttBridgeConnectorResource)
model MqttBridgeTopicMapResource
  is TrackedResource<MqttBridgeTopicMapProperties> {
  @doc("Name of E4K mqttBridgeTopicMap resource")
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
enum MqttBridgeRouteDirection {
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
