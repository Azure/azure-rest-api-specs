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

@doc("The data type.")
union DataType {
  /**
   * String datatype.
   */
  @doc("String datatype.")
  String: "String",

  /**
   * Integer datatype.
   */
  @doc("Integer datatype.")
  Integer: "Integer",

  /**
   * Long datatype.
   */
  @doc("Long datatype.")
  Long: "Long",

  /**
   * Boolean datatype.
   */
  @doc("Boolean datatype.")
  Boolean: "Boolean",

  /**
   * Float datatype.
   */
  @doc("Float datatype.")
  Float: "Float",

  /**
   * Double datatype.
   */
  @doc("Double datatype.")
  Double: "Double",

  string,
}

@doc("Defines the origin of how the check is applied at the role level in the virtual instance.")
union CheckOriginType {
  @doc("Manual application of the check.")
  Manual: "Manual",

  @doc("Check applied as per template definition")
  TemplateDefinition: "TemplateDefinition",

  string,
}

@doc("Condition to be used to evaluate the output and customize the check.")
union CheckEvaluationCondition {
  @doc("Check output value must equal defined value.")
  Equals: "eq",

  @doc("Check output value must not equal defined value.")
  NotEquals: "ne",

  @doc("Check output value must be greater than defined value.")
  GreaterThan: "gt",

  @doc("Check output value must be less than defined value.")
  LessThan: "lt",

  @doc("Check output value must be greater than or equal to defined value.")
  GreaterThanOrEqual: "ge",

  @doc("Check output value must be less than or equal to defined value.")
  LessThanOrEqual: "le",

  @doc("Check output value must contain defined value.")
  Contains: "contains",

  @doc("Check output value must not contain defined value.")
  NotContains: "notContains",

  @doc("Check output value must start with defined value.")
  StartsWith: "startsWith",

  @doc("Check output value must end with defined value.")
  EndsWith: "endsWith",

  @doc("Check output value must be in defined value.")
  In: "in",

  @doc("Check output value must not be in defined value.")
  NotIn: "notIn",

  string,
}

@doc("The type of environment for which the checks are executed.")
union EnvironmentType {
  /**
   * Indicates that environment is production environment.
   */
  @doc("Environment is production.")
  Production: "Production",

  /**
   * Indicates that environment is non production environment.
   */
  @doc("Environment is non production.")
  NonProduction: "NonProduction",

  string,
}

@doc("Represents the provisioning states of a resource.")
union ConfigurationChecksTemplateProvisioningState {
  /**
   * Indicates that provisioning has completed successfully.
   */
  @doc("Provisioning has succeeded.")
  Succeeded: "Succeeded",

  /**
   * Indicates that provisioning has encountered an error and failed.
   */
  @doc("Provisioning has failed.")
  Failed: "Failed",

  /**
   * Indicates that provisioning is in progress.
   */
  @doc("Provisioning in progress.")
  InProgress: "InProgress",

  /**
   * Indicates that resources are deleted as part of provisioning.
   */
  @doc("Provisioning has deleted resources.")
  Deleted: "Deleted",

  /**
   * Indicates that the provisioning process has been canceled.
   */
  @doc("Provisioning has been canceled.")
  Canceled: "Canceled",

  string,
}

@doc("Schema for shared parameters to use in 1P resources checks configuration.")
model SharedParameters {
  /**
   * Name of the property. This can be updated by Author only. Not allowed for customization.
   */
  @doc("Name of the property.")
  @visibility(Lifecycle.Read)
  name: string;

  /**
   * Data type of the value. This can be updated by Author only. Not allowed for customization.
   */
  @doc("Data type of the value.")
  @visibility(Lifecycle.Read)
  dataType: DataType;

  /**
   * Unit of the property. This can be updated by Author only. Not allowed for customization.
   */
  @doc("Unit of the property.")
  @visibility(Lifecycle.Read)
  unit: string;

  /**
   * Default (or) customized value to be used in the check.
   */
  @doc("Default (or) customized value to be used in the check.")
  value: string;
}

@doc("The model for list of output parameters to be used in the check.")
model OutputParameters {
  /**
   * Condition to be used to evaluate the output and customize the check.
   */
  @doc("Condition to be used to evaluate the output and customize the check.")
  condition: CheckEvaluationCondition;

  /**
   * List of parameters
   */
  ...SharedParameters;
}

@doc("Schema for check configuration for allowing customization.")
model CheckConfiguration {
  /**
   * The unique identifier of the check defined in check definition.
   */
  @doc("The unique identifier of the check defined in check definition.")
  checkId: string;

  /**
   * Represents the check applicability on the list of roles, component level resources.
   */
  applicableTo?: string[];

  /**
   * The origin of how the check applied at the role level in the virtual instance.
   */
  @doc("The origin of how the check applied at the role level in the virtual instance.")
  @visibility(Lifecycle.Read)
  originType?: CheckOriginType;

  /**
   * The flag that indicates whether the check is enabled or disabled for execution.
   */
  @doc("The status of the check execution.")
  status: CheckExecutionStatus;

  /**
   * List of input parameters to be used in the check.
   */
  @doc("List of input parameters to be used in the check.")
  @Azure.ResourceManager.identifiers(#[])
  inputParameters?: SharedParameters[];

  /**
   * List of output parameters to be used in the check.
   */
  @doc("List of output parameters to be used in the check.")
  @Azure.ResourceManager.identifiers(#[])
  outputParameters: OutputParameters[];
}

@doc("The status of the check execution.")
union CheckExecutionStatus {
  /**
   * The execution of the check is enabled.
   */
  @doc("The execution of the check is enabled.")
  Enabled: "Enabled",

  /**
   * The execution of the check is disabled.
   */
  @doc("The execution of the check is disabled.")
  Disabled: "Disabled",

  string,
}

@doc("Schema for role configuration including checks and resources.")
model RoleConfiguration {
  /**
   * Name of the role. This can be updated by Author only. Not allowed for customization.
   */
  @doc("Name of the role.")
  @visibility(Lifecycle.Read)
  roleName: string;

  /**
   * List of checks to be executed for the role.
   */
  @doc("List of checks to be executed for the role.")
  @Azure.ResourceManager.identifiers(#["checkId"])
  checks: CheckConfiguration[];
}

@doc("Defines the components that are being managed at the workload level.")
model WorkloadComponents {
  /**
   * Name of the component. Not allowed for customization.
   */
  @doc("Name of the component.")
  name: string;

  /**
   * List of checks to be executed for the role.
   */
  @doc("List of checks to be executed for the role.")
  @Azure.ResourceManager.identifiers(#["checkId"])
  checks?: CheckConfiguration[];

  /**
   * List of roles managed at the component level.
   */
  @doc("List of roles managed at the component level.")
  @Azure.ResourceManager.identifiers(#[])
  roles: RoleConfiguration[];
}

@doc("Defines the configuration for the template properties.")
model Configuration {
  /**
   * The type of workload for which the checks are executed. Referenced from VI resource.
   */
  @doc("The type of workload for which the checks are executed. Referenced from VI resource.")
  @visibility(Lifecycle.Read)
  workloadType?: string;

  /**
   * The type of environment for which the checks are executed. Referenced from VI resource.
   */
  @doc("The type of environment for which the checks are executed. Referenced from VI resource.")
  @visibility(Lifecycle.Read)
  environmentType?: EnvironmentType;

  /**
   * List of components managed at the workload level.
   */
  @doc("List of components managed at the workload level.")
  @Azure.ResourceManager.identifiers(#[])
  components?: WorkloadComponents[];

  /**
   * List of common checks to be executed for all the components (or) at parent resource level.
   */
  @doc("List of common checks to be executed for all the components (or) at parent resource level.")
  @Azure.ResourceManager.identifiers(#["checkId"])
  commonChecks?: CheckConfiguration[];
}

@doc("Defines the properties of the configuration checks template.")
model ConfigurationChecksTemplateProperties {
  /**
   * The interval at which the checks are executed. Supports intervals starting from 1 hour and is formatted based on the ISO 8601 duration standard.
   * For example: PT60M (60 minutes), PT2H (2 hours).
   * For more information, see https://en.wikipedia.org/wiki/ISO_8601#Durations.
   */
  @doc("The interval at which the checks are executed.")
  executionInterval: string;

  /**
   * The provisioning state of the resource.
   */
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ConfigurationChecksTemplateProvisioningState;

  /**
   * The configurations for the template.
   */
  @doc("The configurations for the template.")
  configuration: Configuration;

  /**
   * Represents whether the checks template was generated by platform or authored by the customer.
   */
  createdBy?: string;

  /**
   * The timestamp of resource creation and modification (UTC).
   */
  @visibility(Lifecycle.Read)
  @doc("The timestamp of resource last modification (UTC).")
  lastModifiedAt?: utcDateTime;

  /**
   * Represents errors encountered on the configuration checks template resource.
   */
  @visibility(Lifecycle.Read)
  errors?: CommonTypes.ErrorDetail;
}

@doc("Defines the request body for updating the properties of the configuration checks template.")
model ConfigurationChecksTemplateUpdateRequest {
  /**
   * Represents the properties to be updated in the configuration checks template.
   */
  properties?: ConfigurationChecksTemplatePropertiesUpdateRequest;
}

@doc("Defines the properties to be updated in the configuration checks template.")
model ConfigurationChecksTemplatePropertiesUpdateRequest {
  /**
   * The configurations for the template.
   */
  configuration?: ChecksConfigurationUpdateRequest;
}

@doc("Defines the configuration for the template properties.")
model ChecksConfigurationUpdateRequest {
  /**
   * List of components managed at the workload level.
   */
  @doc("List of components managed at the workload level.")
  @Azure.ResourceManager.identifiers(#[])
  components?: WorkloadComponents[];

  /**
   * List of common checks to be executed for all the components (or) at parent resource level.
   */
  @doc("List of common checks to be executed for all the components (or) at parent resource level.")
  @Azure.ResourceManager.identifiers(#["checkId"])
  commonChecks?: CheckConfiguration[];
}
