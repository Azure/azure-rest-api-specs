import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Azure.Communication.IdentityService;

// --- Identity operations ---

@tag("Identity")
@route("/identities")
interface IdentityOperations {
  @summary("Create a new identity, and optionally, an access token.")
  @doc("Create a new identity, and optionally, an access token.")
  @operationId("CommunicationIdentity_Create")
  @post
  create(
    @query("api-version")
    @doc("Version of API to invoke.")
    apiVersion: string,

    @doc("If specified, creates also a Communication Identity access token associated with the identity and containing the requested scopes.")
    @body
    body?: CommunicationIdentityCreateRequest,
  ):
    | {
        @statusCode statusCode: 201;
        @body result: CommunicationIdentityAccessTokenResult;
      }
    | CommunicationErrorResponse;

  @summary("Delete the identity, revoke all tokens for the identity and delete all associated data.")
  @doc("Delete the identity, revoke all tokens for the identity and delete all associated data.")
  @operationId("CommunicationIdentity_Delete")
  @route("/{id}")
  @delete
  delete(
    @doc("Identifier of the identity to be deleted.")
    @path
    id: string,

    @query("api-version")
    @doc("Version of API to invoke.")
    apiVersion: string,
  ):
    | {
        @statusCode statusCode: 204;
      }
    | CommunicationErrorResponse;

  @summary("Revoke all access tokens for the specific identity.")
  @doc("Revoke all access tokens for the specific identity.")
  @operationId("CommunicationIdentity_RevokeAccessTokens")
  @route("/{id}/:revokeAccessTokens")
  @post
  revokeAccessTokens(
    @doc("Identifier of the identity.")
    @path
    id: string,

    @query("api-version")
    @doc("Version of API to invoke.")
    apiVersion: string,
  ):
    | {
        @statusCode statusCode: 204;
      }
    | CommunicationErrorResponse;

  @summary("Issue a new token for an identity.")
  @doc("Issue a new token for an identity.")
  @operationId("CommunicationIdentity_IssueAccessToken")
  @route("/{id}/:issueAccessToken")
  @post
  issueAccessToken(
    @doc("Identifier of the identity to issue token for.")
    @path
    id: string,

    @query("api-version")
    @doc("Version of API to invoke.")
    apiVersion: string,

    @doc("Requested scopes for the new token.")
    @body
    body: CommunicationIdentityAccessTokenRequest,
  ):
    | {
        @statusCode statusCode: 200;
        @body result: CommunicationIdentityAccessToken;
      }
    | CommunicationErrorResponse;
}

// --- Teams User operations ---

@tag("TeamsUser")
interface TeamsUserOperations {
  @summary("Exchange an Entra ID access token of a Teams user for a new Communication Identity access token with a matching expiration time.")
  @doc("Exchange an Entra ID access token of a Teams user for a new Communication Identity access token with a matching expiration time.")
  @operationId("CommunicationIdentity_ExchangeTeamsUserAccessToken")
  @route("/teamsUser/:exchangeAccessToken")
  @post
  exchangeTeamsUserAccessToken(
    @query("api-version")
    @doc("Version of API to invoke.")
    apiVersion: string,

    @doc("Request payload for the token exchange.")
    @body
    body: TeamsUserExchangeTokenRequest,
  ):
    | {
        @statusCode statusCode: 200;
        @body result: CommunicationIdentityAccessToken;
      }
    | CommunicationErrorResponse;
}

// --- Teams Extension operations ---

@tag("TeamsExtension")
interface TeamsExtensionOperations {
  @summary("Exchanges a Teams Phone token for an ACS user access token.")
  @doc("Exchanges a Teams Phone token for an ACS user access token.")
  @operationId("TeamsExtensionToken_Exchange")
  @route("/access/teamsExtension/:exchangeAccessToken")
  @post
  exchangeToken(
    @doc("Request payload for the token exchange.")
    @body
    body: TeamsExtensionExchangeTokenRequest,

    @query("api-version")
    @doc("Version of API to invoke.")
    apiVersion: string,
  ):
    | {
        @statusCode statusCode: 200;
        @body result: CommunicationIdentityAccessTokenResult;
      }
    | CommunicationErrorResponse;

  @summary("Get Teams Phone access assignment by object id.")
  @doc("Get Teams Phone access assignment by object id.")
  @operationId("TeamsExtensionAssignment_Get")
  @route("/access/teamsExtension/tenants/{tenantId}/assignments/{objectId}")
  @get
  getAssignment(
    @doc("Tenant Id we want to get the assignment for.")
    @path
    tenantId: string,

    @doc("Object Id we want to get the assignment for.")
    @path
    objectId: string,

    @query("api-version")
    @doc("Version of API to invoke.")
    apiVersion: string,
  ):
    | {
        @statusCode statusCode: 200;
        @body result: TeamsExtensionAssignmentResponse;
      }
    | CommunicationErrorResponse;

  @summary("Creates or replaces a Teams Phone access assignment.")
  @doc("Creates or replaces a Teams Phone access assignment.")
  @operationId("TeamsExtensionAssignment_Upsert")
  @route("/access/teamsExtension/tenants/{tenantId}/assignments/{objectId}")
  @put
  upsertAssignment(
    @doc("Tenant Id we want to update the assignment for.")
    @path
    tenantId: string,

    @doc("Object Id we want to update the assignment for.")
    @path
    objectId: string,

    @query("api-version")
    @doc("Version of API to invoke.")
    apiVersion: string,

    @doc("Values we want to set.")
    @body
    body: TeamsExtensionAssignmentCreateOrUpdateRequest,
  ):
    | {
        @statusCode statusCode: 200;
        @body result: TeamsExtensionAssignmentResponse;
      }
    | {
        @statusCode statusCode: 201;
        @body result: TeamsExtensionAssignmentResponse;
      }
    | CommunicationErrorResponse;

  @summary("Removes a Teams Phone access assignment.")
  @doc("Removes a Teams Phone access assignment.")
  @operationId("TeamsExtensionAssignment_Delete")
  @route("/access/teamsExtension/tenants/{tenantId}/assignments/{objectId}")
  @delete
  deleteAssignment(
    @doc("Tenant Id we want to remove the assignment for.")
    @path
    tenantId: string,

    @doc("Object Id we want to remove the assignment for.")
    @path
    objectId: string,

    @query("api-version")
    @doc("Version of API to invoke.")
    apiVersion: string,
  ):
    | {
        @statusCode statusCode: 204;
      }
    | CommunicationErrorResponse;
}
