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
model AIManager is TrackedResource<AiManagerProperties> {
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
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: AIManagerProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The underlying cluster ID of the AI Manager.")
  clusterId?: string;

  @doc("The ID of the subnet that will be joined by system nodes managed and hosted by AKS for running critical system addons. This ID must be provided together with `nodeSubnetID` and `apiserverSubnetId`, and all three subnet IDs must belong to the same VNet. If you don’t specify it, AKS will create a subnet in the managed resource group using a default /24 CIDR.")
  systemNodeSubnetId?: string;

  @doc("The ID of the subnet that will be joined by nodes managed and hosted by AKS. This ID must be provided together with `systemNodeSubnetID` and `apiserverSubnetId`, and all three subnet IDs must belong to the same VNet. If you don't specify it, AKS will create a subnet in the managed resource group using a default /24 CIDR.")
  nodeSubnetId?: string;

  @doc("The ID of the subnet for the API server. This ID must be provided together with `systemNodeSubnetID` and `nodeSubnetID`, and all three subnet IDs must belong to the same VNet. If you don't specify it, AKS will create a subnet in the managed resource group using a default /24 CIDR.")
  apiserverSubnetId?: string;
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

  @doc("The resource-specific properties for this resource.")
  properties?: AiManagerProperties;
}

@armResourceOperations
interface AiManagers {
  get is ArmResourceRead<AIManager>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AIManager>;
  update is ArmCustomPatchAsync<AIManager, AiManagerPatch>;
  delete is ArmResourceDeleteWithoutOkAsync<AIManager>;
  listByResourceGroup is ArmResourceListByParent<AIManager>;
  listBySubscription is ArmListBySubscription<AIManager>;

  @doc("Lists the credentials of an AI Manager.")
  @post
  @action("ListCredential")
  listCredential is ArmResourceActionSync<
    AIManager,
    void,
    ArmResponse<CredentialResults>
  >;
}
