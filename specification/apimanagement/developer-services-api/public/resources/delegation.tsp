import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/delegation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Resources.Delegation;

@doc("Delegation resource model.")
@resource("delegation")
model DelegationSettingsResource extends DelegationSettings {
  @doc("Configuration content identifier.")
  @key("id")
  @visibility("query")
  id: "settings";
}

interface Delegations {
  @doc("Delegation settings.")
  getDelegationSettings is ResourceRead<DelegationSettingsResource>;
}

//TODO: find a workaround
@route("/delegation/urls/{action}")
@doc("Unauthorized delegation URLs (Signin, Signup).")
@post
op CreateDelegationSigninUrl(
  ...ApiVersionParameter,

  @doc("The action to perform.")
  @path
  action: string,

  @doc("The URL to redirect to after the user has signed in.")
  @body
  delegationOperationRequest: DelegationOperationRequest
): ApiResponse<DelegationOperationResponse>;
