import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;

namespace Microsoft.IoTOperations;

alias AkriAioMetadata = {
  /** The minimum version of AIO required for the connector. */
  aioMinVersion?: string;

  /** The maximum version of AIO required for the connector. */
  aioMaxVersion?: string;
};

/** AkriConnectorsMqttConnectionConfiguration properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorsMqttConnectionConfiguration {
  /** Authentication properties. */
  authentication?: AkriConnectorsMqttAuthentication;

  /** Host of the Broker in the form of <hostname>:<port>. */
  host?: string;

  /** The protocol to use for the connection. Currently only `mqtt` is supported. */
  protocol?: AkriConnectorsMqttProtocolType;

  /** KeepAlive for connection in seconds. */
  @minValue(0)
  keepAliveSeconds?: int32;

  /** The max number of messages to keep in flight. For subscribe, this is the receive maximum. For publish, this is the maximum number of messages to send before waiting for an ack. */
  @minValue(0)
  maxInflightMessages?: int32;

  /** Session expiry in seconds. */
  @minValue(0)
  sessionExpirySeconds?: int32;

  /** TLS configuration. */
  tls?: TlsProperties;
}

/** AkriConnectorsMqttAuthentication properties. */
@added(Versions.`2025-07-01-preview`)
@discriminator("method")
model AkriConnectorsMqttAuthentication {
  /** The authentication method for the MQTT connection. */
  method: AkriConnectorsMqttAuthenticationMethod;
}

/** AkriConnectorsMqttAuthenticationMethod properties. */
@added(Versions.`2025-07-01-preview`)
union AkriConnectorsMqttAuthenticationMethod {
  string,

  /** Service Account Token authentication. */
  ServiceAccountToken,
}

/** Mqtt protocol types. */
@added(Versions.`2025-07-01-preview`)
union AkriConnectorsMqttProtocolType {
  string,

  /** Mqtt protocol. */
  Mqtt,
}

/** AkriConnectorsServiceAccountAuthentication properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorsServiceAccountAuthentication
  extends AkriConnectorsMqttAuthentication {
  /** The authentication method for the MQTT connection. */
  method: ServiceAccountToken;

  /** The service account token for the MQTT connection. */
  serviceAccountTokenSettings: AkriConnectorsServiceAccountTokenSettings;
}

/** AkriConnectorsServiceAccountTokenSettings properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorsServiceAccountTokenSettings {
  /** The audience for the service account token. */
  audience: string;
}

/** Image pull policy. */
@added(Versions.`2025-07-01-preview`)
union AkriConnectorsImagePullPolicy {
  string,

  /** Always pull the image. */
  Always,

  /** IfNotPresent pull the image. */
  IfNotPresent,

  /** Never pull the image. */
  Never,
}

/** AkriConnectorsImagePullSecret properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorsImagePullSecret {
  /** The name of the image pull secret. */
  secretRef: string;
}

/** AkriConnectorsTagDigestSettings properties. */
@added(Versions.`2025-07-01-preview`)
@discriminator("tagDigestType")
model AkriConnectorsTagDigestSettings {
  /** The tag or digest type. */
  tagDigestType: AkriConnectorsTagDigestType;
}
/** AkriConnectorsTagDigestType values. */
@added(Versions.`2025-07-01-preview`)
union AkriConnectorsTagDigestType {
  string,

  /** Indicates that a tag should be specified. */
  Tag,

  /** Indicates that a digest should be specified. */
  Digest,
}

/** AkriConnectorsTag properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorsTag extends AkriConnectorsTagDigestSettings {
  /** The tag or digest type. */
  tagDigestType: Tag;

  /** The tag of the image. */
  tag: string;
}

/** AkriConnectorsDigest properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorsDigest extends AkriConnectorsTagDigestSettings {
  /** The tag or digest type. */
  tagDigestType: Digest;

  /** The digest of the image. */
  digest: string;
}
/** AkriConnectorsRegistrySettings properties. */
@added(Versions.`2025-07-01-preview`)
@discriminator("registrySettingsType")
model AkriConnectorsRegistrySettings {
  registrySettingsType: AkriConnectorsRegistrySettingsType;
}

/** AkriConnectorsRegistrySettings properties. */
@added(Versions.`2025-07-01-preview`)
union AkriConnectorsRegistrySettingsType {
  string,

  /** A Registry Endpoint reference. */
  RegistryEndpointRef,

  /** A Container Registry reference. */
  ContainerRegistry,
}

/** AkriConnectorsRegistryEndpointRef properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorsRegistryEndpointRef extends AkriConnectorsRegistrySettings {
  /** The registry endpoint reference. */
  registrySettingsType: RegistryEndpointRef;

  /** The name of the registry endpoint. */
  registryEndpointRef: string;
}

/** AkriConnectorsContainerRegistry properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorsContainerRegistry extends AkriConnectorsRegistrySettings {
  /** The registry settings type. */
  registrySettingsType: ContainerRegistry;

  /** The registry settings for the container registry. */
  containerRegistrySettings: AkriConnectorsContainerRegistrySettings;
}

/** AkriConnectorsContainerRegistry properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorsContainerRegistrySettings {
  /** The container registry to use for the artifact. */
  registry: string;

  /** Optional list of references to secrets in the same namespace to use for pulling the connector image. */
  @identifiers(#["secretRef"])
  imagePullSecrets?: AkriConnectorsImagePullSecret[];
}

/** AkriConnectorsSecret properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorsSecret {
  /** The key in the secret to be mounted. */
  secretKey: string;

  /** The application-defined alias for the secret. */
  secretAlias: string;

  /** The name of the secret to be mounted. */
  secretRef: string;
}

/** AkriConnectorsDiagnostic Log properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorsDiagnosticsLogs {
  /** The log level. Examples - 'debug', 'info', 'warn', 'error', 'trace'. */
  level?: string = "info";
}
