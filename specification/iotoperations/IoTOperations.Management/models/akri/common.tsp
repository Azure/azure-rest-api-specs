import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

alias AkriAioMetadata = {
    /**
   * The minimum version of AIO required for the connector.
   */
    aioMinVersion?: string;

    /**
     * The maximum version of AIO required for the connector.
     */
    aioMaxVersion?: string;
};


/**
 * ConnectorsMqttConnectionConfiguration properties
 */
//- This doesn't have the `cloudEventAttributes` property like DataflowEnpoints has
//- This doesn't have the `retain` property like DataflowEnpoints has
//- This doesn't have the `clientIdPrefix` property like DataflowEnpoints has
//- This doesn't have the `retain` property like DataflowEnpoints has
//- This doesn't have the `qos` property like DataflowEnpoints has
//- The only supported protocol is `mqtt`
//- `host` is a required property in DataflowEnpoints but optional here
@added(Versions.`2025-07-01-preview`)
model ConnectorsMqttConnectionConfiguration {
  /**
   * Authentication properties.
   */
  authentication?: ConnectorsMqttAuthentication;

  /**
   * Host of the Broker in the form of <hostname>:<port>.
   */
  host?: string;

  /**
   * The protocol to use for the connection. Currently only `mqtt` is supported.
   */
  protocol?: ConnectorsMqttProtocolType;

  /**
   * KeepAlive for connection in seconds.
   */
  @minValue(0)
  keepAliveSeconds?: int32;

  /**
   * The max number of messages to keep in flight. For subscribe, this is the receive maximum. For publish, this is the maximum number of messages to send before waiting for an ack.
   */
  @minValue(0)
  maxInflightMessages?: int32;

  /**
   * Session expiry in seconds.
   */
  @minValue(0)
  sessionExpirySeconds?: int32;

  /**
   * TLS configuration.
   */
  tls?: TlsProperties;
}

/**
 * ConnectorsMqttAuthentication properties
 */
@added(Versions.`2025-07-01-preview`)
@discriminator("method")
model ConnectorsMqttAuthentication {
  /**
   * The authentication method for the MQTT connection.
   */
  method: ConnectorsMqttAuthenticationMethod;
}

/**
 * ConnectorsMqttAuthenticationMethod properties
 */
@added(Versions.`2025-07-01-preview`)
union ConnectorsMqttAuthenticationMethod {
  string,

  /**
   * Service Account Token authentication
   */
  ServiceAccountToken,
}

/**
 * Mqtt protocol types.
 */
@added(Versions.`2025-07-01-preview`)
union ConnectorsMqttProtocolType {
  string,

  /**
   * Mqtt protocol
   */
  Mqtt,
}

/**
 * ConnectorsServiceAccountAuthentication properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorsServiceAccountAuthentication
  extends ConnectorsMqttAuthentication {
  /**
   * The authentication method for the MQTT connection.
   */
  method: ServiceAccountToken;

  /**
   * The service account token for the MQTT connection.
   */
  serviceAccountTokenSettings: ConnectorsServiceAccountTokenSettings;
}

/**
 * ConnectorsServiceAccountTokenSettings properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorsServiceAccountTokenSettings {
  /**
   * The audience for the service account token.
   */
  audience: string;
}

/**
 * Image pull policy.
 */
@added(Versions.`2025-07-01-preview`)
union ConnectorsImagePullPolicy {
  string,

  /**
   * Always pull the image.
   */
  Always,

  /**
   * IfNotPresent pull the image.
   */
  IfNotPresent,

  /**
   * Never pull the image.
   */
  Never,
}

/**
 * ConnectorsImagePullSecret properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorsImagePullSecret {
  /**
   * The name of the image pull secret.
   */
  name: string;
}