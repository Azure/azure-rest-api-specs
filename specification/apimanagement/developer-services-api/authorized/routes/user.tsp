import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/user.tsp";

using TypeSpec.Http;
using DeveloperServicesAPI.Models;

namespace DeveloperServicesAuthorizedAPI;

@route("/users/{userId}")
@doc("Get a user profile by its identifier.")
@get
op GetUser(...CommonParams): ApiResponse<User>;

@route("/users/{userId}")
@doc("Create or updatea a user by its identifier.")
@patch
op CreateOrUpdateUser(
    ...CommonParams,
    @header @friendlyName("If-Match") ifMatch: string,
    @body userUpdate: UserUpdate
): ApiResponse<User>;

@route("/users/{userId}")
@doc("Delete a user by its identifier.")
@delete
op DeleteUser(...CommonParams): NoContentResponse | ErrorResponse;

model CommonParams {
    @path userId: string;
}
