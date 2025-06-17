import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;

@doc("The Node Customization resource.")
@resource("nodeCustomizations")
model NodeCustomization is TrackedResource<NodeCustomizationProperties> {
  @doc("The name of the Node Customization resource.")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(63)
  @key("nodeCustomizationName")
  @path
  @segment("nodeCustomizations")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;

  ...EntityTagProperty;
}

@doc("The properties of the Node Customization resource.")
model NodeCustomizationProperties {
  @doc("The OS SKU of the image.")
  @visibility(Lifecycle.Read)
  osSku: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  @doc("The disk size of the image in GB.")
  osDiskSizeGB: int32;

  @doc("The list of container image versions to cache on nodes using this image.")
  containerImages: string[];

  @doc("The scripts to customize the node before or after image capture. Only one script may be specified for each execution point.")
  @extension("x-ms-identifiers", #[])
  customizationScripts?: NodeCustomizationScript[];

  @doc("The user identity that should be assigned to the node when container images are being cached and node customization script is run.")
  identityProfile?: Foundations.UserAssignedIdentity;

  @visibility(Lifecycle.Read)
  @doc("An auto-generated value that changes when the other fields of the image customization are changed.")
  @pattern("^[\\w\\-\\.]+$")
  version?: string;

  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the node customization.")
  provisioningState?: ProvisioningState;
}

@doc("Node customization script")
model NodeCustomizationScript {
  @doc("The stage at which the script is executed.")
  executionPoint: ExecutionPoint;

  @doc("The environment for the script to be executed in.")
  scriptType: ScriptType;

  @doc("The script content.")
  script: string;
}

@doc("The execution point for the script.")
union ExecutionPoint {
  string,

  @doc("Execute during node image build time.")
  nodeImageBuildTime: "NodeImageBuildTime",

  @doc("Execute during node provisioning time.")
  nodeProvisionTime: "NodeProvisionTime",
}

@doc("The script type.")
union ScriptType {
  string,

  @doc("Bash script.")
  bash: "Bash",

  @doc("PowerShell script.")
  powerShell: "PowerShell",
}

@Azure.Core.lroStatus
@doc("The provisioning state of the image customization.")
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Provisioning the resource is in progress")
  Provisioning: "Provisioning",

  @doc("Resource is being updated")
  Updating: "Updating",

  @doc("Resource is being deleted")
  Deleting: "Deleting",

  @doc("The change request has been accepted")
  Accepted: "Accepted",
}

@parentResource(NodeCustomization)
@doc("A version of the Node Customization resource.")
model NodeCustomizationVersion is ProxyResource<NodeCustomizationProperties> {
  @pattern("^[\\w\\-\\.]+$")
  @doc("The version of the Node Customization.")
  @key("version")
  @path
  @segment("versions")
  @visibility(Lifecycle.Read)
  name: string;
}
