import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/identity.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Resources.Identity;

@doc("Identity resource model.")
@resource("identity")
model IdentityResource extends IdentityResult {
  @doc("Configuration content identifier.")
  @key("default")
  @visibility("query")
  default: "";
}

interface Identities {
  @doc("Identity of current user.")
  getIdentity is ResourceRead<IdentityResource>;
}
