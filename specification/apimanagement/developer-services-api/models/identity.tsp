namespace DeveloperServicesApi.Models;

@doc("UserId associate with credentials provided in request.")
model IdentityResult {
  @doc("Signed user id.")
  id: string;

  @doc("Identity provider of the user.")
  provider: string;
}
