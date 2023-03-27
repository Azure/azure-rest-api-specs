import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/delegation.tsp";

using TypeSpec.Http;
using DeveloperServicesApi.Models;

namespace DeveloperServicesAuthorizedApi.Routes.Delegation;

@route("/delegation/urls/users/{userId}/{action}")
@doc("User specific delegation urls (CloseAccount, ChangePassword, ChangeProfile, Subscribe, Unsubscribe, Renew, Signout).")
@post
op CreateUserDelegationUrl(
  ...UserParams,
  @path action: string,
  @body userDelegationOperationRequest: UserDelegationOperationRequest
): ApiResponse<UserDelegationOperationResponse>;
