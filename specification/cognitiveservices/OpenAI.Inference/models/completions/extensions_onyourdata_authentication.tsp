import "@typespec/versioning";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

@doc("""
  Authentication types supported by with Azure OpenAI on your data.
""")
@added(ServiceApiVersions.v2023_08_01_Preview)
enum OnYourDataAuthenticationType {
  @doc("API key.")
  apiKey: "APIKey",

  @doc("Connection string.")
  connectionString: "ConnectionString",

  @doc("Key and keyId pair.")
  keyAndKeyId: "KeyAndKeyId",

  @doc("System-assigned managed identity.")
  systemAssignedManagedIdentity: "SystemAssignedManagedIdentity",

  @doc("User-assigned managed identity.")
  userAssignedManagedIdentity: "UserAssignedManagedIdentity",
}

@discriminator("type")
@doc("The authentication options for Azure OpenAI on your data.")
@added(ServiceApiVersions.v2023_08_01_Preview)
model OnYourDataAuthenticationOptions {
  @doc("The Authentication type.")
  type: OnYourDataAuthenticationType;
}

@doc("The authentication option using API key.")
@added(ServiceApiVersions.v2023_08_01_Preview)
model OnYourDataApiKeyAuthenticationOptions
  extends OnYourDataAuthenticationOptions {
  @doc("The Authentication type of API key.")
  type: OnYourDataAuthenticationType.apiKey;

  @doc("The API key to use for authentication.")
  apiKey: string;
}

@doc("The authentication option using connection string.")
@added(ServiceApiVersions.v2023_08_01_Preview)
model OnYourDataConnectionStringAuthenticationOptions
  extends OnYourDataAuthenticationOptions {
  @doc("The Authentication type of connection string.")
  type: OnYourDataAuthenticationType.connectionString;

  @doc("The connection string to use for authentication.")
  connectionString: string;
}

@doc("The authentication option using Elasticsearch key and keyId pair.")
@added(ServiceApiVersions.v2023_08_01_Preview)
model OnYourDataKeyAndKeyIdAuthenticationOptions
  extends OnYourDataAuthenticationOptions {
  @doc("The Authentication type of Elasticsearch key and keyId pair.")
  type: OnYourDataAuthenticationType.keyAndKeyId;

  @doc("The key to use for authentication.")
  key: string;

  @doc("The key ID to use for authentication.")
  keyId: string;
}

@doc("The authentication option using system-assigned managed identity.")
@added(ServiceApiVersions.v2023_08_01_Preview)
model OnYourDataSystemAssignedManagedIdentityAuthenticationOptions
  extends OnYourDataAuthenticationOptions {
  @doc("The Authentication type of system-assigned managed identity.")
  type: OnYourDataAuthenticationType.systemAssignedManagedIdentity;
}

@doc("The authentication option using user-assigned managed identity.")
@added(ServiceApiVersions.v2023_08_01_Preview)
model OnYourDataUserAssignedManagedIdentityAuthenticationOptions
  extends OnYourDataAuthenticationOptions {
  @doc("The Authentication type of user-assigned managed identity.")
  type: OnYourDataAuthenticationType.userAssignedManagedIdentity;

  @doc("The resource ID of the user-assigned managed identity to use for authentication.")
  managedIdentityResourceId: string;
}
