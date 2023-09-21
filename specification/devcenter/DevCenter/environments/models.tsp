import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../shared/models.tsp";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenter;

enum ParameterType {
  @doc("The parameter accepts an array of values.") array,
  @doc("The parameter accepts a boolean value.") boolean,
  @doc("The parameter accepts an integer value.") integer,
  @doc("The parameter accepts a number value.") number,
  @doc("The parameter accepts an object value.") object,
  @doc("The parameter accepts a string value.") string,
}

enum EnvironmentTypeEnableStatus {
  @doc("The environment type is enabled for use in the project.") Enabled,
  @doc("The environment type is not enabled for use in the project.") Disabled,
}

@doc("Results of the environment list operation.")
model EnvironmentListResult is Azure.Core.Page<Environment>;

@doc("Properties of an environment.")
model Environment {
  ...EnvironmentUpdateProperties;

  @doc("Environment name.")
  @visibility("read")
  name?: string;

  @doc("Environment type.")
  environmentType: string;

  @doc("The AAD object id of the owner of this Environment.")
  @visibility("read")
  user?: string;

  @doc("The provisioning state of the environment.")
  @visibility("read")
  provisioningState?: string;

  @doc("The identifier of the resource group containing the environment's resources.")
  @visibility("read")
  resourceGroupId?: string;

  @doc("Name of the catalog.")
  catalogName: string;

  @doc("Name of the environment definition.")
  environmentDefinitionName: string;

  @doc("Provisioning error details. Populated only for error states.")
  @visibility("read")
  error?: CloudErrorBody;
}

@doc("""
Properties of an environment. These properties can be updated after the
resource has been created.
""")
model EnvironmentUpdateProperties {
  @doc("Parameters object for the environment.")
  parameters?: unknown;
}

@doc("Results of the catalog list operation.")
model CatalogListResult is Azure.Core.Page<Catalog>;

@doc("A catalog.")
model Catalog {
  @doc("Name of the catalog.")
  name: string;
}

@doc("Results of the environment definition list operation.")
model EnvironmentDefinitionListResult is Azure.Core.Page<EnvironmentDefinition>;

@doc("An environment definition.")
model EnvironmentDefinition {
  @doc("The ID of the environment definition.")
  id: string;

  @doc("Name of the environment definition.")
  name: string;

  @doc("Name of the catalog.")
  catalogName: string;

  @doc("A short description of the environment definition.")
  description?: string;

  @doc("Input parameters passed to an environment.")
  parameters?: EnvironmentDefinitionParameter[];

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

@added(APIVersions.v2023_09_01_preview)
enum EnvironmentOperationStatus {
  @doc("The operation has not started.") NotStarted,
  @doc("The operation is running.") Running,
  @doc("The operation succeeded.") Succeeded,
  @doc("The operation was canceled.") Canceled,
  @doc("The operation failed.") Failed,
}

@added(APIVersions.v2023_09_01_preview)
@doc("The action results list result.")
model EnvironmentOperationListResult is Azure.Core.Page<EnvironmentOperation>;

@added(APIVersions.v2023_09_01_preview)
@doc("Information about an operation on an environment.")
@discriminator("kind")
model EnvironmentOperation {
  @doc("The unique URI for the environment operation.")
  uri: string;

  @doc("Unique identifier for the environment operation.")
  operationId: string;

  @doc("The operation status.")
  status: EnvironmentOperationStatus;

  @doc("The object ID of the actor which initiated the operation.")
  createdByObjectId?: string;

  @doc("The time the operation started.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The time the operation finished.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Parameters object for the environment at the time of the operation.")
  environmentParameters?: unknown;

  @doc("Provisioning or operation error details. Populated only for error states.")
  error?: CloudErrorBody;
}
