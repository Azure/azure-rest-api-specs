import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Common;

namespace SensitivitySettingsAPI;

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
 * A list with a single sensitivity settings resource
 */
model GetSensitivitySettingsListResponse {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  value?: GetSensitivitySettingsResponse[];
}

