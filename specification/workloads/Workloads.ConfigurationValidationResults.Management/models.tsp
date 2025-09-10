import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint"
namespace Microsoft.Workloads;

@doc("The types of configuration checks that can be performed.")
@renamedFrom(Versions.v2024_11_01_preview, "QualityCheckType")
union ConfigurationCheckType {
  /**
   * Represents the default Platform defined (First Party) configuration check type.
   * This is typically a Platform defined(First Party) check, adhering to general best practices.
   */
  @doc("The default Platform defined(First Party) configuration check type.")
  Default: "Default",

  /**
   * Represents a custom configuration check type.
   * Users can define their own custom checks to meet specific requirements.
   */
  @doc("The custom configuration check type.")
  Custom: "Custom",

  string,
}

@doc("The level of impact associated with a configuration check.")
@renamedFrom(Versions.v2024_11_01_preview, "QualityCheckImpactLevel")
union ConfigurationCheckImpactLevel {
  /**
   * Critical-impact configuration checks highlight the most severe issues that require urgent and
   * immediate resolution to prevent major disruptions or downtime.
   */
  @doc("Critical-impact configuration checks represent the highest level of severity and demand immediate attention.")
  Critical: "Critical",

  /**
   * High-impact configuration checks indicate significant issues that, if not resolved promptly, can lead to
   * major performance degradation.
   */
  @doc("High-impact configuration checks represent serious issues requiring quick action.")
  High: "High",

  /**
   * Medium-impact configuration checks highlight issues that, while important, may not be urgent but
   * still require resolution to maintain optimal performance.
   */
  @doc("Medium-impact configuration checks signal important but not immediately critical issues.")
  Medium: "Medium",

  /**
   * Low-impact configuration checks refer to issues that have minimal impact on the workload's
   * performance or functionality but may still require attention over time.
   */
  @doc("Low-impact configuration checks highlight issues with limited effect on performance.")
  Low: "Low",

  /**
   * Minor-impact configuration checks identify very small issues that have negligible effects and do not
   * usually require urgent action.
   */
  @doc("Minor-impact configuration checks represent trivial issues with little to no impact.")
  Minor: "Minor",

  /**
   * Informational-impact configuration checks provide useful insights or best practices but do not
   * indicate any problems or issues with the workload.
   */
  @doc("Informational checks offer insights or suggestions without highlighting any problems.")
  Informational: "Informational",

  string,
}

@doc("The execution layer of a configuration check.")
@renamedFrom(Versions.v2024_11_01_preview, "QualityCheckExecutionLayer")
union ConfigurationCheckExecutionLayer {
  /**
   * The configuration check is executed at the Azure Resource Manager (ARM) level.
   */
  @doc("The Azure Resource Manager execution layer for configuration checks.")
  AzureResourceManager: "AzureResourceManager",

  /**
   * The configuration check is executed at the operating system level.
   */
  @doc("The operating system execution layer for configuration checks.")
  OperatingSystem: "OperatingSystem",

  string,
}

@doc("Defines the deviation status for a configuration check configuration.")
@renamedFrom(Versions.v2024_11_01_preview, "QualityCheckConfigurationDeviation")
union ConfigurationCheckConfigurationDeviation {
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
   * Used when the deviation status cannot be determined due to the configuration checks not being
   * evaluated.
   */
  @doc("The deviation status is evaluation failed as the configuration checks couldn't be evaluated.")
  EvaluationFailed: "EvaluationFailed",

  @doc("Allows for custom or additional deviation states.")
  string,
}

@doc("The type of evaluation performed on the configuration checks.")
@added(Versions.v2024_11_01_preview)
union ConfigurationChecksEvaluationType {
  /**
   * Indicates that the configuration checks are evaluated on-demand.
   */
  OnDemand: "OnDemand",

  /**
   * Indicates that the configuration checks are evaluated on a schedule.
   */
  Scheduled: "Scheduled",

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

@doc("Represents the configuration check recommendation details.")
@added(Versions.v2024_11_01_preview)
model ConfigurationCheckRecommendation {
  /**
   * The reason for the recommended action.
   */
  @doc("The reason for the recommended action.")
  reason: string;

  /**
   * The recommended action to bring the resource into compliance with the recommended state.
   */
  @doc("The recommended action to bring the resource into compliance.")
  action: string;

  /**
   * Additional details explaining the reasoning behind the configuration check recommendation.
   */
  @doc("Detailed information about the recommended action.")
  details: string;
}

@doc("Represents the results of configuration checks on a resource.")
@renamedFrom(Versions.v2024_11_01_preview, "ConfigurationResults")
model EvaluationResults {
  /**
   * The name of the configuration check being executed.
   */
  @doc("The name of the configuration check.")
  name: string;

  /**
   * The description of configuration check being executed.
   */
  @doc("The description of the configuration check.")
  description?: string;

  /**
   * Indicates the layer in the system (e.g., azure resource manager(ARM) or operating system) where
   * the check was executed.
   */
  @doc("The execution layer where the configuration check was performed.")
  executionLayer: ConfigurationCheckExecutionLayer;

  /**
   * The configuration state that is recommended for optimal performance or compliance.It is
   * determined by predefined rules or best practices.
   */
  @doc("The configuration recommended state for the check.")
  recommendedState: string;

  /**
   * Represents any custom state defined by the user, allowing deviations from the recommended state
   * due to specific requirements.
   */
  @doc("The customized state provided by the user.")
  customizedState?: string;

  /**
   * Reflects the current configuration state of the resource when the check was executed.
   */
  @doc("The actual state of the resource.")
  actualStateOnResource: string;

  /**
   * Describes any deviations between the recommended/customized state and the actual state.
   */
  @doc("Describes the deviation from the recommended state.")
  configurationDeviation: ConfigurationCheckConfigurationDeviation;

  /**
   * Provides actions or steps recommended to bring the resource into compliance with the
   * recommended state/customized state.
   */
  @doc("The mitigation steps to follow best practices.")
  @removed(Versions.v2024_11_01_preview)
  recommendedAction: string;

  /**
   * Additional details explaining the reasoning behind the quality check recommendation.
   */
  @doc("Detailed explanation of the recommendation.")
  @removed(Versions.v2024_11_01_preview)
  recommendationDetails: string;

  /**
   * Provides actions or steps recommended to bring the resource into compliance with the
   * recommended state/customized state.
   */
  @doc("The mitigation steps to follow best practices.")
  @added(Versions.v2024_11_01_preview)
  recommendation?: ConfigurationCheckRecommendation;

  /**
   * Specifies the type of configuration check performed, such as default or customized.
   * This helps categorize the check for better tracking and reporting.
   */
  @doc("The type of configuration check.")
  checkType: ConfigurationCheckType;

  /**
   * The category of the configuration check, such as reliability, operational excellence, or
   * security, etc. which helps to classify the validation.
   */
  @doc("The category of the configuration check.")
  checkCategory: string;

  /**
   * The configuration check version.
   */
  @doc("The version of the configuration check.")
  checkVersion: string;

  /**
   * The level of impact this configuration check has on the resource. This can have the values
   * low, medium and high.
   */
  @doc("The impact level of the configuration check.")
  impactLevel: ConfigurationCheckImpactLevel;

  /**
   * The error details for the check execution failures.
   */
  @doc("The error details to provide additional context in case of evaluation failures during the configuration check execution.")
  errorDetails?: ErrorDetails;
}

@doc("The configuration validation results error details.")
model ErrorDetails {
  /**
   * The configuration checks execution error code.
   */
  @doc("The error code generated by the configuration check execution.")
  @visibility(Lifecycle.Read)
  code: string;

  /**
   * The configuration checks execution error category.
   */
  @doc("The category of the error.")
  @visibility(Lifecycle.Read)
  category: string;

  /**
   * The configuration checks execution error details.
   */
  @doc("Detailed information about the error.")
  @visibility(Lifecycle.Read)
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
   * The type of the component within the workload instance being validated.
   */
  @doc("The type of the component being validated.")
  componentType?: string;

  /**
   * The name of the role within the workload instance being validated.
   */
  @doc("The name of the role being validated.")
  roleName?: string;

  /**
   * The ARM IDs of resources associated with this validation.
   */
  @doc("The ARM IDs of resources associated with this validation.")
  resourceArmIds: string[];

  /**
   * The type of workload being validated, such as 'SAP', 'Kubernetes', 'Oracle' etc.
   */
  @doc("The type of workload being validated, such as 'SAP', 'Kubernetes', 'Oracle' etc.")
  workloadType?: string;

  /**
   * The template ID of the configuration checks being applied to the workload instance.
   */
  @doc("The template ID of the configuration checks being applied.")
  @renamedFrom(Versions.v2024_11_01_preview, "qualityChecksTemplateId")
  configurationChecksTemplateId?: string;

  /**
   * The type of evaluation performed on the configuration checks.
   */
  @doc("The type of evaluation performed on the configuration checks.")
  @added(Versions.v2024_11_01_preview)
  evaluationType: ConfigurationChecksEvaluationType;

  /**
   * The timestamp when the evaluation was performed.
   */
  @doc("The timestamp when the evaluation was performed.")
  @added(Versions.v2024_11_01_preview)
  evaluationTimestamp: utcDateTime;

  /**
   * Contains detailed information about errors encountered during the execution of the
   * configuration checks.
   */
  @doc("Error details related to the configuration check execution.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  errorDetails?: ErrorDetails[];

  /**
   * Contains the results of the configuration validation, including details about the checks and
   * their outcomes.
   */
  @doc("The results of the configuration validation.")
  @Azure.ResourceManager.identifiers(#[])
  @renamedFrom(Versions.v2024_11_01_preview, "configurationResults")
  evaluationResults: EvaluationResults[];

  /**
   * The provisioning state of the validation results resource.
   */
  @doc("The provisioning state of the validation results resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ValidationConfigurationResultsProvisioningState;
}
