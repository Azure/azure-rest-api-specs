import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Security;

/**
 * Microsoft information protection integration status
 */
union MipIntegrationStatus {
  string,

  /**
   * Ok
   */
  Ok: "Ok",

  /**
   * noConsent
   */
  noConsent: "noConsent",

  /**
   * noAutoLabelingRules
   */
  noAutoLabelingRules: "noAutoLabelingRules",

  /**
   * noMipLabels
   */
  noMipLabels: "noMipLabels",
}

/**
 * Request to update data sensitivity settings for sensitive data discovery
 */
model UpdateSensitivitySettingsRequest {
  /**
   * List of selected sensitive info types' IDs.
   */
  sensitiveInfoTypesIds: Azure.Core.uuid[];

  /**
   * The order of the sensitivity threshold label. Any label at or above this order will be considered sensitive. If set to -1, sensitivity by labels is turned off
   */
  sensitivityThresholdLabelOrder?: float32;

  /**
   * The id of the sensitivity threshold label. Any label at or above this rank will be considered sensitive.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  sensitivityThresholdLabelId?: string;
}

/**
 * The sensitivity settings properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GetSensitivitySettingsResponseProperties {
  /**
   * List of selected sensitive info types' IDs.
   */
  sensitiveInfoTypesIds?: Azure.Core.uuid[];

  /**
   * The order of the sensitivity threshold label. Any label at or above this order will be considered sensitive. If set to -1, sensitivity by labels is turned off
   */
  sensitivityThresholdLabelOrder?: float32;

  /**
   * The id of the sensitivity threshold label. Any label at or above this rank will be considered sensitive.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  sensitivityThresholdLabelId?: string;

  /**
   * Microsoft information protection built-in and custom information types, labels, and integration status.
   */
  mipInformation?: GetSensitivitySettingsResponsePropertiesMipInformation;
}

/**
 * Microsoft information protection built-in and custom information types, labels, and integration status.
 */
model GetSensitivitySettingsResponsePropertiesMipInformation {
  /**
   * Microsoft information protection integration status
   */
  mipIntegrationStatus?: MipIntegrationStatus;

  /**
   * List of Microsoft information protection sensitivity labels
   */
  labels?: Label[];

  /**
   * List of custom user-defined information types
   */
  customInfoTypes?: InfoType[];

  /**
   * List of pre-configured sensitive information types
   */
  builtInInfoTypes?: BuiltInInfoType[];
}

/**
 * Microsoft information protection sensitivity label
 */
model Label {
  /**
   * The display name of the label
   */
  name?: string;

  /**
   * The ID of the label
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  id?: string;

  /**
   * Labels are ordered by sensitivity level. The higher the order of the label, the more sensitive it is.
   */
  order?: float32;
}

/**
 * Custom user-defined information type
 */
model InfoType {
  /**
   * Display name of the info type
   */
  name?: string;

  /**
   * Id of the info type
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  id?: string;

  /**
   * Description of the info type
   */
  description?: string;
}

/**
 * Pre-configured sensitive information type
 */
model BuiltInInfoType {
  /**
   * Display name of the info type
   */
  name?: string;

  /**
   * Id of the info type
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  id?: string;

  /**
   * Category of the built-in info type
   */
  type?: string;
}

/**
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
@Azure.ResourceManager.Legacy.armExternalType
model CloudError {
  /**
   * The error object.
   */
  error?: CloudErrorBody;
}

/**
 * The error detail.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  details?: CloudErrorBody[];

  /**
   * The error additional info.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  info?: unknown;
}

/**
 * A list with a single sensitivity settings resource
 */
model GetSensitivitySettingsListResponse {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  value?: GetSensitivitySettingsResponse[];
}
