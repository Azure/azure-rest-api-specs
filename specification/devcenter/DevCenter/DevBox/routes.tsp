import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "../shared/routes.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;

interface DevBoxesOperations {
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

  @doc("Creates or replaces a Dev Box.")
  @pollingOperation(SharedOperations.getProjectOperationStatus)
  createDevBox is StandardResourceOperations.LongRunningResourceCreateOrReplace<DevBox>;

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
  start is StandardResourceOperations.LongRunningResourceAction<
    DevBox,
    {},
    ResponseAction
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "can not be represeted by using stand operations"
  // It fits in the LongRunningResourceAction pattern, however we would have to rename the operation to 'stop' - so the path ends with ":stop"
  // But renaming it to 'stop' also makes the client method be renamed to "Stop" - and we want it to be "StopDevBox". Using projectedName does not solve the problem
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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "can not be represeted by using stand operations"
  // It fits in the LongRunningResourceAction pattern, however we would have to rename the operation to 'restart' - so the path ends with ":restart"
  // But renaming it to 'restart' also makes the client method be renamed to "Restart" - and we want it to be "RestartDevBox". Using projectedName does not solve the problem
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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "can not be represeted by using stand operations"
  // It fits in the LongRunningResourceAction pattern, however we would have to rename the operation to 'skip' - so the path ends with ":skip"
  // But renaming it to 'skip' also makes the client method be renamed to "Skip" - and we want it to be "SkipAction". Using projectedName does not solve the problem
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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "can not be represeted by using stand operations"
  // It fits in the LongRunningResourceAction pattern, however we would have to rename the operation to 'delay' - so the path ends with ":delay"
  // But renaming it to 'delay' also makes the client method be renamed to "Delay" - and we want it to be "DelayAction". Using projectedName does not solve the problem
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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "can not be represeted by using stand operations"
  // It fits in the LongRunningResourceAction pattern, however we would have to rename the operation to 'delay' - so the path ends with ":delay"
  // But renaming it to 'delay' also makes the client method be renamed to "Delay" - and we want it to be "DelayAllAction". Using projectedName does not solve the problem
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

interface DevBoxesDevCenterOperations {
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
