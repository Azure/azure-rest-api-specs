import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Security;

/**
 * Describes what kind of security agent provisioning action to take
 */
union AutoProvision {
  string,

  /**
   * Install missing security agent on VMs automatically
   */
  On: "On",

  /**
   * Do not install security agent on the VMs automatically
   */
  Off: "Off",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union InformationProtectionPolicyName {
  string,

  /**
   * effective
   */
  effective: "effective",

  /**
   * custom
   */
  custom: "custom",
}

/**
 * The rank of the sensitivity label.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum Rank {
  /**
   * None
   */
  None,

  /**
   * Low
   */
  Low,

  /**
   * Medium
   */
  Medium,

  /**
   * High
   */
  High,

  /**
   * Critical
   */
  Critical,
}

/**
 * List of all the auto provisioning settings response
 */
model AutoProvisioningSettingList {
  /** List of all the auto provisioning settings */
  @pageItems
  value?: AutoProvisioningSetting[];

  /** The URI to fetch the next page. */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * describes properties of an auto provisioning setting
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AutoProvisioningSettingProperties {
  /**
   * Describes what kind of security agent provisioning action to take
   */
  autoProvision: AutoProvision;
}

/**
 * List of Compliance objects response
 */
model ComplianceList {
  /** List of Compliance objects */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: Compliance[];

  /** The URI to fetch the next page. */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * The Compliance score (percentage) of a Subscription is a sum of all Resources' Compliances under the given Subscription. A Resource Compliance is defined as the compliant ('healthy') Policy Definitions out of all Policy Definitions applicable to a given resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ComplianceProperties {
  /**
   * The timestamp when the Compliance calculation was conducted.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  assessmentTimestampUtcDate?: utcDateTime;

  /**
   * The resource count of the given subscription for which the Compliance calculation was conducted (needed for Management Group Compliance calculation).
   */
  @visibility(Lifecycle.Read)
  resourceCount?: int32;

  /**
   * An array of segment, which is the actually the compliance assessment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  assessmentResult?: ComplianceSegment[];
}

/**
 * A segment of a compliance assessment.
 */
model ComplianceSegment {
  /**
   * The segment type, e.g. compliant, non-compliance, insufficient coverage, N/A, etc.
   */
  @visibility(Lifecycle.Read)
  segmentType?: string;

  /**
   * The size (%) of the segment.
   */
  @visibility(Lifecycle.Read)
  percentage?: float64;
}

/**
 * describes properties of an information protection policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InformationProtectionPolicyProperties {
  /**
   * Describes the last UTC time the policy was modified.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedUtc?: utcDateTime;

  /**
   * Describes the version of the policy.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Dictionary of sensitivity labels.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  labels?: Record<SensitivityLabel>;

  /**
   * The sensitivity information types.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  informationTypes?: Record<InformationType>;
}

/**
 * The sensitivity label.
 */
model SensitivityLabel {
  /**
   * The name of the sensitivity label.
   */
  displayName?: string;

  /**
   * The description of the sensitivity label.
   */
  description?: string;

  /**
   * The rank of the sensitivity label.
   */
  rank?: Rank;

  /**
   * The order of the sensitivity label.
   */
  order?: int32;

  /**
   * Indicates whether the label is enabled or not.
   */
  enabled?: boolean;
}

/**
 * The information type.
 */
model InformationType {
  /**
   * The name of the information type.
   */
  displayName?: string;

  /**
   * The description of the information type.
   */
  description?: string;

  /**
   * The order of the information type.
   */
  order?: int32;

  /**
   * The recommended label id to be associated with this information type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  recommendedLabelId?: string;

  /**
   * Indicates whether the information type is enabled or not.
   */
  enabled?: boolean;

  /**
   * Indicates whether the information type is custom or not.
   */
  custom?: boolean;

  /**
   * The information type keywords.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keywords?: InformationProtectionKeyword[];
}

/**
 * The information type keyword.
 */
model InformationProtectionKeyword {
  /**
   * The keyword pattern.
   */
  pattern?: string;

  /**
   * Indicates whether the keyword is custom or not.
   */
  custom?: boolean;

  /**
   * Indicates whether the keyword can be applied on numeric types or not.
   */
  canBeNumeric?: boolean;

  /**
   * Indicates whether the keyword is excluded or not.
   */
  excluded?: boolean;
}

/**
 * Information protection policies response.
 */
model InformationProtectionPolicyList {
  /** List of information protection policies */
  @pageItems
  value?: InformationProtectionPolicy[];

  /** The URI to fetch the next page. */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * List of workspace settings response
 */
model WorkspaceSettingList is Azure.Core.Page<WorkspaceSetting>;

/**
 * Workspace setting data
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkspaceSettingProperties {
  /**
   * The full Azure ID of the workspace to save the data in
   */
  workspaceId: string;

  /**
   * All the VMs in this scope will send their security data to the mentioned workspace unless overridden by a setting with more specific scope
   */
  scope: string;
}
