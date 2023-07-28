import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-resource-manager";

import "./base.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.AlicespringsDataplane;

@doc("E4K resource")
model E4kResource is TrackedResource<E4kProperties> {
  @doc("Name of E4K resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("e4kName")
  @path
  @segment("e4k")
  name: string;

  ...ExtendedLocation;
}

@doc("E4k Resource properties")
model E4kProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}
