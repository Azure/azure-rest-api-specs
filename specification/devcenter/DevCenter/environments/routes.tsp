import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "../shared/routes.tsp";

using Azure.Core;
using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
interface EnvironmentsOperations {
  @doc("Lists the environments for a project.")
  @route("/projects/{projectName}/environments")
  @get
  listAllEnvironments is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top?: int32;
    },
    EnvironmentListResult
  >;

  @doc("Lists the environments for a project and user.")
  @route("/projects/{projectName}/users/{userId}/environments")
  @get
  listEnvironments is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
      @path
      userId: string;

      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top?: int32;
    },
    EnvironmentListResult
  >;

  @doc("Gets an environment")
  @route("/projects/{projectName}/users/{userId}/environments/{environmentName}")
  @get
  getEnvironment is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
      @path
      userId: string;

      @doc("The name of the environment.")
      @path
      environmentName: string;
    },
    Environment
  >;

  @doc("Creates or updates an environment.")
  @finalOperation(EnvironmentsOperations.getEnvironment)
  @pollingOperation(SharedOperations.getProjectOperationStatus)
  @route("/projects/{projectName}/users/{userId}/environments/{environmentName}")
  @put
  createOrUpdateEnvironment is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
      @path
      userId: string;

      @doc("The name of the environment.")
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

  // FIXME
  @doc("Deletes an environment and all its associated resources")
  @pollingOperation(SharedOperations.getProjectOperationStatus)
  @route("/projects/{projectName}/users/{userId}/environments/{environmentName}")
  @delete
  deleteEnvironment(
    ...Foundations.ApiVersionParameter,

    @doc("The DevCenter Project upon which to execute operations.")
    @path
    projectName: string,

    @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
    @path
    userId: string,

    @doc("The name of the environment.")
    @path
    environmentName: string,
  ): {
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
  } | Azure.Core.Foundations.ErrorResponse;

  @doc("Lists all of the catalogs available for a project.")
  @route("/projects/{projectName}/catalogs")
  @get
  listCatalogs is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top?: int32;
    },
    CatalogListResult
  >;

  @doc("Gets the specified catalog within the project")
  @route("/projects/{projectName}/catalogs/{catalogName}")
  @get
  getCatalog is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The name of the catalog")
      @path
      catalogName: string;
    },
    Catalog
  >;

  @doc("Lists all environment definitions available for a project.")
  @route("/projects/{projectName}/environmentDefinitions")
  @get
  listEnvironmentDefinitions is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top?: int32;
    },
    EnvironmentDefinitionListResult
  >;

  @doc("Lists all environment definitions available within a catalog.")
  @route("/projects/{projectName}/catalogs/{catalogName}/environmentDefinitions")
  @get
  listEnvironmentDefinitionsByCatalog is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The name of the catalog")
      @path
      catalogName: string;

      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top?: int32;
    },
    EnvironmentDefinitionListResult
  >;

  @doc("Get an environment definition from a catalog.")
  @route("/projects/{projectName}/catalogs/{catalogName}/environmentDefinitions/{definitionName}")
  @get
  getEnvironmentDefinition is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The name of the catalog")
      @path
      catalogName: string;

      @doc("The name of the environment definition")
      @path
      definitionName: string;
    },
    EnvironmentDefinition
  >;

  @doc("Lists all environment types configured for a project.")
  @route("/projects/{projectName}/environmentTypes")
  @get
  listEnvironmentTypes is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top?: int32;
    },
    EnvironmentTypeListResult
  >;
}
