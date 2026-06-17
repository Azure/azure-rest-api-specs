import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.Communication.IdentityService;

@doc("API versions for the Communication Identity Service.")
enum Versions {
  @doc("Communication Identity 2025-06-30 api version")
  c2025_06_30: "2025-06-30",
}

// --- Error models (matching common.json) ---

@doc("The Communication Services error.")
@error
model CommunicationErrorResponse {
  @doc("The Communication Services error.")
  error: CommunicationError;
}

@doc("The Communication Services error.")
model CommunicationError {
  @doc("The error code.")
  code: string;

  @doc("The error message.")
  message: string;

  @doc("The error target.")
  @visibility(Lifecycle.Read)
  target?: string;

  @doc("Further details about specific errors that led to this error.")
  @visibility(Lifecycle.Read)
  details?: CommunicationError[];

  @doc("The inner error if any.")
  @encodedName("application/json", "innererror")
  @visibility(Lifecycle.Read)
  innerError?: CommunicationError;
}

// --- Identity models ---

@doc("A communication identity.")
model CommunicationIdentity {
  @doc("Identifier of the identity.")
  id: string;
}

@doc("An access token.")
model CommunicationIdentityAccessToken {
  @doc("The access token issued for the identity.")
  token: string;

  @doc("The expiry time of the token.")
  expiresOn: utcDateTime;
}

@doc("A communication identity with access token.")
model CommunicationIdentityAccessTokenResult {
  @doc("The communication identity.")
  identity: CommunicationIdentity;

  @doc("An access token.")
  accessToken?: CommunicationIdentityAccessToken;
}

@doc("Request to create a new identity with optional access token.")
model CommunicationIdentityCreateRequest {
  @doc("Also create access token for the created identity.")
  createTokenWithScopes?: CommunicationIdentityTokenScope[];

  @doc("Optional custom validity period of the token within [60,1440] minutes range. If not provided, the default value of 1440 minutes (24 hours) will be used.")
  @minValue(60)
  @maxValue(1440)
  expiresInMinutes?: int32 = 1440;
}

@doc("Request to issue a new access token for an identity.")
model CommunicationIdentityAccessTokenRequest {
  @doc("List of scopes attached to the token.")
  scopes: CommunicationIdentityTokenScope[];

  @doc("Optional custom validity period of the token within [60,1440] minutes range. If not provided, the default value of 1440 minutes (24 hours) will be used.")
  @minValue(60)
  @maxValue(1440)
  expiresInMinutes?: int32 = 1440;
}

@doc("List of scopes for an access token.")
union CommunicationIdentityTokenScope {
  string,

  @doc("Use this for full access to Chat APIs.")
  chat: "chat",

  @doc("Use this for full access to Calling APIs.")
  voip: "voip",

  @doc("Access to Chat APIs but without the authorization to create, delete or update chat threads.")
  chatJoin: "chat.join",

  @doc("A more limited version of chat.join that doesn't allow to add or remove participants. Use this scope when the token bearer is not fully trusted, for example in guest scenarios.")
  chatJoinLimited: "chat.join.limited",

  @doc("Access to Calling APIs but without the authorization to start new calls.")
  voipJoin: "voip.join",
}

// --- Teams User models ---

@doc("A request to exchange a Teams user access token.")
model TeamsUserExchangeTokenRequest {
  @doc("Entra ID access token of a Teams User to acquire a new Communication Identity access token.")
  token: string;

  @doc("Client ID of an Entra ID application to be verified against the appid claim in the Entra ID access token.")
  appId: string;

  @doc("Object ID of an Entra ID user (Teams User) to be verified against the oid claim in the Entra ID access token.")
  userId: string;
}

// --- Teams Extension models ---

@doc("A request to exchange a Teams Extension token.")
model TeamsExtensionExchangeTokenRequest {}

@doc("A request to create or update a Teams Extension assignment.")
model TeamsExtensionAssignmentCreateOrUpdateRequest {
  @doc("The type of principal the assignment is for.")
  principalType: TeamsExtensionPrincipalType;

  @doc("The client IDs for the assignment.")
  clientIds?: string[];
}

@doc("A Teams Extension assignment response.")
model TeamsExtensionAssignmentResponse {
  @doc("The object ID of the assignment.")
  objectId: string;

  @doc("The tenant ID of the assignment.")
  tenantId: string;

  @doc("The type of principal the assignment is for.")
  principalType: TeamsExtensionPrincipalType;

  @doc("The client IDs for the assignment.")
  clientIds?: string[];
}

@doc("The type of principal the assignment is for.")
union TeamsExtensionPrincipalType {
  string,

  @doc("Resource account principal type.")
  resourceAccount: "resourceAccount",

  @doc("User principal type.")
  user: "user",
}
