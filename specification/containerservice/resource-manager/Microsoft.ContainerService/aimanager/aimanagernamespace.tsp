import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ContainerService;

@doc("The AI Manager namespace.")
@resource("namespaces")
@parentResource(AiManager)
model AiManagerNamespace is TrackedResource<AiManagerNamespaceProperties> {
  @doc("The name of the AI Manager namespace resource.")
  @key("namespaceName")
  @segment("namespaces")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(63)
  @path
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;

  ...EntityTagProperty;
}

@doc("The properties of an AI Manager namespace.")
model AiManagerNamespaceProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Records is the most semantically correct choice for this use-case"
  @doc("The labels for the namespace.")
  labels?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Records is the most semantically correct choice for this use-case"
  @doc("The annotations for the namespace.")
  annotations?: Record<string>;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: AiManagerNamespaceProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The underlying managed namespace ID in the Kubernetes cluster.")
  managedNamespaceId?: string;

  @visibility(Lifecycle.Read)
  @doc("Status information for the AiManager.")
  status?: AiManagerNamespaceStatus;
}

@doc("Status information for the AiManagerNamespace.")
model AiManagerNamespaceStatus {
  @visibility(Lifecycle.Read)
  @doc("The last operation ID for the AiManagerNamespace.")
  lastOperationId?: string;

  @visibility(Lifecycle.Read)
  @doc("The last operation error for the AiManagerNamespace.")
  lastOperationError?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@doc("The provisioning state of the AI Manager namespace resource.")
union AiManagerNamespaceProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The provisioning state of a namespace being created.")
  Creating: "Creating",

  @doc("The provisioning state of a namespace being updated.")
  Updating: "Updating",

  @doc("The provisioning state of a namespace being deleted.")
  Deleting: "Deleting",

  @doc("The namespace has been created.")
  Succeeded: "Succeeded",

  @doc("The namespace creation failed.")
  Failed: "Failed",

  @doc("The namespace creation was canceled.")
  Canceled: "Canceled",
}

@armResourceOperations
interface AiManagerNamespaces {
  get is ArmResourceRead<AiManagerNamespace>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    AiManagerNamespace,
    Azure.ResourceManager.Foundations.BaseParameters<AiManagerNamespace> &
      IfMatchParameters<AiManagerNamespace> &
      IfNoneMatchParameters<AiManagerNamespace>
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    AiManagerNamespace,
    Azure.ResourceManager.Foundations.BaseParameters<AiManagerNamespace> &
      IfMatchParameters<AiManagerNamespace>
  >;

  listByAiManager is ArmResourceListByParent<AiManagerNamespace>;

  update is ArmCustomPatchSync<
    AiManagerNamespace,
    AiManagerNamespacePatch,
    Azure.ResourceManager.Foundations.BaseParameters<AiManagerNamespace> &
      IfMatchParameters<AiManagerNamespace>
  >;

  @doc("Lists the credentials of an AI Manager namespace.")
  @post
  listCredential is ArmResourceActionSync<
    AiManagerNamespace,
    void,
    ArmResponse<CredentialResults>
  >;
}

@doc("The properties of an AI Manager namespace that can be patched.")
model AiManagerNamespacePatch {
  /* The ARM tags of the AI Manager namespace resource.*/
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
