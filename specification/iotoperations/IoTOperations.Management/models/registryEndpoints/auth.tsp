import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using Azure.ResourceManager;

namespace Microsoft.IoTOperations.RegistryEndpoints;

@doc("Model for Authentication")
@discriminator("method")
@added(Versions.`2025-07-01-preview`)
model Authentication {
  @doc("The authentication method.")
  method: AuthenticationMethod;
}

@doc("The authentication method.")
@added(Versions.`2025-07-01-preview`)
union AuthenticationMethod {
  string,
  ManagedIdentityMethod,
  AnonymousMethod,
}

@doc("System assigned identity authentication")
@added(Versions.`2025-07-01-preview`)
model SystemAssignedIdentityAuthentication extends Authentication {
  @doc("The authentication method.")
  method: SystemAssignedManagedIdentity;

  @doc("System assigned managed identity properties")
  systemAssignedManagedIdentitySettings: SystemAssignedManagedIdentitySettings;
}

@doc("User assigned identity authentication")
@added(Versions.`2025-07-01-preview`)
model UserAssignedIdentityAuthentication extends Authentication {
  @doc("The authentication method.")
  method: UserAssignedManagedIdentity;

  @doc("User assigned managed identity properties")
  userAssignedManagedIdentitySettings: UserAssignedManagedIdentitySettings;
}

@doc("System assigned managed identity properties")
@added(Versions.`2025-07-01-preview`)
model SystemAssignedManagedIdentitySettings {
  ...DataflowEndpointAuthenticationSystemAssignedManagedIdentity;
}

@doc("User assigned managed identity properties")
@added(Versions.`2025-07-01-preview`)
model UserAssignedManagedIdentitySettings {
  ...DataflowEndpointAuthenticationUserAssignedManagedIdentity;
}

@doc("Anonymous authentication")
@added(Versions.`2025-07-01-preview`)
model AnonymousAuthentication extends Authentication {
  @doc("The authentication method.")
  method: Anonymous;

  @doc("Anonymous authentication properties")
  anonymousSettings: AnonymousSettings;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "CRDs are modeled as empty models"
@doc("Anonymous authentication properties")
@added(Versions.`2025-07-01-preview`)
model AnonymousSettings {}
