import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.UpdateManager;

model UpdateRule is TrackedResource<UpdateRuleProperties> {
  ...ResourceNameParameter<UpdateRule>;
}

@doc("Update rule set properties.")
model UpdateRuleProperties {
  @doc("reboot settings.")
  rebootSettings?: rebootSettings;

  @doc("windows parameter.")
  windowsParameters?: WindowsParameters;

  @doc("linux parameter.")
  linuxParameters?: LinuxParameters;

  @doc("Approve patches after days.")
  @minValue(0)
  @maxValue(35)
  approvePatchesAfterDays?: int32;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Reboot settings.")
union rebootSettings {
  @doc("Reboot if required")
  IfRequired: "IfRequired",

  @doc("Never reboot")
  Never: "Never",

  @doc("Always reboot")
  Always: "Always",

  string,
}

@doc("Linux parameters.")
model LinuxParameters {
  @doc("The package name masks to exclude.")
  @maxItems(100)
  packageNameMasksToExclude?: string[];

  @doc("The package name masks to include.")
  @maxItems(100)
  packageNameMasksToInclude?: string[];

  @doc("The classifications to include.")
  classificationsToInclude?: string[];
}

@doc("Windows parameters.")
model WindowsParameters {
  @doc("The KB numbers to exclude.")
  @maxItems(100)
  kbNumbersToExclude?: string[];

  @doc("The KB numbers to include.")
  @maxItems(100)
  kbNumbersToInclude?: string[];

  @doc("The classifications to include.")
  classificationsToInclude?: string[];

  @doc("Exclude KBs requiring reboot.")
  excludeKbsRequiringReboot?: boolean;
}

@lroStatus
@doc("The provisioning state.")
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned. */
  Provisioning: "Provisioning",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  /** The resource provisioning request has been accepted. */
  Accepted: "Accepted",

  string,
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface UpdateRules {
  get is ArmResourceRead<UpdateRule>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<UpdateRule>;
  update is ArmResourcePatchSync<UpdateRule, UpdateRuleProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<UpdateRule>;
  listByResourceGroup is ArmResourceListByParent<UpdateRule>;
  listBySubscription is ArmListBySubscription<UpdateRule>;
}
