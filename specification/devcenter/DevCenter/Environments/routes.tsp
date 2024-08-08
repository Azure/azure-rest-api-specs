import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "../shared/routes.tsp";

using Azure.Core;
using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;

interface Environments {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern since Environment has a different path"
  @doc("Lists the environments for a project.")
  @route("/projects/{projectName}/environments")
  @get
  listEnvironments is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      projectName: string;
    },
    EnvironmentListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need of reuse EnvironmentListResult"
  // This does fit in the ResourceList<Environment> but since listAllEnvironments also uses environment list result,
  // we can't use the standard operation here - it would not allow the use of EnvironmentListResult in the other operation.
  // error when using it in other operation: duplicate-type-name 'PagedEnvironment' (model EnvironmentListResult)
  @doc("Lists the environments for a project and user.")
  @route("/projects/{projectName}/users/{userId}/environments")
  @get
  listEnvironmentsByUser is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      projectName: string;

      @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
      @maxLength(36)
      @minLength(2)
      @pattern("^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$|^me$")
      @path
      userId: string;
    },
    EnvironmentListResult
  >;

  @doc("Gets an environment.")
  getEnvironmentByUser is StandardResourceOperations.ResourceRead<Environment>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern"
  //Can not use LongRunningCreateOrReplace because response is 200 or 201, but we only respond with 201"
  @doc("Creates or updates an environment.")
  @finalOperation(Environments.getEnvironmentByUser)
  @pollingOperation(OperationStatuses.get)
  @route("/projects/{projectName}/users/{userId}/environments/{environmentName}")
  @put
  createOrReplaceEnvironment is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      projectName: string;

      @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
      @maxLength(36)
      @minLength(2)
      @pattern("^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$|^me$")
      @path
      userId: string;

      @doc("The name of the environment.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      environmentName: string;

      @doc("Represents an environment.")
      @body
      body: Environment;
    },
    {
      @statusCode
      statusCode: 201;

      @pollingLocation
      @header("Operation-Location")
      operationLocation: string;

      @body body: Environment;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard operations produce wrong operation definition"
  @doc("Partially updates an environment.")
  @route("/projects/{projectName}/users/{userId}/environments/{environmentName}")
  @patch
  @added(APIVersions.v2024_02_01)
  patchEnvironment is Azure.Core.Foundations.Operation<
    {
      @doc("Set consumer to JSON merge patch.")
      @header
      contentType: "application/merge-patch+json";

      @doc("The DevCenter Project upon which to execute operations.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      projectName: string;

      @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
      @maxLength(36)
      @minLength(2)
      @pattern("^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$|^me$")
      @path
      userId: string;

      @doc("The name of the environment.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      environmentName: string;

      @doc("Represents an environment.")
      @body
      body: Environment;
    },
    Environment
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern"
  //Can not use LongRunningResourceDelete because response is 202 or error, but we also accept 204 response"
  @doc("Deletes an environment and all its associated resources")
  @pollingOperation(OperationStatuses.get)
  @route("/projects/{projectName}/users/{userId}/environments/{environmentName}")
  @delete
  deleteEnvironment is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      projectName: string;

      @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
      @maxLength(36)
      @minLength(2)
      @pattern("^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$|^me$")
      @path
      userId: string;

      @doc("The name of the environment.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      environmentName: string;
    },
    {
      @statusCode
      statusCode: 202;

      @body body: OperationStatus;

      @header("Location")
      location: string;

      @pollingLocation
      @header("Operation-Location")
      operationLocation: string;
    } | {
      @statusCode
      statusCode: 204;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Missing key"
  @doc("Gets Outputs from the environment.")
  @route("/projects/{projectName}/users/{userId}/environments/{environmentName}/outputs")
  @get
  @added(APIVersions.v2024_02_01)
  getOutputs is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      projectName: string;

      @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
      @maxLength(36)
      @minLength(2)
      @pattern("^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$|^me$")
      @path
      userId: string;

      @doc("The name of the environment.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      environmentName: string;
    },
    EnvironmentOutputs
  >;

  @doc("Lists operations on the environment which have occurred within the past 90 days")
  @added(APIVersions.v2024_02_01)
  listOperations is StandardResourceOperations.ResourceList<EnvironmentOperation>;

  @doc("Gets an environment action result.")
  @added(APIVersions.v2024_02_01)
  getOperation is StandardResourceOperations.ResourceRead<EnvironmentOperation>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Missing key"
  @doc("Gets the logs for an operation on an environment.")
  @route("/projects/{projectName}/users/{userId}/environments/{environmentName}/operations/{operationId}/logs")
  @get
  @added(APIVersions.v2024_02_01)
  getLogsByOperation is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      projectName: string;

      @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
      @maxLength(36)
      @minLength(2)
      @pattern("^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$|^me$")
      @path
      userId: string;

      @doc("The name of the environment.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      environmentName: string;

      @doc("The id of the operation on an environment.")
      @maxLength(36)
      @minLength(36)
      @pattern("^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$")
      @path
      operationId: string;
    },
    {
      @doc("Set producer to text/plain")
      @header
      contentType: "text/plain";

      @body
      body: string;

      @statusCode
      statusCode: 200;
    }
  >;

  @doc("Get all scheduled actions for a user within an environment.")
  @added(APIVersions.v2024_02_01)
  listActions is StandardResourceOperations.ResourceList<EnvironmentAction>;

  @doc("Retrieve a specific environment action.")
  @added(APIVersions.v2024_02_01)
  getAction is StandardResourceOperations.ResourceRead<EnvironmentAction>;

  @doc("Skips an occurrence of an action.")
  @action("skip")
  @added(APIVersions.v2024_02_01)
  skipAction is StandardResourceOperations.ResourceAction<
    EnvironmentAction,
    {},
    NoContentResponse
  >;

  @doc("Delays the occurrence of an action.")
  @action("delay")
  @added(APIVersions.v2024_02_01)
  delayAction is StandardResourceOperations.ResourceAction<
    EnvironmentAction,
    {
      @doc("The time to delay the Environment action until.")
      @query("until")
      until: utcDateTime;
    },
    EnvironmentAction
  >;

  @doc("Lists all of the catalogs available for a project.")
  listCatalogsByProject is StandardResourceOperations.ResourceList<Catalog>;

  @doc("Gets the specified catalog within the project.")
  getCatalog is StandardResourceOperations.ResourceRead<Catalog>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern since EnvironmentDefinition has a different path"
  @doc("Lists all environment definitions available for a project.")
  @route("/projects/{projectName}/environmentDefinitions")
  @get
  listEnvironmentDefinitionsByProject is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      projectName: string;
    },
    EnvironmentDefinitionListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need of reuse EnvironmentDefinitionListResult"
  // This does fit in the ResourceList<EnvironmentDefinition> but since listEnvironmentDefinitions also uses environment list result,
  // we can't use the standard operation here - it would not allow the use of EnvironmentDefinitionListResult in the other operation.
  // error when using it in other operation: duplicate-type-name 'PagedEnvironmentDefinition' (model EnvironmentDefinitionListResult)
  @doc("Lists all environment definitions available within a catalog.")
  @route("/projects/{projectName}/catalogs/{catalogName}/environmentDefinitions")
  @get
  listEnvironmentDefinitionsByCatalog is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      projectName: string;

      @doc("The name of the catalog")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      catalogName: string;
    },
    EnvironmentDefinitionListResult
  >;

  @doc("Get an environment definition from a catalog.")
  getEnvironmentDefinition is StandardResourceOperations.ResourceRead<EnvironmentDefinition>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "can not be represeted by using stand operations since there is no @key for EnvironmentType model"
  @doc("Lists all environment types configured for a project.")
  @route("/projects/{projectName}/environmentTypes")
  @get
  listEnvironmentTypes is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      projectName: string;
    },
    EnvironmentTypeListResult
  >;
}
