import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ContainerService;

@doc("An AI Manager namespace.")
@resource("namespaces")
@parentResource(AIManager)
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
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: AIManagerNamespaceProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The underlying managed namespace ID in the Kubernetes cluster.")
  managedNamespaceId?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Records is the most semantically correct choice for this use-case"
  @doc("The labels for the namespace.")
  labels?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Records is the most semantically correct choice for this use-case"
  @doc("The annotations for the namespace.")
  annotations?: Record<string>;

  @doc("The default resource quota for the namespace.")
  resourceQuota?: ResourceQuota;

  @doc("The default network policy for the namespace.")
  defaultNetworkPolicy?: NetworkPolicies;

  @doc("Action if Kubernetes namespace with same name already exists.")
  adoptionPolicy?: AdoptionPolicy;

  @doc("Delete options of the namespace.")
  deletePolicy?: DeletePolicy;
}

@doc("The resource quota for the namespace.")
model ResourceQuota {
  @doc("The CPU request for the namespace. See more at https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-cpu")
  cpuRequest?: string;

  @doc("The CPU limit for the namespace. See more at https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-cpu")
  cpuLimit?: string;

  @doc("The memory request for the namespace. See more at https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-memory")
  memoryRequest?: string;

  @doc("The memory limit for the namespace. See more at https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-memory")
  memoryLimit?: string;

  @doc("The GPU limit for the namespace.")
  gpuLimit?: int32;
}

@doc("Enum representing different network policy rules")
union PolicyRule {
  string,

  @doc("Deny all network traffic.")
  DenyAll: "DenyAll",

  @doc("Allow all network traffic.")
  AllowAll: "AllowAll",

  @doc("Allow traffic within the same namespace.")
  AllowSameNamespace: "AllowSameNamespace",
}

@doc("Default network policy of the namespace, specifying ingress and egress rules.")
model NetworkPolicies {
  @doc("The default ingress network policy for the namespace.")
  ingress?: PolicyRule = PolicyRule.AllowSameNamespace;

  @doc("The default egress network policy for the namespace.")
  egress?: PolicyRule = PolicyRule.AllowAll;
}

@doc("Action if Kubernetes namespace with same name already exists.")
union AdoptionPolicy {
  string,

  @doc("If the namespace already exists in Kubernetes, attempts to create that same namespace in ARM will fail.")
  Never: "Never",

  @doc("If the namespace already exists in Kubernetes, attempts to create that same namespace in ARM will succeed only if there is no difference between the existing namespace and the new ARM resource. If there is any difference, the creation will fail.")
  IfIdentical: "IfIdentical",

  @doc("If the namespace already exists in Kubernetes, attempts to create that same namespace in ARM will succeed and take over the existing namespace to be managed by ARM, even if there are differences between the existing namespace and the new ARM resource. Some fields of the existing namespace might be overwritten.")
  Always: "Always",
}

@doc("Delete options of the namespace.")
union DeletePolicy {
  string,

  @doc("Keep the Kubernetes namespace even if the ARM resource is deleted.")
  Keep: "Keep",

  @doc("Delete both the ARM resource and the Kubernetes namespace together.")
  Delete: "Delete",
}

@doc("The provisioning state of the AI Manager namespace resource.")
union AIManagerNamespaceProvisioningState {
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

  update is ArmCustomPatchAsync<
    AiManagerNamespace,
    AiManagerNamespacePatch,
    Azure.ResourceManager.Foundations.BaseParameters<AiManagerNamespace> &
      IfMatchParameters<AiManagerNamespace>
  >;

  @doc("Lists the credentials of an AI Manager namespace.")
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
