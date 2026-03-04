import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.ContainerService;

@doc("The AI Manager resource.")
@resource("aiManagers")
model AiManager is TrackedResource<AiManagerProperties> {
  @doc("The name of the AI Manager resource.")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(63)
  @key("aiManagerName")
  @path
  @segment("aiManagers")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;

  ...EntityTagProperty;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "https://github.com/Azure/typespec-azure/issues/2840"
  @doc("Managed identity.")
  identity?: Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@doc("AI Manager properties.")
model AiManagerProperties {
  @doc("Delete options of the AI Manager.")
  deletePolicy?: DeletePolicy;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: AiManagerProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The underlying cluster IDs of the AI Manager.")
  clusterIds?: string[];

  @visibility(Lifecycle.Read)
  @doc("Status information for the AIManager.")
  status?: AiManagerStatus;
}

@doc("Status information for the AiManager.")
model AiManagerStatus {
  @visibility(Lifecycle.Read)
  @doc("The last operation ID for the AiManager.")
  lastOperationId?: string;

  @visibility(Lifecycle.Read)
  @doc("The last operation error for the AiManager.")
  lastOperationError?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@doc("Delete options of the AI Manager.")
union DeletePolicy {
  string,

  @doc("Keep the underlying cluster resources even if the AIManager resource is deleted.")
  Keep: "Keep",

  @doc("Delete both the underlying cluster resources and the AIManager resource together.")
  Delete: "Delete",
}

@doc("The provisioning state of the AI Manager resource.")
union AiManagerProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Resource is being created.")
  Creating: "Creating",

  @doc("Resource is updating.")
  Updating: "Updating",

  @doc("Resource is deleting.")
  Deleting: "Deleting",

  @doc("Resource has been created.")
  Succeeded: "Succeeded",

  @doc("Resource creation failed.")
  Failed: "Failed",

  @doc("Resource creation was canceled.")
  Canceled: "Canceled",
}

@doc("The AI Manager resource patch model.")
model AiManagerPatch {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "https://github.com/Azure/typespec-azure/issues/2840"
  @doc("Managed identity.")
  identity?: Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface AiManagers {
  get is ArmResourceRead<AiManager>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AiManager>;
  update is ArmCustomPatchSync<AiManager, AiManagerPatch>;
  delete is ArmResourceDeleteWithoutOkAsync<AiManager>;
  listByResourceGroup is ArmResourceListByParent<AiManager>;
  listBySubscription is ArmListBySubscription<AiManager>;

  @doc("Lists the credentials of an AI Manager.")
  @post
  @action("ListCredential")
  listCredential is ArmResourceActionSync<
    AiManager,
    void,
    ArmResponse<CredentialResults>
  >;
}
