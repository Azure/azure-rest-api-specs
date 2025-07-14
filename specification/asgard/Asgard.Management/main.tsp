import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.Asgard Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.Asgard management service" })
@versioned(Versions)
namespace Microsoft.Asgard;

/** Asgard API versions */
enum Versions {
  /** 2025-04-01-preview */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_04_01_preview: "2025-04-01-preview",
}

@doc("Node type doc")
union NodeType {
  @doc("Warp Node")
  WarpNode: "WarpNode",

  @doc("PilotFish node name")
  PilotFishNode: "PilotFishNode",

  string,
}

@doc("Provisioning state enum")
union ProvisioningState {
  @doc("The resource action is successful.")
  Succeeded: "Succeeded",

  @doc("The resource action has failed.")
  Failed: "Failed",

  @doc("The resource action has been cancelled.")
  Canceled: "Canceled",

  @doc("The resource provisioning has been accepted.")
  Accepted: "Accepted",

  @doc("The resource is being created.")
  Creating: "Creating",

  @doc("The resource is being updated.")
  Updating: "Updating",

  @doc("The resource is being deleted.")
  Deleting: "Deleting",

  @doc("The resource has been deleted.")
  Deleted: "Deleted",

  @doc("The resource status is unspecified.")
  NotSpecified: "NotSpecified",

  string,
}

@doc("Asgard Node Properties")
model AsgardNodeProperties {
  @doc("node logical name")
  nodeLogicalNameName: string;

  @doc("node name")
  nodeName: string;

  @doc("Node type")
  @visibility(Lifecycle.Read)
  nodeType: NodeType;

  @doc("tenant")
  tenantName: string;

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Asgard Cluster Properties")
model AsgardClusterProperties {
  @doc("Cluster name")
  clusterName: string;

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

alias resourceNameRegex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{1,58}[a-zA-Z0-9]$";

@parentResource(TenantLocationResource)
model AsgardClusterResource
  is Azure.ResourceManager.ProxyResource<AsgardClusterProperties> {
  @key("clusterName")
  @segment("clusters")
  @path
  @pattern(resourceNameRegex)
  @doc("name")
  name: string;
}

@parentResource(AsgardClusterResource)
model AsgardNodeResource
  is Azure.ResourceManager.ProxyResource<AsgardNodeProperties> {
  @key("nodeName")
  @segment("nodes")
  @path
  @pattern(resourceNameRegex)
  @doc("name")
  name: string;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface AsgardCluster {
  get is ArmResourceRead<AsgardClusterResource>;
  list is ArmResourceListByParent<AsgardClusterResource>;
}

@armResourceOperations
interface AsgardNode {
  get is ArmResourceRead<AsgardNodeResource>;
  list is ArmResourceListByParent<AsgardNodeResource>;
}
