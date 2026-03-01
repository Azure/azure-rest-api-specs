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
model AIManager is TrackedResource<AIManagerProperties> {
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

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Existing usage of legacy type"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "https://github.com/Azure/typespec-azure/issues/2840"
  @doc("Managed identity.")
  identity?: Azure.ResourceManager.Legacy.ManagedServiceIdentityV4;
}

@doc("AI Manager properties.")
model AIManagerProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: AIManagerProvisioningState;
  @visibility(Lifecycle.Read)
  @doc("The underlying cluster ID of the AI Manager.")
  ClusterID?: string;
  @doc("The ID of the subnet that will be joined by system nodes managed and hosted by AKS for running critical system addons. This ID must be provided together with `nodeSubnetID` and `apiserverSubnetId`, and all three subnet IDs must belong to the same VNet. If you don’t specify it, AKS will create a subnet in the managed resource group using a default /24 CIDR.")
  SystemNodeSubnetID?: string;

  @doc("The ID of the subnet that will be joined by nodes managed and hosted by AKS. This ID must be provided together with `systemNodeSubnetID` and `apiserverSubnetId`, and all three subnet IDs must belong to the same VNet. If you don't specify it, AKS will create a subnet in the managed resource group using a default /24 CIDR.")
  NodeSubnetID?: string;

  @doc("The ID of the subnet for the API server. This ID must be provided together with `systemNodeSubnetID` and `nodeSubnetID`, and all three subnet IDs must belong to the same VNet. If you don't specify it, AKS will create a subnet in the managed resource group using a default /24 CIDR.")
  ApiserverSubnetID?: string;
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

@armResourceOperations
interface AIManagers {
  get is ArmResourceRead<AIManager>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AIManager>;
  update is ArmResourcePatchAsync<AIManager, AIManagerProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<AIManager>;
  listByResourceGroup is ArmResourceListByParent<AIManager>;
  listBySubscription is ArmListBySubscription<AIManager>;

  @doc("Lists the user credentials of an AI Manager.")
  @action("listClusterUserCredential")
  listClusterUserCredentials is ArmResourceActionSync<
    AIManager,
    void,
    ArmResponse<CredentialResults>,
    Parameters = {
      @doc("Server FQDN type for credentials to be returned.")
      @query("server-fqdn")
      serverFqdn?: string;

      @doc("Only apply to AAD clusters, specifies the format of returned kubeconfig. Format 'azure' will return azure auth-provider kubeconfig; format 'exec' will return exec format kubeconfig, which requires kubelogin binary in the path.")
      @query("format")
      format?: Format;
    }
  >;
}
