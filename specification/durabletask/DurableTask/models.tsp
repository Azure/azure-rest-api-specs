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
}

@doc("The update properties of the Namespace.")
model NamespacePropertiesUpdate {
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
union ProvisioningState {
    string,
  
    /**
     * Resource has been created.
     */
    Succeeded: "Succeeded",
  
    /**
     * Resource creation failed.
     */
    Failed: "Failed",
  
    /**
     * Resource creation was canceled.
     */
    Canceled: "Canceled",
  
    /**
     * The resource is being provisioned
     */
    Provisioning: "Provisioning",
  
    /**
     * The resource is being updated
     */
    Updating: "Updating",
  
    /**
     * The resource is being deleted
     */
    Deleting: "Deleting",
  
    /**
     * The resource create request has been accepted
     */
    Accepted: "Accepted",
  }
