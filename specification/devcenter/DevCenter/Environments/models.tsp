import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../shared/models.tsp";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;

@doc("The type of data a parameter accepts.")
union ParameterType {
  @doc("The parameter accepts an array of values.") array: "array",
  @doc("The parameter accepts a boolean value.") boolean: "boolean",
  @doc("The parameter accepts an integer value.") integer: "integer",
  @doc("The parameter accepts a number value.") number: "number",
  @doc("The parameter accepts an object value.") object: "object",
  @doc("The parameter accepts a string value.") string: "string",
  string,
}

@doc("Indicates whether an environment type is enabled for use in a project.")
union EnvironmentTypeEnableStatus {
  @doc("The environment type is enabled for use in the project.")
  Enabled: "Enabled",

  @doc("The environment type is not enabled for use in the project.")
  Disabled: "Disabled",

  string,
}

@doc("The provisioning state of the environment.")
union EnvironmentProvisioningState {
  @doc("The environment was successfully provisioned.")
  Succeeded: "Succeeded",

  @doc("The environment failed to provision.")
  Failed: "Failed",

  @doc("The environment provisioning was canceled.")
  Canceled: "Canceled",

  @doc("The environment is creating.")
  Creating: "Creating",

  @doc("The environment was accepted.")
  Accepted: "Accepted",

  @doc("The environment is deleting.")
  Deleting: "Deleting",

  @doc("The environment is updating.")
  Updating: "Updating",

  @doc("The environment is preparing.")
  Preparing: "Preparing",

  @doc("The environment is running.")
  Running: "Running",

  @doc("The environment is Syncing.")
  Syncing: "Syncing",

  @doc("The environment is moving resources.")
  MovingResources: "MovingResources",

  @doc("The environment has a transient failure.")
  TransientFailure: "TransientFailure",

  @doc("The environment storage provisioning failed.")
  StorageProvisioningFailed: "StorageProvisioningFailed",

  string,
}

@doc("Results of the environment list operation.")
model EnvironmentListResult is Azure.Core.Page<Environment>;

@doc("Properties of an environment.")
@resource("environments")
@parentResource(User)
model Environment {
  ...EnvironmentUpdateProperties;

  @doc("Environment name.")
  @key("environmentName")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility("read")
  name: string;

  @doc("Environment type.")
  @visibility("read", "create")
  environmentType: string;

  @doc("The AAD object id of the owner of this Environment.")
  @visibility("read")
  user?: Azure.Core.uuid;

  @doc("The provisioning state of the environment.")
  @visibility("read")
  provisioningState?: EnvironmentProvisioningState;

  @doc("The identifier of the resource group containing the environment's resources.")
  @visibility("read")
  resourceGroupId?: string;

  @doc("Name of the catalog.")
  @visibility("read", "create")
  catalogName: string;

  @doc("Name of the environment definition.")
  @visibility("read", "create")
  environmentDefinitionName: string;

  @doc("Provisioning error details. Populated only for error states.")
  @visibility("read")
  error?: Azure.Core.Foundations.Error;
}

@doc("""
Properties of an environment. These properties can be updated after the
resource has been created.
""")
model EnvironmentUpdateProperties {
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "there is no build in type to describe object"
  @doc("Parameters object for the environment.")
  parameters?: Record<unknown>;
}

@doc("A catalog.")
@resource("catalogs")
@parentResource(Project)
model Catalog {
  @doc("Name of the catalog.")
  @key("catalogName")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility("read")
  name: string;
}

@doc("Results of the environment definition list operation.")
model EnvironmentDefinitionListResult is Azure.Core.Page<EnvironmentDefinition>;

@doc("An environment definition.")
@resource("environmentDefinitions")
@parentResource(Catalog)
model EnvironmentDefinition {
  @doc("The ID of the environment definition.")
  id: string;

  @doc("Name of the environment definition.")
  @key("definitionName")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility("read")
  name: string;

  @doc("Name of the catalog.")
  catalogName: string;

  @doc("A short description of the environment definition.")
  description?: string;

  @doc("Input parameters passed to an environment.")
  parameters?: EnvironmentDefinitionParameter[];

  //typespec does not have a way to represent this. Issue https://github.com/microsoft/typespec/issues/3005
  @doc("JSON schema defining the parameters object passed to an environment.")
  parametersSchema?: string;

  @doc("Path to the Environment Definition entrypoint file.")
  templatePath?: string;
}

@doc("Properties of an Environment Definition parameter")
model EnvironmentDefinitionParameter {
  @doc("Unique ID of the parameter")
  id: string;

  @doc("Display name of the parameter")
  name?: string;

  @doc("Description of the parameter")
  description?: string;

  @doc("Default value of the parameter")
  default?: string;

  @doc("""
A string of one of the basic JSON types (number, integer, array, object,
boolean, string)
""")
  type: ParameterType;

  @doc("""
Whether or not this parameter is read-only.  If true, default should have a
value.
""")
  readOnly?: boolean;

  @doc("Whether or not this parameter is required")
  required: boolean;

  @doc("An array of allowed values")
  @minItems(1)
  allowed?: string[];
}

@doc("Result of the environment type list operation.")
model EnvironmentTypeListResult is Azure.Core.Page<EnvironmentType>;

@doc("Properties of an environment type.")
model EnvironmentType {
  @doc("Name of the environment type")
  name: string;

  @doc("""
Id of a subscription or management group that the environment type will be
mapped to. The environment's resources will be deployed into this subscription
or management group.
""")
  deploymentTargetId: string;

  @doc("Indicates whether this environment type is enabled for use in this project.")
  status: EnvironmentTypeEnableStatus;
}
