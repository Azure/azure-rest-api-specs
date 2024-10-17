import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint"
namespace Microsoft.Workloads;

@doc("The types of quality checks that can be performed.")
union QualityCheckType {
  /**
   * Represents the default Platform defined (First Party) quality check type.
   * This is typically a Platform defined(First Party) check, adhering to general best practices.
   */
  @doc("The default Platform defined(First Party) quality check type.")
  Default: "Default",

  /**
   * Represents a custom quality check type.
   * Users can define their own custom checks to meet specific requirements.
   */
  @doc("The custom quality check type.")
  Custom: "Custom",

  string,
}

@doc("The level of impact associated with a quality check.")
union QualityCheckImpactLevel {
  /**
   * High-impact checks indicate critical issues that require immediate attention.
   */
  @doc("High-impact level for quality checks.")
  High: "High",

  /**
   * Medium-impact checks indicate important issues that may not be urgent but still
   * require prompt attention.
   */
  @doc("Medium-impact level for quality checks.")
  Medium: "Medium",

  /**
   * Low-impact checks highlight minor issues that may not significantly affect the workload's
   * performance or functionality.
   */
  @doc("Low-impact level for quality checks.")
  Low: "Low",

  string,
}

@doc("The execution layer of a quality check.")
union QualityCheckExecutionLayer {
  /**
   * The quality check is executed at the Azure Resource Manager (ARM) level.
   */
  @doc("The Azure Resource Manager execution layer for quality checks.")
  AzureResourceManager: "AzureResourceManager",

  /**
   * The quality check is executed at the operating system level.
   */
  @doc("The operating system execution layer for quality checks.")
  OperatingSystem: "OperatingSystem",

  string,
}

@doc("Defines the deviation status for a quality check configuration.")
union QualityCheckConfigurationDeviation {
  /**
   * Indicates that there is a deviation between the actual and recommended/customized state.
   */
  @doc("A configuration deviation between the actual state and the recommended/customized state.")
  Yes: "Yes",

  /**
   * Indicates that there is no deviation, and the actual state matches the recommended/customized
   * state.
   */
  @doc("No deviation; the actual state matches the recommended/customized state.")
  No: "No",

  /**
   * Used when the deviation status cannot be determined due to the quality checks not being
   * evaluated.
   */
  @doc("The deviation status is unknown as the quality checks couldn't be evaluated.")
  Unknown: "Unknown",

  @doc("Allows for custom or additional deviation states.")
  string,
}

@doc("Represents the provisioning states of a resource.")
union ValidationConfigurationResultsProvisioningState {
  /**
   * Indicates that provisioning has completed successfully.
   */
  @doc("Provisioning has succeeded.")
  Succeeded: "Succeeded",

  /**
   * Indicates that provisioning is in progress.
   */
  @doc("Provisioning is updating.")
  Updating: "Updating",

  /**
   * Indicates that resources are being created as part of provisioning.
   */
  @doc("Provisioning is creating resources.")
  Creating: "Creating",

  /**
   * Indicates that provisioning has encountered an error and failed.
   */
  @doc("Provisioning has failed.")
  Failed: "Failed",

  /**
   * Indicates that resources are being deleted as part of provisioning.
   */
  @doc("Provisioning is deleting resources.")
  Deleting: "Deleting",

  /**
   * Indicates that the provisioning process has been canceled.
   */
  @doc("Provisioning has been canceled.")
  Canceled: "Canceled",

  string,
}

@doc("Represents the results of configuration quality checks on a resource.")
model ConfigurationResults {
  /**
   * The name of the quality check being executed.
   */
  @doc("The name of the quality check.")
  name: string;

  /**
   * Indicates the layer in the system (e.g., azure resource manager(ARM) or operating system) where
   * the check was executed.
   */
  @doc("The execution layer where the quality check was performed.")
  executionLayer: QualityCheckExecutionLayer;

  /**
   * The configuration state that is recommended for optimal performance or compliance.It is
   * determined by predefined rules or best practices.
   */
  @doc("The configuration recommended state for the quality check.")
  recommendedState: string;

  /**
   * Represents any custom state defined by the user, allowing deviations from the recommended state
   * due to specific requirements.
   */
  @doc("The customized state provided by the user.")
  customizedState?: string;

  /**
   * Reflects the current configuration state of the resource when the quality check was executed.
   */
  @doc("The actual state of the resource.")
  actualStateOnResource: string;

  /**
   * Describes any deviatiobns between the recommended/customized state and the actual state.
   */
  @doc("Describes the deviation from the recommended state.")
  configurationDeviation: QualityCheckConfigurationDeviation;

  /**
   * Provides actions or steps recommended to bring the resource into compliance with the
   * recommended state/customised state.
   */
  @doc("The mitigation steps to follow best practices.")
  recommendedAction: string;

  /**
   * Additional details explaining the reasoning behind the quality check recommendation.
   */
  @doc("Detailed explanation of the recommendation.")
  recommendationDetails: string;

  /**
   * Specifies the type of quality check performed, such as default or customised.
   * This helps categorize the check for better tracking and reporting.
   */
  @doc("The type of quality check.")
  checkType: QualityCheckType;

  /**
   * The category of the quality check, such as reliability, operational excellence, or security,
   * etc. which helps to classify the validation.
   */
  @doc("The category of the quality check.")
  checkCategory: string;

  /**
   * The quality check version.
   */
  @doc("The version of the quality check.")
  checkVersion: string;

  /**
   * The level of impact this quality check has on the resource. This can have the values
   * low, medium and high.
   */
  @doc("The impact level of the quality check.")
  impactLevel: QualityCheckImpactLevel;
}

@doc("The configuration validation results error details.")
model ErrorDetails {
  /**
   * The quality checks execution error code.
   */
  @doc("The error code generated by the quality check execution.")
  @visibility("read")
  code: string;

  /**
   * The quality checks execution error category.
   */
  @doc("The category of the error.")
  @visibility("read")
  category: string;

  /**
   * The quality checks execution error details.
   */
  @doc("Detailed information about the error.")
  @visibility("read")
  details: string;
}

@doc("Configuration validation results properties.")
model ConfigurationValidationResultsProperties {
  /**
   * The ARM ID of the workload instance being validated.
   */
  @doc("The workload instance ARM ID.")
  workloadInstanceArmId: string;

  /**
   * The environment of the resource being validated.
   */
  @doc("The environment of the resource being validated.")
  environment: string;

  /**
   * The name of the component within the workload instance being validated.
   */
  @doc("The name of the component being validated.")
  componentName?: string;

  /**
   * The name of the role within the workload instance being validated.
   */
  @doc("The name of the role being validated.")
  roleName: string;

  /**
   * The ARM IDs of resources associated with this validation.
   */
  @doc("The ARM IDs of resources associated with this validation.")
  resourceArmIds: string[];

  /**
   * The template ID of the quality checks being applied to the workload instance.
   */
  @doc("The template ID of the quality checks being applied.")
  qualityChecksTemplateId?: string;

  /**
   * Contains detailed information about errors encountered during the execution of the quality
   * checks.
   */
  @doc("Error details related to the quality check execution.")
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  errorDetails?: ErrorDetails[];

  /**
   * Contains the results of the configuration validation, including details about the checks and
   * their outcomes.
   */
  @doc("The results of the configuration validation.")
  @OpenAPI.extension("x-ms-identifiers", [])
  configurationResults: ConfigurationResults[];

  /**
   * The provisioning state of the validation results resource.
   */
  @doc("The provisioning state of the validation results resource.")
  @visibility("read")
  provisioningState?: ValidationConfigurationResultsProvisioningState;
}
