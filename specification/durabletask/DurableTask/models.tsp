import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;

namespace Microsoft.DurableTask;

interface Operations extends Azure.ResourceManager.Operations {}


@doc("Details of the Namespace.")
model NamespaceProperties {
	@visibility("read")
	@doc("The status of the last operation.")
	provisioningState?: ProvisioningState;

	@doc("url of the durable task service")
	@visibility("read")
	url?: string;

    @doc("task hubs list for durable task service")
    taskHubs?: TaskHub[];

    @doc("IP allow list for durable task service")
    ipAllowlist?: string[];
}



@doc("The properties of TaskHub")
model TaskHubProperties {
	@visibility("read")
	@doc("The status of the last operation.")
	provisioningState?: ProvisioningState;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The resource is being provisioned")
  Provisioning: "Provisioning",

  @doc("The resource is updating")
  Updating: "Updating",

  @doc("The resource is being deleted")
  Deleting: "Deleting",

  @doc("The resource create request has been accepted")
  Accepted: "Accepted",
}