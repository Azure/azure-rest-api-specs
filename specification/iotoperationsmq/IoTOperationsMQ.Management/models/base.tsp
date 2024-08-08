import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.IoTOperationsMQ;

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Valid Inline Model of Extended location"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Extended location is a valid property"
alias ExtendedLocation = {
  @doc("Extended Location")
  @visibility("read", "create")
  extendedLocation: ExtendedLocationProperty;
};

@doc("ExtendedLocation properties")
model ExtendedLocationProperty {
  @doc("The name of the extended location.")
  name: string;

  @doc("Type of ExtendedLocation.")
  type: ExtendedLocationType;
}

@doc("The enum defining type of ExtendedLocation accepted.")
union ExtendedLocationType {
  string,

  @doc("CustomLocation type")
  "CustomLocation",
}

@doc("The enum defining status of resource.")
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Resource is getting provisioned.")
  Provisioning: "Provisioning",

  @doc("Resource is Updating.")
  Updating: "Updating",

  @doc("Resource is Deleting.")
  Deleting: "Deleting",

  @doc("Resource has been Accepted.")
  Accepted: "Accepted",
}

@doc("Defines the Docker image details")
model ContainerImage {
  @doc("Image pull policy.")
  pullPolicy?: string;

  @doc("Image pull secrets.")
  pullSecrets?: string;

  @doc("The Docker image name.")
  repository: string;

  @doc("The Docker  image tag.")
  tag: string;
}

@doc("Defines the Node Tolerations details")
model NodeTolerations {
  @doc("Toleration effect.")
  effect: string;

  @doc("Toleration key.")
  key: string;

  @doc("Toleration operator like 'Exists', 'Equal' etc.")
  operator: string;

  @doc("Toleration Value.")
  value: string;
}

@doc("Cert Manager CA Cert properties")
model CertManagerCertOptions {
  @doc("Duration of CA cert.")
  duration: string = "720h";

  @doc("Cert Manager private key.")
  privateKey: CertManagerPrivateKey;

  @doc("Renew before time of CA cert.")
  renewBefore: string = "240h";
}

@doc("Cert Manager private key properties")
model CertManagerPrivateKey {
  @doc("algorithm for private key.")
  algorithm: string = "ECDSA";

  @doc("cert-manager rotationPolicy.")
  rotationPolicy: string = "Always";

  @doc("size of private key.")
  @minValue(0)
  @maxValue(65535)
  size: int32 = 256;
}

@doc("Cert-Manager issuerRef properties")
model CertManagerIssuerRef {
  @doc("group of issuer.")
  group: string = "cert-manager.io";

  @doc("kind of issuer (Issuer or ClusterIssuer).")
  kind: string;

  @doc("name of issuer.")
  name: string;
}

@doc("SANs for certificate.")
model SanForCert {
  @doc("DNS SANs.")
  dns: string[] = [];

  @doc("IP address SANs.")
  ip: string[] = [];
}

@doc("Mqtt Protocol types")
union MqttProtocol {
  string,

  @doc("Mqttv3")
  "v3",

  @doc("Mqttv5")
  "v5",
}

@doc("Mqtt Local Broker ConnectionSpec details")
model LocalBrokerConnectionSpec {
  @doc("The authentication methods for LocalBroker connection. NOTE - Enum only one method at a time is supported.")
  authentication?: LocalBrokerAuthenticationMethods;

  @doc("The endpoint of local broker to connect to.")
  endpoint?: string = "aio-mq-dmqtt-frontend:1883";

  @doc("TLS details for Local broker Connection.")
  tls?: LocalBrokerConnectionTls;
}

@doc("Mqtt Local Broker Authentication details. Only one method at a time is supported. Default - kubernetes authentication")
model LocalBrokerAuthenticationMethods {
  @doc("Kubernetes local broker authentication method.")
  kubernetes: LocalBrokerKubernetesAuthentication;
}

@doc("Local Broker Kubernetes Authentication")
model LocalBrokerKubernetesAuthentication {
  @doc("Secret Path where SAT is mounted.")
  secretPath?: string = "/var/run/serviceaccount/localbroker";

  @doc("Token name where SAT is mounted on secret path.")
  serviceAccountTokenName?: string = "sat";
}

@doc("Managed identity authentication details.")
model ManagedIdentityAuthentication {
  @doc("Token audience.")
  audience: string;

  @doc("Arc Extension name.")
  extensionName?: string;
}

@doc("Mqtt Local Broker Connection TLS details")
model LocalBrokerConnectionTls {
  @doc("Tls Enabled on Local Broker Connection.")
  tlsEnabled?: boolean = false;

  @doc("Trusted CA certificate config map name for Local Broker.")
  trustedCaCertificateConfigMap?: string;
}

// Add keyvault properties
@doc("KeyVault certificate properties")
model KeyVaultCertificateProperties {
  @doc("KeyVault properties.")
  vault: KeyVaultConnectionProperties;

  @doc("KeyVault CA chain secret details.")
  vaultCaChainSecret?: KeyVaultSecretObject;

  @doc("KeyVault Cert secret details.")
  vaultCert: KeyVaultSecretObject;
}

// Add keyvault properties
@doc("KeyVault secret properties")
model KeyVaultSecretProperties {
  @doc("KeyVault properties.")
  vault: KeyVaultConnectionProperties;

  @doc("KeyVault secret details.")
  vaultSecret: KeyVaultSecretObject;
}

// Add KeyVault properties
@doc("KeyVault properties")
model KeyVaultConnectionProperties {
  @doc("KeyVault credentials.")
  credentials: KeyVaultCredentialsProperties;

  @doc("KeyVault directoryId.")
  directoryId: string;

  @doc("KeyVault name.")
  name: string;
}

// Add KeyVault credentials properties
@doc("KeyVault credentials properties. NOTE - Future this will be ENUM.")
model KeyVaultCredentialsProperties {
  @doc("KeyVault service principal local secret name.")
  servicePrincipalLocalSecretName: string;
}

//Add KeyVault secret properties
@doc("KeyVault secret object properties")
model KeyVaultSecretObject {
  @doc("KeyVault secret name.")
  name: string;

  @doc("KeyVault secret version.")
  version?: string;
}
