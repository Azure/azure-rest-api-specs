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
  string: "string",

  /**
   * Integer datatype.
   */
  @doc("Integer datatype.")
  integer: "integer",

  /**
   * Long datatype.
   */
  @doc("Long datatype.")
  long: "long",

  /**
   * Boolean datatype.
   */
  @doc("Boolean datatype.")
  boolean: "boolean",

  /**
   * Float datatype.
   */
  @doc("Float datatype.")
  float: "float",

  /**
   * Double datatype.
   */
  @doc("Double datatype.")
  double: "double",

  string,
}

@doc("Defines the origin of how the check is applied at the role level in the virtual instance.")
union ConfigurationCheckOriginType {
  @doc("Manual application of the check.")
  Manual: "Manual",

  @doc("Check applied as per template definition")
  TemplateDefinition: "TemplateDefinition",

  string,
}

@doc("Schema for shared parameters to use in 1P resources checks configuration.")
model CheckConfigurationSharedParameters {
  /**
   * Name of the property. This can be updated by Author only. Not allowed for customization.
   */
  @doc("Name of the property.")
  @visibility("read")
  name: string;

  /**
   * Data type of the value. This can be updated by Author only. Not allowed for customization.
   */
  @doc("Data type of the value.")
  @visibility("read")
  dataType: DataType;

  /**
   * Unit of the property. This can be updated by Author only. Not allowed for customization.
   */
  @doc("Unit of the property.")
  @visibility("read")
  unit: string;

  /**
   * Default (or) customized value to be used in the check.
   */
  @doc("Default (or) customized value to be used in the check.")
  value: string;
}

@doc("Condition to be used to evaluate the output and customize the check.")
union CheckEvaluationCondition {
  @doc("Check output value must equal defined value.")
  Equals: "-eq",

  @doc("Check output value must not equal defined value.")
  NotEquals: "-ne",

  @doc("Check output value must be greater than defined value.")
  GreaterThan: "-gt",

  @doc("Check output value must be less than defined value.")
  LessThan: "-lt",

  @doc("Check output value must be greater than or equal to defined value.")
  GreaterThanOrEqual: "-ge",

  @doc("Check output value must be less than or equal to defined value.")
  LessThanOrEqual: "-le",

  @doc("Check output value must contain defined value.")
  Contains: "-contains",

  @doc("Check output value must not contain defined value.")
  NotContains: "-notcontains",

  @doc("Check output value must start with defined value.")
  StartsWith: "-StartsWith",

  @doc("Check output value must end with defined value.")
  EndsWith: "-EndsWith",

  @doc("Check output value must be in defined value.")
  In: "-In",

  @doc("Check output value must not be in defined value.")
  NotIn: "-NotIn",

  string,
}

@doc("The model for list of output parameters to be used in the check.")
model CheckConfigurationOutputParameters {
  /**
   * Condition to be used to evaluate the output and customize the check.
   */
  @doc("Condition to be used to evaluate the output and customize the check.")
  condition: CheckEvaluationCondition;

  /**
   * List of parameters
   */
  @doc("List of parameters.")
  parameters: CheckConfigurationSharedParameters;
}

@doc("Schema for check configuration for allowing customization.")
model CheckConfiguration {
  /**
   * The unique identifier of the check defined in check definition.
   */
  @doc("The unique identifier of the check defined in check definition.")
  checkId: string;

  /**
   * The origin of how the check applied at the role level in the virtual instance.
   */
  @doc("The origin of how the check applied at the role level in the virtual instance.")
  @visibility("read")
  checkOriginType: ConfigurationCheckOriginType;

  /**
   * The flag to enable (or) disable the check execution.
   */
  @doc("The flag to enable (or) disable the check execution.")
  enabled: boolean;

  /**
   * List of input parameters to be used in the check.
   */
  @doc("List of input parameters to be used in the check.")
  inputParameters: CheckConfigurationSharedParameters;

  /**
   * List of output parameters to be used in the check.
   */
  @doc("List of output parameters to be used in the check.")
  outputParameters: CheckConfigurationOutputParameters;
}

@doc("Schema for role configuration including checks and resources.")
model RoleConfiguration {
  /**
   * Name of the role. This can be updated by Author only. Not allowed for customization.
   */
  @doc("Name of the role.")
  @visibility("read")
  roleName: string;

  /**
   * List of checks to be executed for the role.
   */
  @doc("List of checks to be executed for the role.")
  @OpenAPI.extension("x-ms-identifiers", [])
  checks: CheckConfiguration[];
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
  NonProduction: "Non-Production",

  string,
}

@doc("Defines the components that are being managed at the workload level.")
model WorkloadComponents {
  /**
   * Name of the component. Not allowed for customization.
   */
  @doc("Name of the component.")
  name: string;

  /**
   * List of roles managed at the component level.
   */
  @doc("List of roles managed at the component level.")
  @OpenAPI.extension("x-ms-identifiers", [])
  roles: RoleConfiguration[];
}

@doc("Defines the configuration for the template properties.")
model ConfigurationChecksTemplatePropertiesConfiguration {
  /**
   * The type of workload for which the checks are executed. Referenced from VI resource.
   */
  @doc("The type of workload for which the checks are executed. Referenced from VI resource.")
  workloadType: string;

  /**
   * The type of environment for which the checks are executed. Referenced from VI resource.
   */
  @doc("The type of environment for which the checks are executed. Referenced from VI resource.")
  environmentType: EnvironmentType;

  /**
   * List of components managed at the workload level.
   */
  @doc("List of components managed at the workload level.")
  @OpenAPI.extension("x-ms-identifiers", [])
  components: WorkloadComponents[];

  /**
   * List of common checks to be executed for all the components (or) at parent resource level.
   */
  @doc("List of common checks to be executed for all the components (or) at parent resource level.")
  @OpenAPI.extension("x-ms-identifiers", [])
  commonChecks: CheckConfiguration[];
}

@doc("Defines the properties of the configuration checks template.")
model ConfigurationChecksTemplateProperties {
  /**
   * The interval at which the checks are executed. Supports from 1 hour to 24 hours.
   */
  @doc("The interval at which the checks are executed.")
  executionInterval: string;

  /**
   * The provisioning state of the resource.
   */
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ConfigurationChecksTemplateProvisioningState;

  /**
   * The configurations for the template.
   */
  @doc("The configurations for the template.")
  configuration: ConfigurationChecksTemplatePropertiesConfiguration;
}
