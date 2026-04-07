import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Proposal;

@doc("A ProposalProviderHub resource")
model ProposalResource is TrackedResource<ProposalResourceProperties> {
  @doc("The name of the proposal")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("name")
  @segment("proposals")
  @path
  name: string;
}

@doc("Details of the Proposal Item.")
model ProposalResourceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The proposal product code.")
  productCode: string;

  @doc("The proposal status.")
  status?: ProposalStatus;

  @doc("The date and time when the proposal was created.")
  createdAt?: utcDateTime;

  @doc("The quote identifier associated with the proposal.")
  quoteId?: string;

  @doc("The deal identifier associated with the proposal.")
  dealId?: string;
}

@armResourceOperations(ProposalResource)
interface ProposalResources {
  get is ArmResourceRead<ProposalResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ProposalResource>;
  update is ArmResourcePatchSync<ProposalResource, ProposalResourceProperties>;
  delete is ArmResourceDeleteSync<ProposalResource>;
  listByResourceGroup is ArmResourceListByParent<ProposalResource>;
  listBySubscription is ArmListBySubscription<ProposalResource>;
}
