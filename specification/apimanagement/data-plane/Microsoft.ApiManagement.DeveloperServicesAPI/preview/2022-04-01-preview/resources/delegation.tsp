import "@typespec/rest";
import "../models/common.tsp";
import "../models/delegation.tsp";

using TypeSpec.Http;
using DeveloperServicesAPI.Models;

namespace DeveloperServicesPublicAPI.Routes.Delegation;

//Routes

@route("/delegation/settings")
@doc("Delegation settings.")
@get
op GetDelegationSettings(): ApiResponse<DelegationSettings>;

@route("/delegation/urls/{action}")
@doc("Unauthorized delegation URLs (Signin, Signup).")
@post
op CreateDelegationSigninUrl(
  @path action: string,
  @body delegationOperationRequest: DelegationOperationRequest
): ApiResponse<DelegationOperationResponse>;

@route("/delegation/urls/users/{userId}/{action}")
@doc("User specific delegation urls (CloseAccount, ChangePassword, ChangeProfile, Subscribe, Unsubscribe, Renew, Signout).")
@post
op CreateUserDelegationUrl(
  @path userId: string,
  @path action: string,
  @body userDelegationOperationRequest: UserDelegationOperationRequest
): ApiResponse<UserDelegationOperationResponse>;
