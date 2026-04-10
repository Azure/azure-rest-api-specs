import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Common;

namespace SecureScoreAPI;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ExpandControlsEnum {
  string,

  /**
   * Add definition object for each control
   */
  definition: "definition",
}

/**
 * The type of security control (for example, BuiltIn)
 */
union ControlType {
  string,

  /**
   * Microsoft Defender for Cloud managed assessments
   */
  BuiltIn: "BuiltIn",

  /**
   * Non Microsoft Defender for Cloud managed assessments
   */
  Custom: "Custom",
}

/**
 * List of secure scores
 */
model SecureScoresList {
  /**
   * Collection of secure scores in this page
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: SecureScoreItem[];

  /**
   * The URI to fetch the next page.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Describes properties of a calculated secure score.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecureScoreItemProperties {
  /**
   * The initiativeâ€™s name
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * score object
   */
  @visibility(Lifecycle.Read)
  score?: ScoreDetails;

  /**
   * The relative weight for each subscription. Used when calculating an aggregated secure score for multiple subscriptions.
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  weight?: int64;
}

/**
 * Calculation result data
 */
model ScoreDetails {
  /**
   * Maximum score available
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  max?: int32;

  /**
   * Current score
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  current?: float64;

  /**
   * Ratio of the current score divided by the maximum. Rounded to 4 digits after the decimal point
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(1)
  percentage?: float64;
}

/**
 * List of security controls
 */
model SecureScoreControlList {
  /**
   * Collection of security controls in this page
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: SecureScoreControlDetails[];

  /**
   * The URI to fetch the next page.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Details of the security control, its score, and the health status of the relevant resources.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecureScoreControlDetails extends Azure.ResourceManager.Foundations.Resource {
  /**
   * Calculation result data in control level
   */
  properties?: SecureScoreControlScoreDetails;
}

/**
 * Calculation result data in control level
 */
model SecureScoreControlScoreDetails {
  /**
   * User friendly display name of the control
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Actual score object for the control
   */
  score?: ScoreDetails;

  /**
   * Number of healthy resources in the control
   */
  @visibility(Lifecycle.Read)
  healthyResourceCount?: int32;

  /**
   * Number of unhealthy resources in the control
   */
  @visibility(Lifecycle.Read)
  unhealthyResourceCount?: int32;

  /**
   * Number of not applicable resources in the control
   */
  @visibility(Lifecycle.Read)
  notApplicableResourceCount?: int32;

  /**
   * The relative weight for this specific control in each of your subscriptions. Used when calculating an aggregated score for this control across all of your subscriptions.
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  weight?: int64;

  /**
   * Information about the security control.
   */
  definition?: SecureScoreControlDefinitionItem;
}

/**
 * Information about the security control.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecureScoreControlDefinitionItem extends Azure.ResourceManager.Foundations.Resource {
  /**
   * Security Control Definition Properties.
   */
  properties?: SecureScoreControlDefinitionItemProperties;
}

/**
 * Security Control Definition Properties.
 */
model SecureScoreControlDefinitionItemProperties {
  /**
   * User friendly display name of the control
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * User friendly description of the control
   */
  @visibility(Lifecycle.Read)
  @maxLength(256)
  description?: string;

  /**
   * Maximum control score (0..10)
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(10)
  maxScore?: int32;

  /**
   * Source object from which the control was created
   */
  @visibility(Lifecycle.Read)
  source?: SecureScoreControlDefinitionSource;

  /**
   * Array of assessments metadata IDs that are included in this security control
   */
  @visibility(Lifecycle.Read)
  assessmentDefinitions?: AzureResourceLink[];
}

/**
 * The type of the security control (For example, BuiltIn)
 */
model SecureScoreControlDefinitionSource {
  /**
   * The type of security control (for example, BuiltIn)
   */
  sourceType?: ControlType;
}

/**
 * Describes an Azure resource with kind
 */
model AzureResourceLink {
  /**
   * Azure resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * List of security controls definition
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model secureScoreControlDefinitionList {
  /**
   * Collection of security control definitions.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SecureScoreControlDefinitionItem[];

  /**
   * The URL to get the next page of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Calculation result data
 */
model SecureScoreControlScore {
  /**
   * Maximum control score (0..10)
   */
  @visibility(Lifecycle.Read)
  @maxValue(10)
  max?: int32;

  /**
   * Actual score for the control = (achieved points / total points) * max score. if total points is zeroed, the return number is 0.00
   */
  @visibility(Lifecycle.Read)
  @maxValue(10)
  current?: float64;

  /**
   * Ratio of the current score divided by the maximum. Rounded to 4 digits after the decimal point
   */
  @visibility(Lifecycle.Read)
  @maxValue(1)
  percentage?: float64;
}



