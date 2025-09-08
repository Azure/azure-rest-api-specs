import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./auth.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/** RegistryEndpoint resource */
@parentResource(InstanceResource)
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointResource is ProxyResource<RegistryEndpointProperties> {
  /** Name of RegistryEndpoint resource */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("registryEndpointName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("registryEndpoints")
  name: string;

  /** Edge location of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;
}

/** RegistryEndpoint properties */
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointProperties {
  /** The Container Registry endpoint hostname. */
  @maxLength(63)
  @minLength(3)
  host: string;

  /** The authentication settings for the Azure Container Registry. */
  authentication: RegistryEndpointAuthentication;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** Trust settings for the registry endpoint */
  trustSettings?: RegistryEndpointTrustedSettings;
}

/** RegistryEndpointTrustedSettings properties */
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointTrustedSettings {
  /** The trust properties for the registry endpoint. */
  trustedSigningKeys: RegistryEndpointTrustedSigningKey;
}

/** RegistryEndpoint Trust properties */
@added(Versions.`2025-07-01-preview`)
@discriminator("type")
model RegistryEndpointTrustedSigningKey {
  /** The trust type for the registry endpoint. */
  type: RegistryEndpointTrustedSigningKeyType;
}

/** RegistryEndpointTrustedSigningKeyType values */
@added(Versions.`2025-07-01-preview`)
union RegistryEndpointTrustedSigningKeyType {
  string,

  /** Trust settings stored in a Kubernetes Secret. */
  Secret,

  /** Trust settings stored in a Kubernetes ConfigMap. */
  ConfigMap,
}

/** Settings for RegistryEndpoint trust provided through a secret. */
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointTrustedSigningKeySecret
  extends RegistryEndpointTrustedSigningKey {
  /** The trust type for the registry endpoint. */
  type: Secret;

  /** The name of the secret. */
  secretRef: string;
}

/** Settings for RegistryEndpoint trust provided through a configmap. */
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointTrustedSigningKeyConfigMap
  extends RegistryEndpointTrustedSigningKey {
  /** The trust type for the registry endpoint. */
  type: ConfigMap;

  /** The name of the configmap. */
  configMapRef: string;
}
