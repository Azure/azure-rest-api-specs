import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using TypeSpec.OpenAPI;


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
model RegistryEndpointSystemAssignedIdentityAuthentication
  extends RegistryEndpointAuthentication {
  @doc("The authentication method.")
  method: SystemAssignedManagedIdentity;

  @doc("System assigned managed identity properties")
  systemAssignedManagedIdentitySettings: RegistryEndpointSystemAssignedManagedIdentitySettings;
}

@doc("User assigned identity authentication")
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointUserAssignedIdentityAuthentication
  extends RegistryEndpointAuthentication {
  @doc("The authentication method.")
  method: UserAssignedManagedIdentity;

  @doc("User assigned managed identity properties")
  userAssignedManagedIdentitySettings: RegistryEndpointUserAssignedManagedIdentitySettings;
}

@doc("System assigned managed identity properties")
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointSystemAssignedManagedIdentitySettings {
  ...BaseSystemAssignedManagedIdentity;
}

@doc("User assigned managed identity properties")
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointUserAssignedManagedIdentitySettings {
  ...BaseUserAssignedManagedIdentity;
}

@doc("Anonymous authentication")
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointAnonymousAuthentication
  extends RegistryEndpointAuthentication {
  @doc("The authentication method.")
  method: Anonymous;

  @doc("Anonymous authentication properties")
  anonymousSettings: RegistryEndpointAnonymousSettings;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "CRD type is modeled as empty object"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "This is an empty model and should not conain extra properites"
@doc("RegistryEdnpoint Anonymous authentication properties")
@added(Versions.`2025-07-01-preview`)
@extension("additionalProperties", false)
model RegistryEndpointAnonymousSettings {}
