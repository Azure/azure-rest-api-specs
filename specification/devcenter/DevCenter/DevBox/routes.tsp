import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "./parameters.tsp";
import "../shared/routes.tsp";
import "../shared/parameters.tsp";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace DevCenterService;

alias DevCenterOps = DevCenterResourceOperations<Traits.NoConditionalRequests &
  Traits.NoRepeatableRequests &
  Traits.NoClientRequestId>;

interface DevBoxes {
  @doc("Lists available pools.")
  listPools is StandardResourceOperations.ResourceList<Pool>;

  @doc("Gets a pool.")
  getPool is StandardResourceOperations.ResourceRead<Pool>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Replacing Status Monitor"
  @doc("Aligns all Dev Boxes in the pool with the current configuration.")
  @pollingOperation(OperationStatuses.get)
  @action("align")
  @added(APIVersions.v2025_04_01_preview)
  alignPool is DevCenterOps.LongRunningResourceAction<
    Pool,
    PoolAlignBody,
    OperationStatus
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern since DevBox has a different path"
  @doc("Lists Dev Boxes that the caller has access to in the DevCenter.")
  @route("/devboxes")
  @get
  @list
  listAllDevBoxes is Azure.Core.Foundations.Operation<{}, DevBoxListResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern since DevBox has a different path"
  @doc("Lists Dev Boxes in the Dev Center for a particular user.")
  @route("/users/{userId}/devboxes")
  @get
  @list
  listAllDevBoxesByUser is Azure.Core.Foundations.Operation<
    {
      ...UserIdParameter;
    },
    DevBoxListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need of reuse ScheduleListResult"
  // Alternate route to return same list response of Schedules
  @doc("Lists all schedules within a pool that are configured by your project administrator.")
  @route("/projects/{projectName}/pools/{poolName}/schedules")
  @get
  @list
  listSchedulesByPool is Azure.Core.Foundations.Operation<
    {
      ...ProjectNameParameter;

      @doc("The name of a pool of Dev Boxes.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      poolName: string;
    },
    ScheduleListResult
  >;

  @doc("Gets a schedule.")
  getScheduleByPool is StandardResourceOperations.ResourceRead<Schedule>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need of reuse ScheduleListResult"
  // Alternate route to return same list response of Schedules
  @doc("Lists all schedules within a project that are configured by your project administrator.")
  @route("/projects/{projectName}/schedules")
  @added(APIVersions.v2024_02_01)
  @list
  listSchedulesByProject is Azure.Core.Foundations.Operation<
    {
      ...ProjectNameParameter;
    },
    ScheduleListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need of reuse DevBoxListResult"
  // This does fit in the ResourceList<DevBox> but since there are three different operations that returns dev box list result,
  // we can't use the standard operation here - it would not allow the use of DevBoxListResult in the other operations.
  // error when using it in other operations: duplicate-type-name 'PagedDevBox' (model DevBoxListResult)
  @doc("Lists Dev Boxes in the project for a particular user.")
  @route("/projects/{projectName}/users/{userId}/devboxes")
  @get
  @list
  listDevBoxesByUser is Azure.Core.Foundations.Operation<
    {
      ...ProjectNameParameter;
      ...UserIdParameter;
    },
    DevBoxListResult
  >;

  @doc("Gets a Dev Box.")
  getDevBoxByUser is StandardResourceOperations.ResourceRead<DevBox>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
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
  @finalOperation(DevBoxes.getDevBoxByUser)
  @pollingOperation(OperationStatuses.get)
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}")
  @put
  createDevBox is Azure.Core.Foundations.Operation<
    {
      ...ProjectNameParameter;
      ...UserIdParameter;
      ...DevBoxNameParameter;

      @doc("Represents the body request of a Dev Box creation. Dev Box Pool name is required. Optionally set the owner of the Dev Box as local administrator")
      @bodyRoot
      body: DevBox;
    },
    DevBox | {
      @statusCode statusCode: 201;

      @header("Location")
      location: ResourceLocation<DevBox>;

      @pollingLocation
      @header("Operation-Location")
      operationLocation: string;

      @bodyRoot body?: DevBox;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern"
  //Can not use LongRunningResourceDelete because response is 202 or error, but we also accept 204 response"
  @doc("Deletes a Dev Box.")
  @pollingOperation(OperationStatuses.get)
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}")
  @delete
  deleteDevBox is Azure.Core.Foundations.Operation<
    {
      ...ProjectNameParameter;
      ...UserIdParameter;
      ...DevBoxNameParameter;
    },
    {
      @statusCode statusCode: 202;

      @header("Location")
      location: string;

      @pollingLocation
      @header("Operation-Location")
      operationLocation: string;

      @bodyRoot body: OperationStatus;
    } | {
      @statusCode statusCode: 204;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Replacing Status Monitor"
  @doc("Approves the creation of a Dev Box.")
  @pollingOperation(OperationStatuses.get)
  @action("approve")
  @added(APIVersions.v2025_04_01_preview)
  approveDevBox is DevCenterOps.LongRunningResourceAction<
    DevBox,
    {},
    OperationStatus
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Replacing Status Monitor"
  @doc("Starts a Dev Box.")
  @pollingOperation(OperationStatuses.get)
  @action("start")
  startDevBox is DevCenterOps.LongRunningResourceAction<
    DevBox,
    {},
    OperationStatus
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Replacing Status Monitor"
  @doc("Stops a Dev Box.")
  @pollingOperation(OperationStatuses.get)
  @action("stop")
  stopDevBox is DevCenterOps.LongRunningResourceAction<
    DevBox,
    {
      ...HibernateQueryParameter;
    },
    OperationStatus
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Replacing Status Monitor"
  @doc("Restarts a Dev Box.")
  @pollingOperation(OperationStatuses.get)
  @action("restart")
  restartDevBox is DevCenterOps.LongRunningResourceAction<
    DevBox,
    {},
    OperationStatus
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Replacing Status Monitor"
  @doc("Aligns a Dev Box to the pools current pool configuration.")
  @pollingOperation(OperationStatuses.get)
  @action("align")
  @added(APIVersions.v2025_04_01_preview)
  alignDevBox is DevCenterOps.LongRunningResourceAction<
    DevBox,
    PoolAlignBody,
    OperationStatus
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Replacing Status Monitor"
  @doc("Attempts automated repair steps to resolve common problems on a Dev Box. The Dev Box may restart during this operation.")
  @pollingOperation(OperationStatuses.get)
  @action("repair")
  @added(APIVersions.v2024_02_01)
  repairDevBox is DevCenterOps.LongRunningResourceAction<
    DevBox,
    {},
    OperationStatus
  >;

  @doc("Lets a user set their own active hours for their Dev Box, overriding the defaults set at the pool level.")
  @action("setActiveHours")
  @added(APIVersions.v2025_04_01_preview)
  setActiveHours is StandardResourceOperations.ResourceAction<
    DevBox,
    {
      @doc("Manual user set active hours configuration.")
      @body
      body: UserActiveHoursConfiguration;
    },
    DevBox
  >;

  @doc("""
      Lists customization groups on the Dev Box. Listed customization groups exclude
      task information unless specified via the include parameter.
    """)
  @added(APIVersions.v2024_05_01_preview)
  listCustomizationGroups is StandardResourceOperations.ResourceList<
    CustomizationGroup,
    QueryParametersTrait<{
      @doc("Optional query parameter to specify what properties should be included in the response.")
      @query
      include?: ListCustomizationGroupsIncludeProperty;
    }>
  >;

  @doc("""
      Gets a customization group.
    """)
  @added(APIVersions.v2024_05_01_preview)
  getCustomizationGroup is StandardResourceOperations.ResourceRead<CustomizationGroup>;

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
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
  @doc("Applies customizations to the Dev Box.")
  @put
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}/customizationGroups/{customizationGroupName}")
  @added(APIVersions.v2024_05_01_preview)
  createCustomizationGroup is Azure.Core.Foundations.Operation<
    {
      ...ProjectNameParameter;
      ...UserIdParameter;
      ...DevBoxNameParameter;

      @doc("A customization group name.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      customizationGroupName: string;

      @doc("Represents the body request of a Dev Box creation. Dev Box Pool name is required. Optionally set the owner of the Dev Box as local administrator")
      @body
      body: CustomizationGroup;
    },
    CustomizationGroup
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No model for this."
  @doc("Gets the log for a customization task.")
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}/customizationGroups/{customizationGroupName}/logs/{customizationTaskId}")
  @get
  @added(APIVersions.v2024_05_01_preview)
  getCustomizationTaskLog is Azure.Core.Foundations.Operation<
    {
      ...ProjectNameParameter;
      ...UserIdParameter;
      ...DevBoxNameParameter;

      @doc("A customization group name.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
      @path
      customizationGroupName: string;

      @doc("A customization task ID.")
      @maxLength(36)
      @minLength(36)
      @pattern("^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$")
      @path
      customizationTaskId: string;
    },
    {
      @doc("Set producer to text/plain")
      @header
      contentType: "text/plain";

      @body
      body: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard operations produce route with /catalogs, but we only allow list on /projects"
  @doc("Lists all customization tasks available to the project.")
  @route("/projects/{projectName}/customizationTasks")
  @get
  @added(APIVersions.v2024_05_01_preview)
  @list
  listCustomizationTaskDefinitionsByProject is Azure.Core.Foundations.Operation<
    {
      ...ProjectNameParameter;
    },
    PagedCustomizationTaskDefinition
  >;

  @doc("Gets a customization task.")
  @added(APIVersions.v2024_05_01_preview)
  getCustomizationTaskDefinitions is StandardResourceOperations.ResourceRead<CustomizationTaskDefinition>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "StandardOperations produces route on an specific customizationTask, but we want it on the group"
  @doc("Validates a list of customization tasks.")
  @route("/projects/{projectName}/customizationTasks:validateGroup")
  @pollingOperation(OperationStatuses.get)
  @added(APIVersions.v2024_05_01_preview)
  validateCustomizationTasksAction is Azure.Core.Foundations.Operation<
    {
      ...ProjectNameParameter;

      @doc("Customization tasks to validate.")
      @body
      body: CustomizationTaskList;
    },
    {
      @statusCode
      statusCode: 202;

      @header("Location")
      location: string;

      @pollingLocation
      @header("Operation-Location")
      operationLocation: string;

      @body
      @added(APIVersions.v2024_05_01_preview)
      body: CustomizationTaskListValidationOperationResult;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "can not be represeted by using stand operations"
  //There is no @key for RemoteConnection model
  @doc("Gets RDP Connection info.")
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}/remoteConnection")
  @get
  getRemoteConnection is Azure.Core.Foundations.Operation<
    {
      ...ProjectNameParameter;
      ...UserIdParameter;
      ...DevBoxNameParameter;
    },
    RemoteConnection
  >;

  @doc("Lists actions on a Dev Box.")
  listActions is StandardResourceOperations.ResourceList<DevBoxAction>;

  @doc("Gets an action.")
  getAction is StandardResourceOperations.ResourceRead<DevBoxAction>;

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
      ...DelayUntilQueryParameter;
    },
    DevBoxAction
  >;

  @doc("Delays all actions.")
  @action("delay")
  @list
  delayActions is StandardResourceOperations.ResourceCollectionAction<
    DevBoxAction,
    {
      ...DelayUntilQueryParameter;
    },
    DevBoxActionsDelayMultipleResult
  >;

  @doc("Creates an action to schedule the deletion of a Dev Box")
  @added(APIVersions.v2025_08_01_preview)
  @action("scheduleDelete")
  scheduleDeleteAction is StandardResourceOperations.ResourceAction<
    DevBox,
    {
      ...DeleteAtQueryParameter;
    },
    NoContentResponse
  >;

  @doc("Lists operations on the Dev Box which have occurred within the past 90 days.")
  @added(APIVersions.v2024_02_01)
  listOperations is StandardResourceOperations.ResourceList<DevBoxOperation>;

  @doc("Gets an operation on a Dev Box.")
  @added(APIVersions.v2024_02_01)
  getOperation is StandardResourceOperations.ResourceRead<DevBoxOperation>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No model for this."
  @doc("Gets the log for an imaging build task.")
  @route("/projects/{projectName}/imageBuildLogs/{imageBuildLogId}")
  @get
  @added(APIVersions.v2024_08_01_preview)
  getImagingTaskLog is Azure.Core.Foundations.Operation<
    {
      ...ProjectNameParameter;

      @doc("An imaging build log id.")
      @path
      imageBuildLogId: uuid;
    },
    {
      @doc("Set producer to text/plain")
      @header
      contentType: "text/plain";

      @body
      body: string;
    }
  >;

  @doc("Lists snapshots for this Dev Box.")
  @added(APIVersions.v2024_09_01_preview)
  listSnapshots is StandardResourceOperations.ResourceList<DevBoxSnapshot>;

  @doc("Gets a snapshot by snapshot id.")
  @added(APIVersions.v2024_09_01_preview)
  getSnapshot is StandardResourceOperations.ResourceRead<DevBoxSnapshot>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Replacing Status Monitor"
  @doc("Restores a Dev Box to a specified snapshot.")
  @added(APIVersions.v2024_09_01_preview)
  @pollingOperation(OperationStatuses.get)
  @action("restoreSnapshot")
  restoreSnapshot is DevCenterOps.LongRunningResourceAction<
    DevBox,
    {
      ...SnapshotIdQueryParameter;
    },
    OperationStatus
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Replacing Status Monitor"
  @doc("""
    Captures a manual snapshot of the Dev Box.
    Upon completion, a snapshotId will be generated.
    To retrieve all snapshots and their corresponding IDs, use the list snapshots endpoint.
    """)
  @added(APIVersions.v2024_10_01_preview)
  @pollingOperation(OperationStatuses.get)
  @action("captureSnapshot")
  captureSnapshot is DevCenterOps.LongRunningResourceAction<
    DevBox,
    {},
    OperationStatus
  >;

  @doc("Lists addons for this Dev Box.")
  @added(APIVersions.v2025_04_01_preview)
  listDevBoxAddons is StandardResourceOperations.ResourceList<DevBoxAddOn>;

  @doc("Gets a Dev Box addon by Dev Box addon id.")
  @added(APIVersions.v2025_04_01_preview)
  getDevBoxAddon is StandardResourceOperations.ResourceRead<DevBoxAddOn>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard operations produce wrong swagger"
  @doc("Creates a Dev Box addon.")
  @added(APIVersions.v2025_04_01_preview)
  @finalOperation(DevBoxes.getDevBoxAddon)
  @pollingOperation(OperationStatuses.get)
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}/addons/{addOnName}")
  @put
  createOrReplaceDevBoxAddOn is Azure.Core.Foundations.Operation<
    {
      ...ProjectNameParameter;
      ...UserIdParameter;
      ...DevBoxNameParameter;
      ...DevBoxAddOnNameParameter;

      @doc("Represents the body request of a Dev Box addon creation.")
      @bodyRoot
      body: DevBoxAddOn;
    },
    DevBoxAddOn | {
      @statusCode statusCode: 201;

      @header("Location")
      location: string;

      @pollingLocation
      @header("Operation-Location")
      operationLocation: string;

      @added(APIVersions.v2025_04_01_preview)
      @bodyRoot
      body?: DevBoxAddOn;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard operations produce wrong swagger"
  @doc("Deletes a Dev Box addon.")
  @added(APIVersions.v2025_04_01_preview)
  @pollingOperation(OperationStatuses.get)
  @route("/projects/{projectName}/users/{userId}/devboxes/{devBoxName}/addons/{addOnName}")
  @delete
  deleteDevBoxAddOn is Azure.Core.Foundations.Operation<
    {
      ...ProjectNameParameter;
      ...UserIdParameter;
      ...DevBoxNameParameter;
      ...DevBoxAddOnNameParameter;
    },
    {
      @statusCode statusCode: 202;

      @header("Location")
      location: string;

      @pollingLocation
      @header("Operation-Location")
      operationLocation: string;

      @bodyRoot body: OperationStatus;
    } | {
      @statusCode statusCode: 204;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard operations produce wrong swagger"
  @doc("Enable a Dev Box addon.")
  @added(APIVersions.v2025_04_01_preview)
  @pollingOperation(OperationStatuses.get)
  @action("enable")
  enableDevBoxAddOn is DevCenterOps.LongRunningResourceAction<
    DevBoxAddOn,
    {},
    OperationStatus
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Standard operations produce wrong swagger"
  @doc("Disable a Dev Box addon.")
  @added(APIVersions.v2025_04_01_preview)
  @pollingOperation(OperationStatuses.get)
  @action("disable")
  disableDevBoxAddOn is DevCenterOps.LongRunningResourceAction<
    DevBoxAddOn,
    {},
    OperationStatus
  >;
}
