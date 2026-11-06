import "./Server.tsp";
import "./shared.tsp";
import "@typespec/versioning";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.DBforPostgreSQL;

@doc("Error information from precheck validation.")
@added(Versions.v2026_04_01)
model PrecheckErrorInfo {
  @doc("The error code.")
  errorCode?: int32;

  @doc("The error message.")
  errorMessage?: string;
}

@doc("Upgrade sequence information.")
@added(Versions.v2026_04_01)
model UpgradeSequence {
  @doc("The source PostgreSQL version.")
  @typeChangedFrom(Versions.v2026_10_01, PostgresMajorVersion)
  sourceVersion?: string;

  @doc("The target PostgreSQL version.")
  @typeChangedFrom(Versions.v2026_10_01, PostgresMajorVersion)
  targetVersion?: string;
}

@doc("Precheck result details.")
@added(Versions.v2026_04_01)
model PrecheckResult {
  @doc("The action performed.")
  action?: string;

  @doc("The upgrade sequence information.")
  upgradeSequence?: UpgradeSequence;

  @doc("Array of error information.")
  @identifiers(#["errorCode"])
  errorInfo?: PrecheckErrorInfo[];
}

@doc("Policy validation details.")
@added(Versions.v2026_04_01)
model PolicyDetail {
  @doc("The name of the policy.")
  policyName?: string;

  @doc("Whether the policy validation passed.")
  passed?: boolean;

  @doc("The error code if validation failed.")
  errorCode?: int32;

  @doc("The error message if validation failed.")
  errorMessage?: string;

  @doc("Description of what the policy validates.")
  policyDescription?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Major Version Upgrade Precheck are read-only resources that do not have a provisioning lifecycle."
@doc("Major version upgrade precheck resource with validation results.")
@added(Versions.v2026_04_01)
model MajorVersionUpgradePrecheckResourceProperties {
  @doc("The time when the precheck was created.")
  createTime?: utcDateTime;

  @doc("The status of the precheck validation.")
  status?: MajorVersionUpgradePrecheckStatus;

  @doc("The detailed result of the precheck operation.")
  precheckResult?: PrecheckResult;

  @doc("The target PostgreSQL major version for the upgrade.")
  @typeChangedFrom(Versions.v2026_10_01, PostgresMajorVersion)
  targetVersion?: string;

  @doc("Array of policy validation details.")
  @identifiers(#["policyName"])
  policyDetails?: PolicyDetail[];
}

@doc("Request model for starting a major version upgrade precheck.")
@added(Versions.v2026_04_01)
model StartMajorVersionUpgradePrecheckRequest {
  @doc("The target major version to upgrade to.")
  @typeChangedFrom(Versions.v2026_10_01, PostgresMajorVersion)
  targetVersion: string;
}

@doc("Response model for starting a major version upgrade precheck.")
@added(Versions.v2026_04_01)
model StartMajorVersionUpgradePrecheckResponse {
  @doc("The precheck validation ID.")
  name?: string;

  @doc("The time when the precheck was created.")
  createTime?: utcDateTime;

  @doc("The status of the precheck validation.")
  status?: MajorVersionUpgradePrecheckStatus;
}

@doc("The status of the major version upgrade precheck.")
@added(Versions.v2026_04_01)
union MajorVersionUpgradePrecheckStatus {
  string,

  @doc("Executing prechecks against the source server")
  Validating: "Validating",

  @doc("Validation succeeded")
  Succeeded: "Succeeded",

  @doc("Validation failed")
  Failed: "Failed",

  @doc("Validation canceled")
  Canceled: "Canceled",
}

@doc("Major version upgrade precheck resource for a PostgreSQL flexible server.")
@parentResource(Server)
@added(Versions.v2026_04_01)
model MajorVersionUpgradePrecheckResource
  is Azure.ResourceManager.ProxyResource<MajorVersionUpgradePrecheckResourceProperties> {
  ...ResourceNameParameter<
    MajorVersionUpgradePrecheckResource,
    KeyName = "precheckValidationId",
    SegmentName = "majorVersionUpgradePrecheck",
    NamePattern = "^[a-zA-Z0-9-]{3,36}$"
  >;
}

@doc("Major version upgrade precheck operations for PostgreSQL flexible servers.")
@armResourceOperations
@added(Versions.v2026_04_01)
interface MajorVersionUpgradePrecheck {
  @doc("Gets information about a major version upgrade precheck for a flexible server.")
  get is ArmResourceRead<MajorVersionUpgradePrecheckResource>;

  @doc("Lists major version upgrade prechecks for a flexible server.")
  list is ArmResourceListByParent<MajorVersionUpgradePrecheckResource>;
}
