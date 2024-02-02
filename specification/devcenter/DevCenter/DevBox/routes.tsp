import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "../shared/routes.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
interface DevBoxesOperations {
  @doc("Lists available pools")
  listPools is StandardResourceOperations.ResourceList<Pool>;

  @doc("Gets a pool")
  getPool is StandardResourceOperations.ResourceRead<Pool>;

  @doc("Lists available schedules for a pool.")
  listSchedules is StandardResourceOperations.ResourceList<Schedule>;

  @doc("Gets a schedule.")
  getSchedule is StandardResourceOperations.ResourceRead<Schedule>;

  @doc("Lists Dev Boxes in the project for a particular user.")
  listDevBoxes is StandardResourceOperations.ResourceList<DevBox>;

  @doc("Gets a Dev Box")
  getDevBox is StandardResourceOperations.ResourceRead<DevBox>;

  @doc("Creates or replaces a Dev Box.")
  @finalOperation(DevBoxesOperations.getDevBox)
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
      devBox: DevBox;
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
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}:start")
  @post
  startDevBox is Foundations.LongRunningOperation<
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
      @statusCode
      statusCode: 202;

      @body
      body: OperationStatus;
    }
  >;

  @doc("Stops a Dev Box")
  @pollingOperation(SharedOperations.getProjectOperationStatus)
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}:stop")
  @post
  stopDevBox is Foundations.LongRunningOperation<
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
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}:restart")
  @post
  restartDevBox is Foundations.LongRunningOperation<
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
      @statusCode
      statusCode: 202;

      @body
      body: OperationStatus;
    }
  >;

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
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}/actions/{actionName}:skip")
  @post
  skipAction is Azure.Core.Foundations.Operation<
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

      @doc("The name of an action that will take place on a Dev Box.")
      @path
      actionName: string;
    },
    void
  >;

  @doc("Delays the occurrence of an action.")
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}/actions/{actionName}:delay")
  @post
  delayAction is Azure.Core.Foundations.Operation<
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

      @doc("The name of an action that will take place on a Dev Box.")
      @path
      actionName: string;

      @doc("The time to delay the Dev Box action or actions until.")
      @query("until")
      delayUntil: utcDateTime;
    },
    DevBoxAction
  >;

  @doc("Delays all actions.")
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}/actions:delay")
  @post
  delayAllActions is Azure.Core.Foundations.Operation<
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

      @doc("The time to delay the Dev Box action or actions until.")
      @query("until")
      delayUntil: utcDateTime;
    },
    DevBoxActionsDelayMultipleResult
  >;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
interface DevBoxesDevCenterOperations {
  @doc("Lists Dev Boxes that the caller has access to in the DevCenter.")
  @route("/devboxes")
  @get
  listAllDevBoxes is Azure.Core.Foundations.Operation<
    {
      @doc("An OData filter clause to apply to the operation.")
      @query
      filter?: string;

      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top?: int32;
    },
    DevBoxListResult
  >;

  @doc("Lists Dev Boxes in the Dev Center for a particular user.")
  @route("/users/{userId}/devboxes")
  @get
  listAllDevBoxesByUser is Azure.Core.Foundations.Operation<
    {
      @doc("An OData filter clause to apply to the operation.")
      @query
      filter?: string;

      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top?: int32;

      @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
      @path
      userId: string;
    },
    DevBoxListResult
  >;
}
