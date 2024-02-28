import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "./routes.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;

interface SharedOperations {
  @doc("Get the status of an operation.")
  getProjectOperationStatus is StandardResourceOperations.ResourceRead<OperationStatus>;
}

interface DevCenter {
  @doc("Lists all projects.")
  listProjects is StandardResourceOperations.ResourceList<Project>;

  @doc("Gets a project.")
  getProject is StandardResourceOperations.ResourceRead<Project>;
}

interface DevBoxes {
  @doc("Lists available pools")
  listPools is StandardResourceOperations.ResourceList<Pool>;

  @doc("Gets a pool")
  getPool is StandardResourceOperations.ResourceRead<Pool>;

  @doc("Lists available schedules for a pool.")
  listSchedules is StandardResourceOperations.ResourceList<Schedule>;

  @doc("Gets a schedule.")
  getSchedule is StandardResourceOperations.ResourceRead<Schedule>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need of reuse DevBoxListResult"
  // This does fit in the ResourceList<DevBox> but since there are three different operations that returns dev box list result,
  // we can't use the standard operation here - it would not allow the use of DevBoxListResult in the other operations.
  // error when using it in other operations: duplicate-type-name 'PagedDevBox' (model DevBoxListResult)
  @doc("Lists Dev Boxes in the project for a particular user.")
  @route("/projects/{projectName}/users/{userId}/devboxes")
  @get
  listDevBoxes is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
      @path
      userId: string;
    },
    DevBoxListResult
  >;

  @doc("Gets a Dev Box")
  getDevBox is StandardResourceOperations.ResourceRead<DevBox>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard operations produce wrong swagger"
  // The standard operation names the body as resource, so the generated swagger has parameter
  //  {
  //     "name": "resource",
  //     "in": "body",
  //  },
  // instead of the desired
  //  {
  //     "name": "body",
  //     "in": "body",
  //  }
  @doc("Creates or replaces a Dev Box.")
  @finalOperation(DevBoxes.getDevBox)
  @pollingOperation(SharedOperations.getProjectOperationStatus)
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}")
  @put
  createDevBox is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute the operation.")
      @path
      projectName: string;

      @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
      @path
      userId: string;

      @doc("The name of a Dev Box.")
      @path
      devBoxName: string;

      @doc("Represents the body request of a Dev Box creation. Dev Box Pool name is required. Optionally set the owner of the Dev Box as local administrator")
      @body
      body: DevBox;
    },
    DevBox | {
      @statusCode statusCode: 201;

      @header("Location")
      location: ResourceLocation<DevBox>;

      @pollingLocation
      @header("Operation-Location")
      operationLocation: string;

      @body body?: DevBox;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern"
  //Can not use LongRunningResourceDelete because response is 202 or error, but we also accept 204 response"
  @doc("Deletes a Dev Box.")
  @pollingOperation(SharedOperations.getProjectOperationStatus)
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}")
  @delete
  deleteDevBox is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
      @path
      userId: string;

      @doc("The name of a Dev Box.")
      @path
      devBoxName: string;
    },
    {
      @statusCode statusCode: 202;

      @header("Location")
      location: string;

      @pollingLocation
      @header("Operation-Location")
      operationLocation: string;

      @body body: OperationStatus;
    } | {
      @statusCode statusCode: 204;
    }
  >;

  @doc("Starts a Dev Box")
  @pollingOperation(SharedOperations.getProjectOperationStatus)
  @action("start")
  startDevBox is StandardResourceOperations.LongRunningResourceAction<
    DevBox,
    {},
    {
      @statusCode
      statusCode: 202;

      @body
      body: OperationStatus;
    }
  >;

  @doc("Stops a Dev Box")
  @pollingOperation(SharedOperations.getProjectOperationStatus)
  @action("stop")
  stopDevBox is StandardResourceOperations.LongRunningResourceAction<
    DevBox,
    {
      @doc("Optional parameter to hibernate the dev box.")
      @query
      hibernate?: boolean;
    },
    {
      @statusCode
      statusCode: 202;

      @body
      body: OperationStatus;
    }
  >;

  @doc("Restarts a Dev Box")
  @pollingOperation(SharedOperations.getProjectOperationStatus)
  @action("restart")
  restartDevBox is StandardResourceOperations.LongRunningResourceAction<
    DevBox,
    {},
    {
      @statusCode
      statusCode: 202;

      @body
      body: OperationStatus;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "can not be represeted by using stand operations"
  //There is no @key for RemoteConnection model
  @doc("Gets RDP Connection info")
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}/remoteConnection")
  @get
  getRemoteConnection is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
      @path
      userId: string;

      @doc("The name of a Dev Box.")
      @path
      devBoxName: string;
    },
    RemoteConnection
  >;

  @doc("Lists actions on a Dev Box.")
  listDevBoxActions is StandardResourceOperations.ResourceList<DevBoxAction>;

  @doc("Gets an action.")
  getDevBoxAction is StandardResourceOperations.ResourceRead<DevBoxAction>;

  @doc("Skips an occurrence of an action.")
  @action("skip")
  skipAction is StandardResourceOperations.ResourceAction<
    DevBoxAction,
    {},
    NoContentResponse
  >;

  @doc("Delays the occurrence of an action.")
  @action("delay")
  delayAction is StandardResourceOperations.ResourceAction<
    DevBoxAction,
    {
      @doc("The time to delay the Dev Box action or actions until.")
      @query("until")
      delayUntil: utcDateTime;
    },
    DevBoxAction
  >;

  @doc("Delays all actions.")
  @action("delay")
  delayAllActions is StandardResourceOperations.ResourceCollectionAction<
    DevBoxAction,
    {
      @doc("The time to delay the Dev Box action or actions until.")
      @query("until")
      delayUntil: utcDateTime;
    },
    DevBoxActionsDelayMultipleResult
  >;
}

interface DevBoxesDevCenter {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern since DevBox has a different path"
  @doc("Lists Dev Boxes that the caller has access to in the DevCenter.")
  @route("/devboxes")
  @get
  listAllDevBoxes is Azure.Core.Foundations.Operation<{}, DevBoxListResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern since DevBox has a different path"
  @doc("Lists Dev Boxes in the Dev Center for a particular user.")
  @route("/users/{userId}/devboxes")
  @get
  listAllDevBoxesByUser is Azure.Core.Foundations.Operation<
    {
      @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
      @path
      userId: string;
    },
    DevBoxListResult
  >;
}

interface Environments {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern since Environment has a different path"
  @doc("Lists the environments for a project.")
  @route("/projects/{projectName}/environments")
  @get
  listAllEnvironments is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
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
  listEnvironments is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
      @path
      userId: string;
    },
    EnvironmentListResult
  >;

  @doc("Gets an environment")
  getEnvironment is StandardResourceOperations.ResourceRead<Environment>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern"
  //Can not use LongRunningCreateOrReplace because response is 200 or 201, but we only respond with 201"
  @doc("Creates or updates an environment.")
  @finalOperation(Environments.getEnvironment)
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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern"
  //Can not use LongRunningResourceDelete because response is 202 or error, but we also accept 204 response"
  @doc("Deletes an environment and all its associated resources")
  @pollingOperation(SharedOperations.getProjectOperationStatus)
  @route("/projects/{projectName}/users/{userId}/environments/{environmentName}")
  @delete
  deleteEnvironment is Azure.Core.Foundations.Operation<
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

  @doc("Lists all of the catalogs available for a project.")
  listCatalogs is StandardResourceOperations.ResourceList<Catalog>;

  @doc("Gets the specified catalog within the project")
  getCatalog is StandardResourceOperations.ResourceRead<Catalog>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern since EnvironmentDefinition has a different path"
  @doc("Lists all environment definitions available for a project.")
  @route("/projects/{projectName}/environmentDefinitions")
  @get
  listEnvironmentDefinitions is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
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
      @path
      projectName: string;

      @doc("The name of the catalog")
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
      @path
      projectName: string;
    },
    EnvironmentTypeListResult
  >;
}
