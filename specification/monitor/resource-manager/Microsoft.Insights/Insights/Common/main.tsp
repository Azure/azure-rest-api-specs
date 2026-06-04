import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Role based access control provides you a way to apply granular level policy administration down to individual resources or resource groups. These operations enable you to manage role assignments. A role assignment grants access to Azure Active Directory users.
 */
namespace Microsoft.Common;

/**
 * Specifies the type of threshold criteria. Previously undocumented values might be returned
 */
union CriterionType {
  string,

  /**
   * StaticThresholdCriterion
   */
  StaticThresholdCriterion: "StaticThresholdCriterion",

  /**
   * DynamicThresholdCriterion
   */
  DynamicThresholdCriterion: "DynamicThresholdCriterion",
}

/**
 * Type of managed service identity.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum IdentityType {
  /**
   * SystemAssigned
   */
  SystemAssigned,

  /**
   * UserAssigned
   */
  UserAssigned,

  /**
   * None
   */
  None,
}

/**
 * Properties of the user assigned identity.
 */
model UserIdentityProperties {
  /**
   * The principal ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Type of managed service identity.
   */
  type: IdentityType;

  /**
   * The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserIdentityProperties>;
}

/**
 * The localizable string class.
 */
model LocalizableString {
  /**
   * the invariant value.
   */
  value: string;

  /**
   * the locale specific value.
   */
  localizedValue?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ResultType {
  /**
   * Data
   */
  Data,

  /**
   * Metadata
   */
  Metadata,
}

/**
 * Specifies the retention policy for the log.
 */
model RetentionPolicy {
  /**
   * a value indicating whether the retention policy is enabled.
   */
  enabled: boolean;

  /**
   * the number of days for the retention in days. A value of 0 will retain the events indefinitely.
   */
  @minValue(0)
  days: int32;
}

/**
 * Describes the format of Error response.
 */
@error
model ErrorResponse {
  /**
   * Error code
   */
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  message?: string;
}

/**
 * Describes details of an error response.
 */
model ErrorDetail {
  /**
   * Unlocalized string which can be used to programmatically identify the error.
   */
  code?: string;

  /**
   * Describes the error in detail and provides debugging information.
   */
  message?: string;

  /**
   * The target of the particular error (for example, the name of the property in error).
   */
  target?: string;

  /**
   * An array of objects with 'type' and 'info' properties. The schema of 'info' is service-specific and dependent on the 'type' string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalInfo?: ErrorDetailAdditionalInfoItem[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ErrorDetailAdditionalInfoItem {
  /**
   * The type of additional information.
   */
  type?: string;

  /**
   * The additional information specific to the type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  info?: Record<unknown>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ErrorResponseError {
  /**
   * Unlocalized string which can be used to programmatically identify the error.
   */
  code?: string;

  /**
   * Describes the error in detail and provides debugging information. If Accept-Language is set in the request, it must be localized to that language.
   */
  message?: string;

  /**
   * The target of the particular error (for example, the name of the property in error).
   */
  target?: string;

  /**
   * An array of additional nested error response info objects, as described by this contract.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  details?: ErrorDetail[];

  /**
   * An array of objects with 'type' and 'info' properties. The schema of 'info' is service-specific and dependent on the 'type' string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalInfo?: ErrorResponseErrorAdditionalInfoItem[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ErrorResponseErrorAdditionalInfoItem {
  /**
   * The type of additional information.
   */
  type?: string;

  /**
   * The additional information specific to the type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  info?: Record<unknown>;
}

/**
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.)
 */
@error
model CommonErrorResponse {
  /**
   * Error code
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Error message indicating why the operation failed.
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
  @identifiers(#["message", "target"])
  details?: CommonErrorResponse[];

  /**
   * The error additional info.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  additionalInfo?: Azure.ResourceManager.Foundations.ErrorAdditionalInfo[];
}

/**
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.)
 */
@error
model ErrorContract {
  /**
   * The error object.
   */
  error?: CommonErrorResponse;
}
