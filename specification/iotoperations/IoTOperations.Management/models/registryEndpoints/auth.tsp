import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

@doc("Model for RegistryEndpointAuthentication")
@discriminator("method")
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointAuthentication {
  @doc("The authentication method.")
  method: RegistryEndpointAuthenticationMethod;
}

@doc("The authentication method.")
@added(Versions.`2025-07-01-preview`)
union RegistryEndpointAuthenticationMethod {
  string,
  ManagedIdentityMethod,
  AnonymousMethod,
}

@doc("System assigned identity authentication")
@added(Versions.`2025-07-01-preview`)
model SystemAssignedIdentityAuthentication extends RegistryEndpointAuthentication {
  @doc("The authentication method.")
  method: SystemAssignedManagedIdentity;

  @doc("System assigned managed identity properties")
  systemAssignedManagedIdentitySettings: SystemAssignedManagedIdentitySettings;
}

@doc("User assigned identity authentication")
@added(Versions.`2025-07-01-preview`)
model UserAssignedIdentityAuthentication extends RegistryEndpointAuthentication {
  @doc("The authentication method.")
  method: UserAssignedManagedIdentity;

  @doc("User assigned managed identity properties")
  userAssignedManagedIdentitySettings: UserAssignedManagedIdentitySettings;
}

@doc("System assigned managed identity properties")
@added(Versions.`2025-07-01-preview`)
model SystemAssignedManagedIdentitySettings {
  ...BaseSystemAssignedManagedIdentity;
}

@doc("User assigned managed identity properties")
@added(Versions.`2025-07-01-preview`)
model UserAssignedManagedIdentitySettings {
  ...BaseUserAssignedManagedIdentity;
}

@doc("Anonymous authentication")
@added(Versions.`2025-07-01-preview`)
model AnonymousAuthentication extends RegistryEndpointAuthentication {
  @doc("The authentication method.")
  method: Anonymous;

  @doc("Anonymous authentication properties")
  anonymousSettings: AnonymousSettings;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "CRD type is modeled as empty object"
@doc("Anonymous authentication properties")
@added(Versions.`2025-07-01-preview`)
model AnonymousSettings {}
