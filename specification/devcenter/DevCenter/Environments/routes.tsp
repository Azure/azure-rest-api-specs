import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "./parameters.tsp";
import "../shared/routes.tsp";
import "../shared/parameters.tsp";

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
      ...ProjectNameParameter;
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
      ...ProjectNameParameter;
      ...UserIdParameter;
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
      ...ProjectNameParameter;
      ...UserIdParameter;
      ...EnvironmentNameParameter;

      @doc("Represents an environment.")
      @bodyRoot
      body: Environment;
    },
    {
      @statusCode
      statusCode: 201;

      @pollingLocation
      @header("Operation-Location")
      operationLocation: string;

      @bodyRoot body: Environment;
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

      ...ProjectNameParameter;
      ...UserIdParameter;
      ...EnvironmentNameParameter;

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
      ...ProjectNameParameter;
      ...UserIdParameter;
      ...EnvironmentNameParameter;
      ...ForceDeleteEnvironmentQueryParameter;
    },
    {
      @statusCode
      statusCode: 202;

      @bodyRoot body: OperationStatus;

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
      ...ProjectNameParameter;
      ...UserIdParameter;
      ...EnvironmentNameParameter;
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
      ...ProjectNameParameter;
      ...UserIdParameter;
      ...EnvironmentNameParameter;

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
      @doc("The time to delay the Environment action until, in RFC3339 format.")
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
      ...ProjectNameParameter;
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
      ...ProjectNameParameter;

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

  @doc("Lists all environment types configured for a project.")
  listEnvironmentTypes is StandardResourceOperations.ResourceList<EnvironmentType>;

  @doc("Get an environment type configured for a project.")
  @added(APIVersions.v2024_05_01_preview)
  getEnvironmentTypes is StandardResourceOperations.ResourceRead<EnvironmentType>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "no @key for EnvironmentTypeAbilities model"
  @doc("Gets the signed-in user's permitted abilities in an environment type.")
  @get
  @route("projects/{projectName}/environmentTypes/{environmentTypeName}/users/{userId}/abilities")
  @added(APIVersions.v2024_05_01_preview)
  getEnvironmentTypeAbilities is Azure.Core.Foundations.Operation<
    {
      ...ProjectNameParameter;

      @doc("The name of the environment type")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      environmentTypeName: string;

      ...UserIdParameter;

      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top?: int32;
    },
    EnvironmentTypeAbilities
  >;
}
