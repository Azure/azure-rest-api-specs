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

  /** Trust list for the registry endpoint */
  @OpenAPI.extension("x-ms-identifiers", #[])
  trustList?: RegistryEndpointTrust[];
}

/** RegistryEndpoint Trust properties */
@added(Versions.`2025-07-01-preview`)
@discriminator("trustType")
model RegistryEndpointTrust {
  /** The trust type for the registry endpoint. */
  trustType: RegistryEndpointTrustType;
}

/** RegistryEndpointTrustType values */
@added(Versions.`2025-07-01-preview`)
union RegistryEndpointTrustType{
  string,

  /** Trust settings stored in a secret. */
  Secret,
}


/** RegistryEndpointSecretTrust */
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointSecretTrust extends RegistryEndpointTrust {
  /** The trust type for the registry endpoint. */
  trustType: Secret;

  /** The name of the secret. */
  secretRef: string;
}