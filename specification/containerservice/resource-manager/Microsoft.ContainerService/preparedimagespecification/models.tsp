import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ContainerService;

@doc("The Prepared Image Specification resource.")
@resource("preparedImageSpecifications")
model PreparedImageSpecification
  is TrackedResource<PreparedImageSpecificationProperties> {
  @doc("The name of the Prepared Image Specification resource.")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(63)
  @key("preparedImageSpecificationName")
  @path
  @segment("preparedImageSpecifications")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;

  ...EntityTagProperty;
}

@doc("The properties of the Prepared Image Specification resource.")
model PreparedImageSpecificationProperties {
  @doc("The list of container images to cache on nodes. See https://kubernetes.io/docs/concepts/containers/images/#image-names")
  containerImages?: string[];

  @doc("""
    The identity used to execute prepared image specification tasks during image build time and provisioning time. 
    If not specified the default agentpool identity will be used.
    This does not affect provisioned nodes.
    """)
  identityProfile?: PreparedImageSpecificationManagedIdentityProfile;

  @visibility(Lifecycle.Read)
  @doc("An auto-generated value that changes when the other fields of the image customization are changed.")
  @pattern("^(?![.-])[A-Za-z0-9_.-]{1,128}$")
  version?: string;

  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the prepared image specification.")
  provisioningState?: ProvisioningState;

  @doc("The scripts to customize the node before or after image capture.")
  @identifiers(#[])
  customizationScripts?: PreparedImageSpecificationScript[];
}

@doc("The managed identity profile used by the prepared image specification.")
model PreparedImageSpecificationManagedIdentityProfile {
  @doc("The resource ID of the user-assigned managed identity.")
  resourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  @visibility(Lifecycle.Read)
  @doc("The object ID of the managed identity.")
  objectId?: Azure.Core.uuid;

  @visibility(Lifecycle.Read)
  @doc("The client ID of the managed identity.")
  clientId?: Azure.Core.uuid;
}

@doc("The managed identity profile used by the prepared image specification for update operations.")
model PreparedImageSpecificationManagedIdentityProfileUpdate {
  @doc("The resource ID of the user-assigned managed identity.")
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

@doc("Prepared image specification script")
model PreparedImageSpecificationScript {
  @doc("""
    The name for the customization script. 
    Must be unique within the prepared image specification resource.
    Can only contain lowercase alphanumeric,'-' or '.' characters.
    """)
  @pattern("^[a-z0-9]([a-z0-9\\.\\-]*[a-z0-9])?$")
  @maxLength(263)
  @key("preparedImageSpecificationScriptName")
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
  @example("echo 'initializing node'")
  script?: string;

  @doc("Whether the node should reboot after successful script execution.")
  rebootAfter?: boolean;
}

@doc("Prepared image specification script for update operations")
model PreparedImageSpecificationScriptUpdate {
  @doc("The name for the customization script.")
  @pattern("^[a-z0-9]([a-z0-9\\.\\-]*[a-z0-9])?$")
  @maxLength(263)
  name?: string;

  @doc("The stage at which the script is executed.")
  executionPoint?: ExecutionPoint;

  @doc("The runtime environment for the script (e.g. Bash).")
  @example("Bash")
  scriptType?: ScriptType;

  @doc("The script content to be executed in plain text. Do not include secrets.")
  @example("echo 'initializing node'")
  script?: string;

  @doc("Whether the node should reboot after successful script execution.")
  rebootAfter?: boolean;
}

@doc("The updatable properties of the Prepared Image Specification resource.")
model PreparedImageSpecificationPatchProperties {
  @doc("The list of container images to cache on nodes. See https://kubernetes.io/docs/concepts/containers/images/#image-names")
  containerImages?: string[];

  @doc("The identity used to execute prepared image specification tasks during image build time and provisioning time.")
  identityProfile?: PreparedImageSpecificationManagedIdentityProfileUpdate;

  @doc("The scripts to customize the node before or after image capture.")
  @identifiers(#[])
  customizationScripts?: PreparedImageSpecificationScriptUpdate[];
}

@doc("Prepared image specification patch resource")
model PreparedImageSpecificationPatch {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  @doc("Patchable prepared image specification properties.")
  properties?: PreparedImageSpecificationPatchProperties;
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

@parentResource(PreparedImageSpecification)
@doc("A version of the Prepared Image Specification resource.")
model PreparedImageSpecificationVersion
  is ProxyResource<PreparedImageSpecificationProperties> {
  @pattern("^(?![.-])[A-Za-z0-9_.-]{1,128}$")
  @minLength(1)
  @maxLength(128)
  @doc("The version of the Prepared Image Specification.")
  @key("version")
  @path
  @segment("versions")
  @visibility(Lifecycle.Read)
  name: string;
}
