import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Proposal;

model ProductResource is ExtensionResource<ProductResourceProperties> {
  @doc("The name of the product")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("productCode")
  @segment("products")
  @path
  name: string;
}

@doc("Details of the Proposal Product Item.")
model ProductResourceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The proposal status.")
  status?: ProposalStatus;
}

@armResourceOperations(ProductResource)
interface ProductResources {
  get is ArmResourceRead<ProductResource>;
}
