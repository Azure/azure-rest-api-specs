import "@typespec/versioning";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

@doc("""
  The authentication types supported with Azure OpenAI On Your Data.
  """)
@added(ServiceApiVersions.v2024_02_15_Preview)
union OnYourDataAuthenticationType {
  string,

  @doc("Authentication via API key.")
  apiKey: "api_key",

  @doc("Authentication via connection string.")
  connectionString: "connection_string",

  @doc("Authentication via key and key ID pair.")
  keyAndKeyId: "key_and_key_id",

  @doc("Authentication via encoded API key.")
  encodedApiKey: "encoded_api_key",

  @doc("Authentication via access token.")
  accessToken: "access_token",

  @doc("Authentication via system-assigned managed identity.")
  systemAssignedManagedIdentity: "system_assigned_managed_identity",

  @doc("Authentication via user-assigned managed identity.")
  userAssignedManagedIdentity: "user_assigned_managed_identity",

  @added(ServiceApiVersions.v2024_08_01_Preview)
  @doc("Authentication via username and password.")
  usernameAndPassword: "username_and_password",
}

@discriminator("type")
@doc("The authentication options for Azure OpenAI On Your Data.")
@added(ServiceApiVersions.v2024_02_15_Preview)
model OnYourDataAuthenticationOptions {
  @doc("The authentication type.")
  type: OnYourDataAuthenticationType;
}

@doc("""
  The authentication options for Azure OpenAI On Your Data when using an API key.
  """)
@added(ServiceApiVersions.v2024_02_15_Preview)
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
@added(ServiceApiVersions.v2024_02_15_Preview)
model OnYourDataConnectionStringAuthenticationOptions
  extends OnYourDataAuthenticationOptions {
  @doc("The authentication type of connection string.")
  type: OnYourDataAuthenticationType.connectionString;

  @doc("The connection string to use for authentication.")
  @encodedName("application/json", "connection_string")
  connectionString: string;
}

@doc("""
  The authentication options for Azure OpenAI On Your Data when using an Elasticsearch key and key ID pair.
  """)
@added(ServiceApiVersions.v2024_02_15_Preview)
model OnYourDataKeyAndKeyIdAuthenticationOptions
  extends OnYourDataAuthenticationOptions {
  @doc("The authentication type of Elasticsearch key and key ID pair.")
  type: OnYourDataAuthenticationType.keyAndKeyId;

  @doc("The key to use for authentication.")
  key: string;

  @doc("The key ID to use for authentication.")
  @encodedName("application/json", "key_id")
  keyId: string;
}

@doc("""
  The authentication options for Azure OpenAI On Your Data when using an Elasticsearch encoded API key.
  """)
@added(ServiceApiVersions.v2024_02_15_Preview)
model OnYourDataEncodedApiKeyAuthenticationOptions
  extends OnYourDataAuthenticationOptions {
  @doc("The authentication type of Elasticsearch encoded API Key.")
  type: OnYourDataAuthenticationType.encodedApiKey;

  @doc("The encoded API key to use for authentication.")
  @encodedName("application/json", "encoded_api_key")
  encodedApiKey: string;
}

@doc("""
  The authentication options for Azure OpenAI On Your Data when using a username and password.
  """)
@added(ServiceApiVersions.v2024_08_01_Preview)
model OnYourDataUsernameAndPasswordAuthenticationOptions
  extends OnYourDataAuthenticationOptions {
  @doc("The discriminator type for username and password.")
  type: OnYourDataAuthenticationType.usernameAndPassword;

  @doc("The username.")
  username: string;

  @doc("The password.")
  password: string;
}

@doc("""
  The authentication options for Azure OpenAI On Your Data when using access token.
  """)
@added(ServiceApiVersions.v2024_02_15_Preview)
model OnYourDataAccessTokenAuthenticationOptions
  extends OnYourDataAuthenticationOptions {
  @doc("The authentication type of access token.")
  type: OnYourDataAuthenticationType.accessToken;

  @doc("The access token to use for authentication.")
  @encodedName("application/json", "access_token")
  accessToken: string;
}

@doc("""
  The authentication options for Azure OpenAI On Your Data when using a system-assigned managed identity.
  """)
@added(ServiceApiVersions.v2024_02_15_Preview)
model OnYourDataSystemAssignedManagedIdentityAuthenticationOptions
  extends OnYourDataAuthenticationOptions {
  @doc("The authentication type of system-assigned managed identity.")
  type: OnYourDataAuthenticationType.systemAssignedManagedIdentity;
}

@doc("""
  The authentication options for Azure OpenAI On Your Data when using a user-assigned managed identity.
  """)
@added(ServiceApiVersions.v2024_02_15_Preview)
model OnYourDataUserAssignedManagedIdentityAuthenticationOptions
  extends OnYourDataAuthenticationOptions {
  @doc("The authentication type of user-assigned managed identity.")
  type: OnYourDataAuthenticationType.userAssignedManagedIdentity;

  @doc("The resource ID of the user-assigned managed identity to use for authentication.")
  @encodedName("application/json", "managed_identity_resource_id")
  managedIdentityResourceId: string;
}
