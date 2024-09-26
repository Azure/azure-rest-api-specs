import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Proposal;

model ProposalExtResource is ExtensionResource<ProposalExtResourceProperties> {
    @doc("The name of the proposal")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    @key("proposalProductCode")
    @segment("proposals")
    @path
    name: string;
  }
  
  @doc("Details of the Proposal ProposalExtResource.")
  model ProposalExtResourceProperties {
    @visibility("read")
    @doc("The status of the last operation.")
    provisioningState?: ProvisioningState;
  
    @doc("The proposal status.")
    status?: ProposalStatus
  }
  
  @armResourceOperations(ProposalExtResource)
  interface ProposalExtResources {
    get is ArmResourceRead<ProposalExtResource>;
    createOrUpdate is ArmResourceCreateOrReplaceAsync<ProposalExtResource>;
    update is ArmResourcePatchSync<ProposalExtResource, ProposalExtResourceProperties>;
    delete is ArmResourceDeleteSync<ProposalExtResource>;
    listByParent is ArmResourceListByParent<ProposalExtResource>;
  }
  
  