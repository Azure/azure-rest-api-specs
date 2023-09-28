import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace DevCenter;

interface DevBoxesOperations {
  @doc("Lists available pools")
  @route("/projects/{projectName}/pools")
  @get
  ListPools is DevCenterBaseResponse<
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
    },
    PoolListResult
  >;

  @doc("Gets a pool")
  @route("/projects/{projectName}/pools/{poolName}")
  @get
  GetPool is DevCenterBaseResponse<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The name of a pool of Dev Boxes.")
      @path
      poolName: string;
    },
    Pool
  >;

  @doc("Lists available schedules for a pool.")
  @route("/projects/{projectName}/pools/{poolName}/schedules")
  @get
  ListSchedulesByPool is DevCenterBaseResponse<
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

      @doc("The name of a pool of Dev Boxes.")
      @path
      poolName: string;
    },
    ScheduleListResult
  >;

  @doc("Lists available schedules for a pool.")
  @route("/projects/{projectName}/schedules")
  @get
  ListSchedulesByProject is DevCenterBaseResponse<
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
    },
    ScheduleListResult
  >;

  @doc("Gets a schedule.")
  @route("/projects/{projectName}/pools/{poolName}/schedules/{scheduleName}")
  @get
  GetScheduleByPool is DevCenterBaseResponse<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("The name of a pool of Dev Boxes.")
      @path
      poolName: string;

      @doc("The name of a schedule.")
      @path
      scheduleName: string;
    },
    Schedule
  >;

  @doc("Lists Dev Boxes in the project for a particular user.")
  @route("/projects/{projectName}/users/{userId}/devboxes")
  @get
  ListDevBoxesByUser is DevCenterBaseResponse<
    {
      @doc("An OData filter clause to apply to the operation.")
      @query
      filter: string;

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
    DevBoxListResult
  >;

  @doc("Gets a Dev Box")
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}")
  @get
  GetDevBoxByUser is DevCenterBaseResponse<
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

      @doc("The name of a Dev Box.")
      @path
      devBoxName: string;
    },
    DevBox
  >;

  @doc("Creates or replaces a Dev Box.")
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}")
  @put
  CreateDevBox is DevCenterBaseResponse<
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

      @doc("The name of a Dev Box.")
      @path
      devBoxName: string;

      @doc("Represents a environment.")
      @body
      body: DevBox;
    },
    DevBox | {
      @statusCode statusCode: 201;

      @body body: DevBox;
    }
  >;

  @doc("Deletes a Dev Box.")
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}")
  @delete
  DeleteDevBox is DevCenterBaseResponse<
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

      @doc("The name of a Dev Box.")
      @path
      devBoxName: string;
    },
    { 
      @statusCode statusCode: 202;

      @body body: OperationStatus;

      @header("Operation-Location") operationLocation: string;
    } | void
  >;

  @doc("Starts a Dev Box")
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}:start")
  @post
  StartDevBox is DevCenterBaseResponse<
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

      @doc("The name of a Dev Box.")
      @path
      devBoxName: string;
    },
    OperationStatus
  >;

  @doc("Stops a Dev Box")
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}:stop")
  @post
  StopDevBox is DevCenterBaseResponse<
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

      @doc("The name of a Dev Box.")
      @path
      devBoxName: string;

      @doc("Optional parameter to hibernate the dev box.")
      @query
      hibernate: boolean;
    },
    OperationStatus
  >;

  @doc("Restarts a Dev Box")
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}:restart")
  @post
  RestartDevBox is DevCenterBaseResponse<
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

      @doc("The name of a Dev Box.")
      @path
      devBoxName: string;
    },
    OperationStatus
  >;

  @doc("Gets RDP Connection info")
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}/remoteConnection")
  @get
  GetRemoteConnection is DevCenterBaseResponse<
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

      @doc("The name of a Dev Box.")
      @path
      devBoxName: string;
    },
    RemoteConnection
  >;

  @doc("Lists actions on a Dev Box.")
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}/actions")
  @get
  ListActions is DevCenterBaseResponse<
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

      @doc("The name of a Dev Box.")
      @path
      devBoxName: string;
    },
    DevBoxActionsListResult
  >;

  @doc("Gets an action.")
//   @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}/actions/{actionName}")
//   @get
//   GetAction is DevCenterBaseResponse<
//     {
//       @doc("The DevCenter Project upon which to execute operations.")
//       @path
//       projectName: string;

//       @doc("""
// The AAD object id of the user. If value is 'me', the identity is taken from the
// authentication context.
// """)
//       @path
//       userId: string;

//       @doc("The name of a Dev Box.")
//       @path
//       devBoxName: string;

//       @doc("The name of an action that will take place on a Dev Box.")
//       @path
//       actionName: string;
//     },
//     DevBoxAction
//   >;
  GetAction is StandardResourceOperations.ResourceRead<DevBoxAction>;

  @doc("Skips an occurrence of an action.")
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}/actions/{actionName}:skip")
  @post
  SkipAction is DevCenterBaseResponse<
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
  DelayAction is DevCenterBaseResponse<
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

      @doc("The name of a Dev Box.")
      @path
      devBoxName: string;

      @doc("The name of an action that will take place on a Dev Box.")
      @path
      actionName: string;

      @doc("The time to delay the Dev Box action or actions until.")
      @query
      until: utcDateTime;
    },
    DevBoxAction
  >;

  @doc("Delays all actions.")
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}/actions:delay")
  @post
  DelayActions is DevCenterBaseResponse<
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

      @doc("The name of a Dev Box.")
      @path
      devBoxName: string;

      @doc("The time to delay the Dev Box action or actions until.")
      @query
      until: utcDateTime;
    },
    DevBoxActionsDelayMultipleResult
  >;
}

interface DevBoxesDevCenterOperations {
  @doc("Lists Dev Boxes that the caller has access to in the DevCenter.")
  @route("/devboxes")
  @get
  ListAllDevBoxes is DevCenterBaseResponse<
    {
      @doc("An OData filter clause to apply to the operation.")
      @query
      filter: string;

      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top: int32;
    },
    DevBoxListResult
  >;

  @doc("Lists Dev Boxes in the Dev Center for a particular user.")
  @route("/users/{userId}/devboxes")
  @get
  ListAllDevBoxesByUser is DevCenterBaseResponse<
    {
      @doc("An OData filter clause to apply to the operation.")
      @query
      filter: string;

      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top: int32;

      @doc("""
The AAD object id of the user. If value is 'me', the identity is taken from the
authentication context.
""")
      @path
      userId: string;
    },
    DevBoxListResult
  >;

  @added(APIVersions.v2023_09_01_preview)
  @doc("Lists operations on the environment which have occurred within the past 90 days")
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}/operations")
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

      @doc("The name of a Dev Box.")
      @path
      devBoxName: string;
    },
    DevBoxOperationListResult
  >;

  @added(APIVersions.v2023_09_01_preview)
  @doc("Starts a Dev Box")
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}:repair")
  @post
  RepairDevBox is Foundations.LongRunningOperation<
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

      @doc("The name of a Dev Box.")
      @path
      devBoxName: string;
    },
    {
      @statusCode
      statusCode: 202;
      @body
      body: OperationStatus
    },
    {},
    CloudError
  >;
}
