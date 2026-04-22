import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.HanaOnAzure;

/**
 * State of provisioning of the HanaInstance
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union HanaProvisioningStatesEnum {
  string,

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Migrating
   */
  Migrating: "Migrating",
}

/**
 * List of HANA operations
 */
model OperationList {
  /**
   * List of HANA operations
   */
  @pageItems
  @identifiers(#["name"])
  value?: Operation[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * HANA operation information
 */
model Operation {
  /**
   * The name of the operation being performed on this particular object. This name should match the action name that appears in RBAC / the event service.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Displayed HANA operation information
   */
  display?: Display;
}

/**
 * Detailed HANA operation information
 */
model Display {
  /**
   * The localized friendly form of the resource provider name. This form is also expected to include the publisher/company responsible. Use Title Casing. Begin with "Microsoft" for 1st party services.
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly form of the resource type related to this action/operation. This form should match the public documentation for the resource provider. Use Title Casing. For examples, refer to the “name” section.
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The localized friendly name for the operation as shown to the user. This name should be concise (to fit in drop downs), but clear (self-documenting). Use Title Casing and include the entity/resource to which it applies.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The localized friendly description for the operation as shown to the user. This description should be thorough, yet concise. It will be used in tool-tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The intended executor of the operation; governs the display of the operation in the RBAC UX and the audit logs UX. Default value is 'user,system'
   */
  @visibility(Lifecycle.Read)
  origin?: string;
}

/**
 * Describes the format of Error response.
 */
@error
model ErrorResponse {
  /**
   * Describes the error object.
   */
  error?: ErrorResponseError;
}

/**
 * Describes the error object.
 */
model ErrorResponseError {
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
}

/**
 * Describes the properties of a SAP monitor.
 */
model SapMonitorProperties {
  /**
   * State of provisioning of the HanaInstance
   */
  @visibility(Lifecycle.Read)
  provisioningState?: HanaProvisioningStatesEnum;

  /**
   * The name of the resource group the SAP Monitor resources get deployed into.
   */
  @visibility(Lifecycle.Read)
  managedResourceGroupName?: string;

  /**
   * The ARM ID of the Log Analytics Workspace that is used for monitoring
   */
  logAnalyticsWorkspaceArmId?: string;

  /**
   * The value indicating whether to send analytics to Microsoft
   */
  enableCustomerAnalytics?: boolean;

  /**
   * The workspace ID of the log analytics workspace to be used for monitoring
   */
  logAnalyticsWorkspaceId?: string;

  /**
   * The shared key of the log analytics workspace that is used for monitoring
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  logAnalyticsWorkspaceSharedKey?: string;

  /**
   * The version of the payload running in the Collector VM
   */
  @visibility(Lifecycle.Read)
  sapMonitorCollectorVersion?: string;

  /**
   * The subnet which the SAP monitor will be deployed in
   */
  monitorSubnet?: string;
}

/**
 * Tags field of the resource.
 */
model Tags {
  /**
   * Tags field of the resource.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Describes the properties of a provider instance.
 */
model ProviderInstanceProperties {
  /**
   * The type of provider instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: string;

  /**
   * A JSON string containing the properties of the provider instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: string;

  /**
   * A JSON string containing metadata of the provider instance.
   */
  metadata?: string;

  /**
   * State of provisioning of the provider instance
   */
  @visibility(Lifecycle.Read)
  provisioningState?: HanaProvisioningStatesEnum;
}
