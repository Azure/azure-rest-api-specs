import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Security;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
model SecureScoresList is Azure.Core.Page<SecureScoreItem>;

/**
 * Describes properties of a calculated secure score.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SecureScoreItemProperties {
  /**
   * The initiative’s name
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
  max?: int32;

  /**
   * Current score
   */
  @visibility(Lifecycle.Read)
  current?: float64;

  /**
   * Ratio of the current score divided by the maximum. Rounded to 4 digits after the decimal point
   */
  @visibility(Lifecycle.Read)
  @maxValue(1)
  percentage?: float64;
}

/**
 * Describes an Azure resource.
 */
model Resource {
  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).
 */
@error
model CloudError {
  /**
   * The error object.
   */
  error?: CloudErrorBody;
}

/**
 * The error detail.
 */
model CloudErrorBody {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The error target.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * The error details.
   */
  @visibility(Lifecycle.Read)
  details?: CloudErrorBody[];

  /**
   * The error additional info.
   */
  @visibility(Lifecycle.Read)
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * The resource management error additional info.
 */
model ErrorAdditionalInfo {
  /**
   * The additional info type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The additional info.
   */
  @visibility(Lifecycle.Read)
  info?: unknown;
}

/**
 * List of security controls
 */
model SecureScoreControlList is Azure.Core.Page<SecureScoreControlDetails>;

/**
 * Details of the security control, its score, and the health status of the relevant resources.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SecureScoreControlDetails extends Resource {
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
  @visibility(Lifecycle.Read)
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
  weight?: int64;

  /**
   * Information about the security control.
   */
  definition?: SecureScoreControlDefinitionItem;
}

/**
 * Information about the security control.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SecureScoreControlDefinitionItem extends Resource {
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
model SecureScoreControlDefinitionList
  is Azure.Core.Page<SecureScoreControlDefinitionItem>;

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
