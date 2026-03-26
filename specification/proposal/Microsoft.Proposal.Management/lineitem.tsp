import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./proposal.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Proposal;

@doc("A LineItem resource nested under a Proposal.")
@parentResource(ProposalResource)
model LineItemResource is ProxyResource<LineItemResourceProperties> {
  @doc("The name of the line item.")
  @key("lineItemName")
  @segment("lineItems")
  @pattern("^[a-zA-Z0-9-]{1,64}$")
  @path
  name: string;
}

@doc("Properties of the LineItem resource.")
model LineItemResourceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The product code of the line item.")
  productCode: string;

  @doc("The status of the line item.")
  status: LineItemStatus;

  @doc("The resource URI of the ARM resource associated with the line item.")
  resourceUri?: armResourceIdentifier;
}

@armResourceOperations(LineItemResource)
interface LineItemResources {
  get is ArmResourceRead<LineItemResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<LineItemResource>;
  update is ArmResourcePatchSync<LineItemResource, LineItemResourceProperties>;
  delete is ArmResourceDeleteSync<LineItemResource>;
  listByParent is ArmResourceListByParent<LineItemResource>;
}
