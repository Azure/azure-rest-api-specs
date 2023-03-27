import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/user.tsp";

using TypeSpec.Http;
using DeveloperServicesAPI.Models;

namespace DeveloperServicesAuthorizedAPI.Routes.Users;

@route("/users/{userId}")
@doc("Get a user profile by its identifier.")
@get
op GetUser(...UserParams): ApiResponse<User>;

@route("/users/{userId}")
@doc("Create or updatea a user by its identifier.")
@patch
op CreateOrUpdateUser(
    ...UserParams,
    @header @friendlyName("If-Match") ifMatch: string,
    @body userUpdate: UserUpdate
): ApiResponse<User>;

@route("/users/{userId}")
@doc("Delete a user by its identifier.")
@delete
op DeleteUser(...UserParams): NoContentResponse | ErrorResponse;
