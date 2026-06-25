import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace Azure.Communication.IdentityService;

// --- Identity operations ---

@tag("Identity")
@route("/identities")
interface IdentityOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Brownfield conversion from existing swagger"
  @summary("Create a new identity, and optionally, an access token.")
  @doc("Create a new identity, and optionally, an access token.")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      @doc("If specified, creates also a Communication Identity access token associated with the identity and containing the requested scopes.")
      @body
      body?: CommunicationIdentityCreateRequest;
    },
    {
      @statusCode statusCode: 201;
      @body result: CommunicationIdentityAccessTokenResult;
    },
    {},
    CommunicationErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Brownfield conversion from existing swagger"
  @summary("Delete the identity, revoke all tokens for the identity and delete all associated data.")
  @doc("Delete the identity, revoke all tokens for the identity and delete all associated data.")
  @route("/{id}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      @doc("Identifier of the identity to be deleted.")
      @path
      id: string;
    },
    {
      @statusCode statusCode: 204;
    },
    {},
    CommunicationErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Brownfield conversion from existing swagger"
  @summary("Revoke all access tokens for the specific identity.")
  @doc("Revoke all access tokens for the specific identity.")
  @route("/{id}/:revokeAccessTokens")
  @post
  revokeAccessTokens is Azure.Core.Foundations.Operation<
    {
      @doc("Identifier of the identity.")
      @path
      id: string;
    },
    {
      @statusCode statusCode: 204;
    },
    {},
    CommunicationErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Brownfield conversion from existing swagger"
  @summary("Issue a new token for an identity.")
  @doc("Issue a new token for an identity.")
  @route("/{id}/:issueAccessToken")
  @post
  issueAccessToken is Azure.Core.Foundations.Operation<
    {
      @doc("Identifier of the identity to issue token for.")
      @path
      id: string;

      @doc("Requested scopes for the new token.")
      @body
      body: CommunicationIdentityAccessTokenRequest;
    },
    {
      @statusCode statusCode: 200;
      @body result: CommunicationIdentityAccessToken;
    },
    {},
    CommunicationErrorResponse
  >;
}

// --- Teams User operations ---

@tag("TeamsUser")
interface TeamsUserOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Brownfield conversion from existing swagger"
  @summary("Exchange an Entra ID access token of a Teams user for a new Communication Identity access token with a matching expiration time.")
  @doc("Exchange an Entra ID access token of a Teams user for a new Communication Identity access token with a matching expiration time.")
  @route("/teamsUser/:exchangeAccessToken")
  @post
  exchangeTeamsUserAccessToken is Azure.Core.Foundations.Operation<
    {
      @doc("Request payload for the token exchange.")
      @body
      body: TeamsUserExchangeTokenRequest;
    },
    {
      @statusCode statusCode: 200;
      @body result: CommunicationIdentityAccessToken;
    },
    {},
    CommunicationErrorResponse
  >;
}

// --- Teams Extension operations ---

@tag("TeamsExtension")
interface TeamsExtensionOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Brownfield conversion from existing swagger"
  @summary("Exchanges a Teams Phone token for an ACS user access token.")
  @doc("Exchanges a Teams Phone token for an ACS user access token.")
  @route("/access/teamsExtension/:exchangeAccessToken")
  @post
  exchangeToken is Azure.Core.Foundations.Operation<
    {
      @doc("Request payload for the token exchange.")
      @body
      body: TeamsExtensionExchangeTokenRequest;
    },
    {
      @statusCode statusCode: 200;
      @body result: CommunicationIdentityAccessTokenResult;
    },
    {},
    CommunicationErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Brownfield conversion from existing swagger"
  @summary("Get Teams Phone access assignment by object id.")
  @doc("Get Teams Phone access assignment by object id.")
  @route("/access/teamsExtension/tenants/{tenantId}/assignments/{objectId}")
  @get
  getAssignment is Azure.Core.Foundations.Operation<
    {
      @doc("Tenant Id we want to get the assignment for.")
      @path
      tenantId: string;

      @doc("Object Id we want to get the assignment for.")
      @path
      objectId: string;
    },
    {
      @statusCode statusCode: 200;
      @body result: TeamsExtensionAssignmentResponse;
    },
    {},
    CommunicationErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Brownfield conversion from existing swagger"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Preserving original operation name from swagger"
  @summary("Creates or replaces a Teams Phone access assignment.")
  @doc("Creates or replaces a Teams Phone access assignment.")
  @route("/access/teamsExtension/tenants/{tenantId}/assignments/{objectId}")
  @put
  upsertAssignment is Azure.Core.Foundations.Operation<
    {
      @doc("Tenant Id we want to update the assignment for.")
      @path
      tenantId: string;

      @doc("Object Id we want to update the assignment for.")
      @path
      objectId: string;

      @doc("Values we want to set.")
      @body
      body: TeamsExtensionAssignmentCreateOrUpdateRequest;
    },

      | {
          @statusCode statusCode: 200;
          @body result: TeamsExtensionAssignmentResponse;
        }
      | {
          @statusCode statusCode: 201;
          @body result: TeamsExtensionAssignmentResponse;
        },
    {},
    CommunicationErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Brownfield conversion from existing swagger"
  @summary("Removes a Teams Phone access assignment.")
  @doc("Removes a Teams Phone access assignment.")
  @route("/access/teamsExtension/tenants/{tenantId}/assignments/{objectId}")
  @delete
  deleteAssignment is Azure.Core.Foundations.Operation<
    {
      @doc("Tenant Id we want to remove the assignment for.")
      @path
      tenantId: string;

      @doc("Object Id we want to remove the assignment for.")
      @path
      objectId: string;
    },
    {
      @statusCode statusCode: 204;
    },
    {},
    CommunicationErrorResponse
  >;
}
