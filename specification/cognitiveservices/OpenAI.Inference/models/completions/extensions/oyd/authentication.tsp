import "@typespec/versioning";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

@doc("""
The authentication types supported with Azure OpenAI On Your Data.
""")
@added(ServiceApiVersions.v2023_08_01_Preview)
enum OnYourDataAuthenticationType {
  @doc("Authentication via API key.")
  apiKey: "APIKey",

  @doc("Authentication via connection string.")
  connectionString: "ConnectionString",

  @doc("Authentication via key and key ID pair.")
  keyAndKeyId: "KeyAndKeyId",

  @doc("Authentication via system-assigned managed identity.")
  systemAssignedManagedIdentity: "SystemAssignedManagedIdentity",

  @doc("Authentication via user-assigned managed identity.")
  userAssignedManagedIdentity: "UserAssignedManagedIdentity",
}

@discriminator("type")
@doc("The authentication options for Azure OpenAI On Your Data.")
@added(ServiceApiVersions.v2023_08_01_Preview)
model OnYourDataAuthenticationOptions {
  @doc("The authentication type.")
  type: OnYourDataAuthenticationType;
}

@doc("""
The authentication options for Azure OpenAI On Your Data when using an API key.
""")
@added(ServiceApiVersions.v2023_08_01_Preview)
model OnYourDataApiKeyAuthenticationOptions
  extends OnYourDataAuthenticationOptions {
  @doc("The authentication type of API key.")
  type: OnYourDataAuthenticationType.apiKey;

  @doc("The API key to use for authentication.")
  key: string;
}

@doc("""
The authentication options for Azure OpenAI On Your Data when using a connection string.
""")
@added(ServiceApiVersions.v2023_08_01_Preview)
model OnYourDataConnectionStringAuthenticationOptions
  extends OnYourDataAuthenticationOptions {
  @doc("The authentication type of connection string.")
  type: OnYourDataAuthenticationType.connectionString;

  @doc("The connection string to use for authentication.")
  connectionString: string;
}

@doc("""
The authentication options for Azure OpenAI On Your Data when using an Elasticsearch key and key ID pair.
""")
@added(ServiceApiVersions.v2023_08_01_Preview)
model OnYourDataKeyAndKeyIdAuthenticationOptions
  extends OnYourDataAuthenticationOptions {
  @doc("The authentication type of Elasticsearch key and key ID pair.")
  type: OnYourDataAuthenticationType.keyAndKeyId;

  @doc("The key to use for authentication.")
  key: string;

  @doc("The key ID to use for authentication.")
  keyId: string;
}

@doc("""
The authentication options for Azure OpenAI On Your Data when using a system-assigned managed identity.
""")
@added(ServiceApiVersions.v2023_08_01_Preview)
model OnYourDataSystemAssignedManagedIdentityAuthenticationOptions
  extends OnYourDataAuthenticationOptions {
  @doc("The authentication type of system-assigned managed identity.")
  type: OnYourDataAuthenticationType.systemAssignedManagedIdentity;
}

@doc("""
The authentication options for Azure OpenAI On Your Data when using a user-assigned managed identity.
""")
@added(ServiceApiVersions.v2023_08_01_Preview)
model OnYourDataUserAssignedManagedIdentityAuthenticationOptions
  extends OnYourDataAuthenticationOptions {
  @doc("The authentication type of user-assigned managed identity.")
  type: OnYourDataAuthenticationType.userAssignedManagedIdentity;

  @doc("The resource ID of the user-assigned managed identity to use for authentication.")
  managedIdentityResourceId: string;
}
