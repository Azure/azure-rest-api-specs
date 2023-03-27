import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/delegation.tsp";

using TypeSpec.Http;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Routes.Delegation;

@route("/delegation/settings")
@doc("Delegation settings.")
@get
op GetDelegationSettings(): ApiResponse<DelegationSettings>;

@route("/delegation/urls/{action}")
@doc("Unauthorized delegation URLs (Signin, Signup).")
@post
op CreateDelegationSigninUrl(
  @doc("The action to perform.")
  @path
  action: string,

  @doc("The URL to redirect to after the user has signed in.")
  @body
  delegationOperationRequest: DelegationOperationRequest
): ApiResponse<DelegationOperationResponse>;
