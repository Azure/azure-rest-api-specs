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

@doc("The AI Manager resource. For more information, see https://aka.ms/aks/aimanager.")
@resource("aiManagers")
model AIManager is TrackedResource<AIManagerProperties> {
  ...ResourceNameParameter<
    Resource = AIManager,
    KeyName = "aiManagerName",
    SegmentName = "aiManagers",
    NamePattern = "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
  >;
  ...EntityTagProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

scalar ClusterResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/managedClusters",
    }
  ]>;

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIManager is a valid name"
@doc("AI Manager properties.")
model AIManagerProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: AIManagerProvisioningState;

  @doc("Delete options of the AI Manager. Defaults to `Delete` if not specified.")
  deletePolicy?: DeletePolicy;

  @visibility(Lifecycle.Read)
  @doc("The name of the managed resource group created by the AI Manager to hold underlying infrastructure resources.")
  managedResourceGroupName?: string;

  @added(Versions.v2026_08_02_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("""
    The ARM resource ID of an existing AKS cluster to attach (bring-your-own). When omitted, AI Manager provisions and manages its own underlying cluster. The referenced cluster must be in the same region as this AI Manager, but may reside in a different subscription within the same Microsoft Entra tenant. This property is immutable after creation.
    """)
  clusterResourceId?: ClusterResourceId;
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
union AIManagerProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Resource is being created.")
  Creating: "Creating",

  @doc("Resource is updating.")
  Updating: "Updating",

  @doc("Resource is deleting.")
  Deleting: "Deleting",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIManager is a valid name"
@doc("The AI Manager resource patch model.")
model AIManagerPatch {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface AIManagers {
  get is ArmResourceRead<AIManager>;

  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AIManager,
    Azure.ResourceManager.Foundations.BaseParameters<AIManager> &
      IfMatchParameters<AIManager> &
      IfNoneMatchParameters<AIManager>
  >;

  update is ArmCustomPatchSync<
    AIManager,
    AIManagerPatch,
    Azure.ResourceManager.Foundations.BaseParameters<AIManager> &
      IfMatchParameters<AIManager>
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    AIManager,
    Azure.ResourceManager.Foundations.BaseParameters<AIManager> &
      IfMatchParameters<AIManager>
  >;

  listByResourceGroup is ArmResourceListByParent<AIManager>;
  listBySubscription is ArmListBySubscription<AIManager>;

  @doc("Lists the credentials of an AI Manager.")
  @post
  @action("listCredential")
  listCredential is ArmResourceActionSync<
    AIManager,
    void,
    ArmResponse<CredentialResults>
  >;
}

@@maxLength(AIManager.name, 63);
@@minLength(AIManager.name, 1);
@@doc(AIManager.name, "The name of the AI Manager resource.");
