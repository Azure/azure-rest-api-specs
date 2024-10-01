import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../shared/models.tsp";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;

@doc("Type of the output value.")
@added(APIVersions.v2024_02_01)
union EnvironmentOutputType {
  @doc("The output is an array of values.")
  array: "array",

  @doc("The output is a boolean value.")
  boolean: "boolean",

  @doc("The output is a number value.")
  number: "number",

  @doc("The output is an object value.")
  object: "object",

  @doc("The output is a string value.")
  string: "string",

  string,
}

@doc("The type of environment operation.")
@added(APIVersions.v2024_02_01)
union EnvironmentOperationKind {
  @doc("The operation represents a deployment.")
  Deploy: "Deploy",

  @doc("The operation represents a delete.")
  Delete: "Delete",

  string,
}

@doc("The scheduled action types.")
@added(APIVersions.v2024_02_01)
union EnvironmentActionType {
  @doc("The action will delete the environment and associated resources.")
  Delete: "Delete",

  string,
}

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

@doc("An ability the user has to perform an action on the environment type as an admin.")
@added(APIVersions.v2024_05_01_preview)
union EnvironmentTypeAbilityAsAdmin {
  @doc("User can delete environments.")
  DeleteEnvironments: "DeleteEnvironments",

  @doc("User can delay and skip actions on environments.")
  ManageEnvironmentActions: "ManageEnvironmentActions",

  @doc("User can read actions on environments.")
  ReadEnvironmentActions: "ReadEnvironmentActions",

  @doc("User can read outputs on environments.")
  ReadEnvironmentOutputs: "ReadEnvironmentOutputs",

  @doc("User can read environments.")
  ReadEnvironments: "ReadEnvironments",

  @doc("User can create new environments or replace and update existing ones.")
  WriteEnvironments: "WriteEnvironments",

  string,
}

@doc("An ability the user has to perform an action on the environment type as a developer.")
@added(APIVersions.v2024_05_01_preview)
union EnvironmentTypeAbilityAsDeveloper {
  @doc("User can delete environments.")
  DeleteEnvironments: "DeleteEnvironments",

  @doc("User can delay and skip actions on environments.")
  ManageEnvironmentActions: "ManageEnvironmentActions",

  @doc("User can read actions on environments.")
  ReadEnvironmentActions: "ReadEnvironmentActions",

  @doc("User can read outputs on environments.")
  ReadEnvironmentOutputs: "ReadEnvironmentOutputs",

  @doc("User can read environments.")
  ReadEnvironments: "ReadEnvironments",

  @doc("User can create new environments or replace and update existing ones.")
  WriteEnvironments: "WriteEnvironments",

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

alias EnvironmentListResult = Azure.Core.Page<Environment>;

@doc("Properties of an environment.")
@resource("environments")
@parentResource(User)
model Environment {
  ...EnvironmentUpdateProperties;

  @doc("The unique URI of the environment.")
  @visibility("read")
  @added(APIVersions.v2024_02_01)
  uri: url;

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

alias EnvironmentUpdateProperties = {
  ...EnvironmentPatchProperties;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "there is no build in type to describe object"
  @doc("Parameters object for the environment.")
  parameters?: Record<unknown>;
};

alias EnvironmentPatchProperties = {
  @doc("""
    The time the expiration date will be triggered (UTC), after which the
    environment and associated resources will be deleted.
    """)
  @added(APIVersions.v2024_02_01)
  expirationDate?: utcDateTime;
};

@doc("Outputs from environment deployment.")
@added(APIVersions.v2024_02_01)
model EnvironmentOutputs {
  @doc("The outputs Names and Values.")
  outputs?: Record<EnvironmentOutput>;
}

@doc("Output from environment deployment.")
@added(APIVersions.v2024_02_01)
model EnvironmentOutput {
  @doc("Type of the output value.")
  type?: EnvironmentOutputType;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "There is no built in type to describe object."
  @doc("The output value.")
  value?: unknown;

  @doc("Indicates if the value is sensitive.")
  sensitive?: boolean;
}

@doc("Information about an operation on an environment.")
@discriminator("kind")
@resource("operations")
@parentResource(Environment)
@added(APIVersions.v2024_02_01)
model EnvironmentOperation {
  @doc("The unique URI for the environment operation.")
  uri: url;

  @doc("Unique identifier for the environment operation.")
  @minLength(36)
  @maxLength(36)
  @pattern("^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$")
  @visibility("read")
  @key("operationId")
  operationId: Azure.Core.uuid;

  @doc("The kind of operation that occurred.")
  kind: EnvironmentOperationKind;

  @doc("The operation status.")
  status: Azure.Core.Foundations.OperationState;

  @doc("The object ID of the actor which initiated the operation.")
  createdByObjectId?: Azure.Core.uuid;

  @doc("The time the operation started, in RFC3339 format.")
  startTime?: utcDateTime;

  @doc("The time the operation finished, in RFC3339 format.")
  endTime?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "there is no build in type to describe object"
  @doc("Parameters object for the environment at the time of the operation.")
  environmentParameters?: Record<unknown>;

  @doc("Provisioning or operation error details. Populated only for error states.")
  error?: Azure.Core.Foundations.Error;
}

@doc("An upcoming Environment Action.")
@resource("actions")
@parentResource(Environment)
@added(APIVersions.v2024_02_01)
model EnvironmentAction {
  @doc("Uniquely identifies the action.")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility("read")
  @key("actionName")
  name: string;

  @doc("Uri of the action resource.")
  @visibility("read")
  uri: url;

  @doc("The action that will be taken.")
  actionType: EnvironmentActionType;

  @doc("Details about the next run of this action.")
  next?: EnvironmentNextAction;

  @doc("Object Id of the user who last modified the action.")
  @visibility("read")
  lastModifiedBy?: Azure.Core.uuid;

  @doc("Time the object was last modified, in RFC3339 format.")
  lastModifiedAt?: utcDateTime;
}

@doc("Details about the next run of an action.")
@added(APIVersions.v2024_02_01)
model EnvironmentNextAction {
  @doc("The time the action will be triggered (UTC), in RFC3339 format.")
  scheduledTime?: utcDateTime;
}

@doc("A catalog.")
@resource("catalogs")
@parentResource(Project)
model Catalog {
  @doc("The unique URI of the catalog.")
  @added(APIVersions.v2024_02_01)
  uri: url;

  @doc("Name of the catalog.")
  @key("catalogName")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility("read")
  name: string;
}

alias EnvironmentDefinitionListResult = Azure.Core.Page<EnvironmentDefinition>;

@doc("An environment definition.")
@resource("environmentDefinitions")
@parentResource(Catalog)
model EnvironmentDefinition {
  @doc("The unique URI of the environment definition.")
  @added(APIVersions.v2024_02_01)
  uri: url;

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
  @doc("Unique ID of the parameter.")
  id: string;

  @doc("Display name of the parameter.")
  name?: string;

  @doc("Description of the parameter.")
  description?: string;

  @doc("Default value of the parameter.")
  default?: string;

  @doc("""
    A string of one of the basic JSON types (number, integer, array, object,
    boolean, string).
    """)
  type: ParameterType;

  @doc("""
    Whether or not this parameter is read-only.  If true, default should have a
    value.
    """)
  readOnly?: boolean;

  @doc("Whether or not this parameter is required.")
  required: boolean;

  @doc("An array of allowed values.")
  @minItems(1)
  allowed?: string[];
}

alias EnvironmentTypeListResult = Azure.Core.Page<EnvironmentType>;

@doc("Properties of an environment type.")
@resource("environmentTypes")
@parentResource(Project)
model EnvironmentType {
  @doc("The unique URI of the environment type.")
  @added(APIVersions.v2024_02_01)
  uri: url;

  @doc("Name of the environment type.")
  @key("environmentTypeName")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility("read")
  name: string;

  @doc("""
    Id of a subscription or management group that the environment type will be
    mapped to. The environment's resources will be deployed into this subscription
    or management group.
    """)
  deploymentTargetId: string;

  @doc("Indicates whether this environment type is enabled for use in this project.")
  status: EnvironmentTypeEnableStatus;

  @doc("Display name of the environment type.")
  @added(APIVersions.v2024_02_01)
  displayName?: string;
}

@doc("Abilities a user has on an environment type.")
@added(APIVersions.v2024_05_01_preview)
model EnvironmentTypeAbilities {
  @doc("The abilities the user has to perform actions on the environment type as an admin.")
  abilitiesAsAdmin: EnvironmentTypeAbilityAsAdmin[];

  @doc("The abilities the user has to perform actions on the environment type as a developer.")
  abilitiesAsDeveloper: EnvironmentTypeAbilityAsDeveloper[];
}

@doc("Information about a deploy operation on an environment.")
@added(APIVersions.v2024_02_01)
model EnvironmentDeployOperation extends EnvironmentOperation {
  @doc("The kind of operation that occurred.")
  kind: EnvironmentOperationKind.Deploy;
}

@doc("Information about a delete operation on an environment.")
@added(APIVersions.v2024_02_01)
model EnvironmentDeleteOperation extends EnvironmentOperation {
  @doc("The kind of operation that occurred.")
  kind: EnvironmentOperationKind.Delete;
}
