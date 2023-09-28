import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using Azure.Core;
using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenter;

interface EnvironmentsOperations {
  @doc("Lists the environments for a project.")
  @route("/projects/{projectName}/environments")
  @get
  ListEnvironments is DevCenterBaseResponse<
    {
      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top: int32;

      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;
    },
    EnvironmentListResult
  >;

  @doc("Lists the environments for a project and user.")
  @route("/projects/{projectName}/users/{userId}/environments")
  @get
  ListEnvironmentsByUser is DevCenterBaseResponse<
    {
      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top: int32;

      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("""
The AAD object id of the user. If value is 'me', the identity is taken from the
authentication context.
""")
      @path
      userId: string;
    },
    EnvironmentListResult
  >;

  @doc("Gets an environment")
  @route("/projects/{projectName}/users/{userId}/environments/{environmentName}")
  @get
  GetEnvironmentByUser is DevCenterBaseResponse<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("""
The AAD object id of the user. If value is 'me', the identity is taken from the
authentication context.
""")
      @path
      userId: string;

      @doc("The name of the environment.")
      @path
      environmentName: string;
    },
    Environment
  >;

  @doc("Creates or updates an environment.")
  @route("/projects/{projectName}/users/{userId}/environments/{environmentName}")
  @put
  CreateOrReplaceEnvironment is Foundations.LongRunningOperation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("""
The AAD object id of the user. If value is 'me', the identity is taken from the
authentication context.
""")
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
      @body body: Environment;
    },
    {},
    CloudError
  >;

// FIXME
  @doc("Deletes an environment and all its associated resources")
  @route("/projects/{projectName}/users/{userId}/environments/{environmentName}")
  @delete
  DeleteEnvironment(
    ...Foundations.ApiVersionParameter;

    @doc("The DevCenter Project upon which to execute operations.")
    @path
    projectName: string;

    @doc("""
The AAD object id of the user. If value is 'me', the identity is taken from the
authentication context.
""")
    @path
    userId: string;

    @doc("The name of the environment.")
    @path
    environmentName: string;
  ):
    {
      @statusCode
      statusCode: 202;
      @body body: OperationStatus;
    } & { 
      @pollingLocation
      @header("Operation-Location")
      operationLocation: string} | {
      @statusCode
      statusCode: 204;
    } | CloudError;

  @doc("Lists all of the catalogs available for a project.")
  @route("/projects/{projectName}/catalogs")
  @get
  ListCatalogsByProject is DevCenterBaseResponse<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top: int32;
    },
    CatalogListResult
  >;

  @doc("Gets the specified catalog within the project")
  @route("/projects/{projectName}/catalogs/{catalogName}")
  @get
  GetCatalog is DevCenterBaseResponse<
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
  ListEnvironmentDefinitionsByProject is DevCenterBaseResponse<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top: int32;
    },
    EnvironmentDefinitionListResult
  >;

  @doc("Lists all environment definitions available within a catalog.")
  @route("/projects/{projectName}/catalogs/{catalogName}/environmentDefinitions")
  @get
  ListEnvironmentDefinitionsByCatalog is DevCenterBaseResponse<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top: int32;

      @doc("The name of the catalog")
      @path
      catalogName: string;
    },
    EnvironmentDefinitionListResult
  >;

  @doc("Get an environment definition from a catalog.")
  @route("/projects/{projectName}/catalogs/{catalogName}/environmentDefinitions/{definitionName}")
  @get
  GetEnvironmentDefinition is DevCenterBaseResponse<
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
  ListEnvironmentTypes is DevCenterBaseResponse<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top: int32;
    },
    EnvironmentTypeListResult
  >;

  @added(APIVersions.v2023_09_01_preview)
  @doc("Lists operations on the environment which have occurred within the past 90 days")
  @route("/projects/{projectName}/users/{userId}/environments/{environmentName}/operations")
  @get
  ListOperations is DevCenterBaseResponse<
    {
      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top: int32;

      @doc("An OData filter clause to apply to the operation.")
      @query
      filter: string;

      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("""
  The AAD object id of the user. If value is 'me', the identity is taken from the
  authentication context.
  """)
      @path
      userId: string;

      @doc("The name of the environment.")
      @path
      environmentName: string;
    },
    EnvironmentOperationListResult
  >;

  @added(APIVersions.v2023_09_01_preview)
  @doc("Gets an environment action result.")
  @route("/projects/{projectName}/users/{userId}/environments/{environmentName}/operations/{operationId}")
  @get
  GetOperation is DevCenterBaseResponse<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("""
  The AAD object id of the user. If value is 'me', the identity is taken from the
  authentication context.
  """)
      @path
      userId: string;

      @doc("The name of the environment.")
      @path
      environmentName: string;

      @doc("The id of the operation on an environment.")
      @path
      operationId: string;
    },
    EnvironmentOperation
  >;

  @added(APIVersions.v2023_09_01_preview)
  @doc("Gets the logs for an operation on an environment.")
  @route("/projects/{projectName}/users/{userId}/environments/{environmentName}/operations/{operationId}/logs")
  @get
  GetLogsByOperation is DevCenterBaseResponse<
  {
    @doc("The DevCenter Project upon which to execute operations.")
    @path
    projectName: string;

    @doc("""
The AAD object id of the user. If value is 'me', the identity is taken from the
authentication context.
""")
    @path
    userId: string;

    @doc("The name of the environment.")
    @path
    environmentName: string;

    @doc("The id of the operation on an environment.")
    @path
    operationId: string;
  },
  string
  >;
}
