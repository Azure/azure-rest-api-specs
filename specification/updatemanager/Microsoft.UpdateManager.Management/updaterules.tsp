import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.UpdateManager;

model UpdateRule is TrackedResource<UpdateRuleProperties> {
  ...ResourceNameParameter<UpdateRule>;
}

@doc("Update rule set properties.")
model UpdateRuleProperties {
  @doc("reboot settings.")
  rebootSetting: rebootSettings;

  @doc("windows parameter.")
  windowsParameters?: WindowsParameters;

  @doc("linux parameter.")
  linuxParameters?: LinuxParameters;

  @doc("policies properties.")
  policies?: Policies;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
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

  @added(Versions.v2025_06_01_preview)
  @doc("This is used to include patches that match the given patch name masks. Alphanumeric strings and wildcard expressions consisting of * and ? are only supported as input values in the list. Null, empty and only whitespaces strings as inputs values are not supported.")
  @maxItems(100)
  patchNameMasksToInclude?: string[];

  @added(Versions.v2025_06_01_preview)
  @doc("This is used to exclude patches that match the given patch name masks. Alphanumeric strings and wildcard expressions consisting of * and ? are only supported as input values in the list. Null, empty and only whitespaces strings as inputs values are not supported.")
  @maxItems(100)
  patchNameMasksToExclude?: string[];
}

@doc("Policies properties.")
model Policies {
  @doc("The availability policy.")
  availability?: Availability;

  @doc("Approve windows patches after the mentioned date.")
  @pattern(
    "(?<!\\w)(2Tuesday)\\+Offset([0-6](?!\\d))(?!\\w)|(?<!\\w)Days(([1-9]|1[0-4])(?!\\d))(?!\\w)",
    "The value must be in the format of '2Tuesday+OffsetY' or 'DaysY' only"
  )
  installWindowsPatchesAfter?: string;
}

@doc("Availability policy.")
model Availability {
  @doc("The availability set.")
  vmAvailabilitySet?: VMAvailabilitySet;
}

@doc("VMAvailabilitySet property.")
union VMAvailabilitySet {
  @doc("Bypass the availability set.")
  Bypass: "Bypass",

  string,
}

@armResourceOperations
interface UpdateRules {
  get is ArmResourceRead<UpdateRule>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<UpdateRule>;
  update is ArmResourcePatchSync<UpdateRule, UpdateRuleProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<UpdateRule>;
  listByResourceGroup is ArmResourceListByParent<UpdateRule>;
  listBySubscription is ArmListBySubscription<UpdateRule>;
}
