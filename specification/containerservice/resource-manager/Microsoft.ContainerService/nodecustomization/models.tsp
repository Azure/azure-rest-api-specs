import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

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
  @doc("The list of container images to cache on nodes. See https://kubernetes.io/docs/concepts/containers/images/#image-names")
  containerImages?: string[];

  @doc("""
    The identity used to execute node customization tasks during image build time and provisioning time. 
    If not specified the default agentpool identity will be used.
    This does not affect provisioned nodes.
    """)
  identityProfile?: Foundations.UserAssignedIdentity;

  @visibility(Lifecycle.Read)
  @doc("An auto-generated value that changes when the other fields of the image customization are changed.")
  @pattern("^[\\w\\-\\.]+$")
  version?: string;

  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the node customization.")
  provisioningState?: ProvisioningState;

  @doc("The scripts to customize the node before or after image capture.")
  @identifiers(#[])
  customizationScripts?: NodeCustomizationScript[];
}

@doc("Node customization script")
model NodeCustomizationScript {
  @doc("""
    The name for the customization script. 
    Must be unique within the node customization resource.
    Can only contain lowercase alphanumeric,'-' or '.' characters.
    """)
  @pattern("^[a-z0-9]([a-z0-9\\.\\-]*[a-z0-9])?$")
  @maxLength(263)
  @key("nodeCustomizationScriptName")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;

  @doc("""
    The stage at which the script is executed.
    Specifying \`NodeImageBuildTime\` will ensure changes are persisted into the node image.
    """)
  executionPoint: ExecutionPoint;

  @doc("The runtime environment for the script (e.g. Bash).")
  @example("Bash")
  scriptType: ScriptType;

  @doc("The script content to be executed in plain text. Do not include secrets.")
  @example("touch /hello_world.txt")
  script?: string;

  @doc("Whether the node should reboot after successful script execution.")
  rebootAfter?: boolean;
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
  @minLength(1)
  @maxLength(64)
  @doc("The version of the Node Customization.")
  @key("version")
  @path
  @segment("versions")
  @visibility(Lifecycle.Read)
  name: string;
}
