import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;

namespace DeviceUpdateClient;

// ---------------------------------------------------------------------------
// Shared parameter models. These are spread (...) into operations so the
// autorest emitter promotes them to global #/parameters/* entries, matching
// the original hand-authored swagger.
// ---------------------------------------------------------------------------

/** Account instance id parameter. */
model InstanceIdParameter {
  /**
   * The Device Update for IoT Hub account instance identifier.
   */
  @path
  @extension("x-ms-skip-url-encoding", true)
  @extension("x-ms-parameter-grouping", #{ name: "account-options" })
  @extension("x-ms-parameter-location", "client")
  instanceId: string;
}

/** Update provider parameter. */
model UpdateProviderParameter {
  /**
   * Update provider.
   */
  @path
  provider: string;
}

/** Update name parameter. */
model UpdateNameParameter {
  /**
   * Update name.
   */
  @path
  name: string;
}

/** Update version parameter. */
model UpdateVersionParameter {
  /**
   * Update version.
   */
  @path
  version: string;
}

/** Update file id parameter. */
model FileIdParameter {
  /**
   * File identifier.
   */
  @path
  fileId: string;
}

/** If-None-Match access condition parameter. */
model IfNoneMatchParameter {
  /**
   * Defines the If-None-Match condition. The operation will be performed only if
   * the ETag on the server does not match this value.
   */
  @header("If-None-Match")
  @extension("x-ms-parameter-grouping", #{ name: "access-condition" })
  ifNoneMatch?: string;
}

/** Operation id parameter. */
model OperationIdParameter {
  /**
   * Operation identifier.
   */
  @maxLength(256)
  @minLength(1)
  @path
  operationId: string;
}

/** Log collection id parameter. */
model LogCollectionIdParameter {
  /**
   * Log collection identifier.
   */
  @maxLength(256)
  @minLength(1)
  @clientName("logCollectionId")
  @path("operationId")
  operationId: string;
}

/** Device id parameter. */
model DeviceIdParameter {
  /**
   * Device identifier in Azure IoT Hub.
   */
  @path
  deviceId: string;
}

/** Device module id parameter. */
model ModuleIdParameter {
  /**
   * Device module identifier in Azure IoT Hub.
   */
  @path
  moduleId: string;
}

/** Device class id parameter. */
model DeviceClassIdParameter {
  /**
   * Device class identifier.
   */
  @path
  deviceClassId: string;
}

/** Group id parameter. */
model GroupIdParameter {
  /**
   * Group identifier.
   */
  @path
  groupId: string;
}

/** Deployment id parameter. */
model DeploymentIdParameter {
  /**
   * Deployment identifier.
   */
  @path
  deploymentId: string;
}

// === END SHARED PARAMETER MODELS ===

/** Standard operation with custom error response. */
alias ServiceOperation<
  Params extends TypeSpec.Reflection.Model,
  Response
> = Foundations.Operation<Params, Response, {}, ErrorResponse>;

@tag("Update management")
interface DeviceUpdateOperationGroup {
  /**
   * Get a list of all updates that have been imported to Device Update for IoT Hub.
   */
  @operationId("DeviceUpdate_ListUpdates")
  @route("/deviceUpdate/{instanceId}/updates")
  @get
  @list
  @extension("x-ms-odata", "#/definitions/UpdateFilter")
  listUpdates is ServiceOperation<
    {
      ...InstanceIdParameter;

      /**
       * Request updates matching a free-text search expression.
       */
      @query("search")
      search?: string;

      /**
       * Optional to filter updates by isDeployable property.
       */
      @query("filter")
      filter?: string;
    },
    UpdateList
  >;

  /**
   * Import new update version. This is a long-running-operation; use
   * Operation-Location response header value to check for operation status.
   */
  @operationId("DeviceUpdate_ImportUpdate")
  @route("/deviceUpdate/{instanceId}/updates:import")
  @post
  @pollingOperation(DeviceUpdateOperationGroup.getOperationStatus)
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "operation-location" }
  )
  importUpdate is ServiceOperation<
    {
      ...InstanceIdParameter;

      /**
       * The update to be imported (see schema
       * https://json.schemastore.org/azure-deviceupdate-import-manifest-5.0.json for
       * details).
       */
      @bodyRoot
      updateToImport: ImportUpdateInput;
    },

      | Update
      | {
          @statusCode _: 202;
          ...Foundations.LongRunningStatusLocation;
        }
  >;

  /**
   * Get a specific update version.
   */
  @operationId("DeviceUpdate_GetUpdate")
  @route("/deviceUpdate/{instanceId}/updates/providers/{provider}/names/{name}/versions/{version}")
  @get
  getUpdate is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...UpdateProviderParameter;
      ...UpdateNameParameter;
      ...UpdateVersionParameter;
      ...IfNoneMatchParameter;
    },
    Update
  >;

  /**
   * Delete a specific update version. This is a long-running-operation; use
   * Operation-Location response header value to check for operation status.
   */
  @operationId("DeviceUpdate_DeleteUpdate")
  @route("/deviceUpdate/{instanceId}/updates/providers/{provider}/names/{name}/versions/{version}")
  @delete
  @pollingOperation(DeviceUpdateOperationGroup.getOperationStatus)
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "operation-location" }
  )
  deleteUpdate is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...UpdateProviderParameter;
      ...UpdateNameParameter;
      ...UpdateVersionParameter;
    },
    {
      @statusCode _: 202;
      ...Foundations.LongRunningStatusLocation;
    }
  >;

  /**
   * Get a list of all update providers that have been imported to Device Update for
   * IoT Hub.
   */
  @operationId("DeviceUpdate_ListProviders")
  @route("/deviceUpdate/{instanceId}/updates/providers")
  @get
  @list
  listProviders is ServiceOperation<
    {
      ...InstanceIdParameter;
    },
    StringsList
  >;

  /**
   * Get a list of all update names that match the specified provider.
   */
  @operationId("DeviceUpdate_ListNames")
  @route("/deviceUpdate/{instanceId}/updates/providers/{provider}/names")
  @get
  @list
  listNames is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...UpdateProviderParameter;
    },
    StringsList
  >;

  /**
   * Get a list of all update versions that match the specified provider and name.
   */
  @operationId("DeviceUpdate_ListVersions")
  @route("/deviceUpdate/{instanceId}/updates/providers/{provider}/names/{name}/versions")
  @get
  @list
  @extension("x-ms-odata", "#/definitions/UpdateFilter")
  listVersions is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...UpdateProviderParameter;
      ...UpdateNameParameter;

      /**
       * Optional to filter updates by isDeployable property.
       */
      @query("filter")
      filter?: string;
    },
    StringsList
  >;

  /**
   * Get a list of all update file identifiers for the specified version.
   */
  @operationId("DeviceUpdate_ListFiles")
  @route("/deviceUpdate/{instanceId}/updates/providers/{provider}/names/{name}/versions/{version}/files")
  @get
  @list
  listFiles is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...UpdateProviderParameter;
      ...UpdateNameParameter;
      ...UpdateVersionParameter;
    },
    StringsList
  >;

  /**
   * Get a specific update file from the version.
   */
  @operationId("DeviceUpdate_GetFile")
  @route("/deviceUpdate/{instanceId}/updates/providers/{provider}/names/{name}/versions/{version}/files/{fileId}")
  @get
  getFile is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...UpdateProviderParameter;
      ...UpdateNameParameter;
      ...UpdateVersionParameter;
      ...FileIdParameter;
      ...IfNoneMatchParameter;
    },
    UpdateFile
  >;

  /**
   * Get a list of all import update operations. Completed operations are kept for 7
   * days before auto-deleted. Delete operations are not returned by this API
   * version.
   */
  @operationId("DeviceUpdate_ListOperationStatuses")
  @route("/deviceUpdate/{instanceId}/updates/operations")
  @get
  @list
  @extension("x-ms-odata", "#/definitions/OperationFilter")
  listOperationStatuses is ServiceOperation<
    {
      ...InstanceIdParameter;

      /**
       * Optional to filter operations by status property. Only one specific filter is
       * supported: "status eq 'NotStarted' or status eq 'Running'"
       */
      @query("filter")
      filter?: string;

      /**
       * Specifies a non-negative integer n that limits the number of items returned
       * from a collection. The service returns the number of available items up to but
       * not greater than the specified value n.
       */
      @query("top")
      top?: int32;
    },
    UpdateOperationsList
  >;

  /**
   * Retrieve operation status.
   */
  @operationId("DeviceUpdate_GetOperationStatus")
  @route("/deviceUpdate/{instanceId}/updates/operations/{operationId}")
  @get
  getOperationStatus is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...OperationIdParameter;
      ...IfNoneMatchParameter;
    },
    {
      /**
       * Number of seconds to wait before checking the operation status again.
       */
      @header("Retry-After")
      retryAfter?: string;

      ...UpdateOperation;
    }
  >;
}

@tag("Device and deployment management")
interface DeviceManagementOperationGroup {
  /**
   * Gets a list of all device classes (sets of devices compatible with the same
   * updates based on the model Id and compat properties reported in the Device
   * Update PnP interface in IoT Hub) for all devices connected to Device Update for
   * IoT Hub.
   */
  @operationId("DeviceManagement_ListDeviceClasses")
  @route("/deviceUpdate/{instanceId}/management/deviceClasses")
  @get
  @list
  @extension("x-ms-odata", "#/definitions/DeviceClassFilter")
  listDeviceClasses is ServiceOperation<
    {
      ...InstanceIdParameter;

      /**
       * Restricts the set of device classes returned. You can filter on friendly name.
       */
      @query("filter")
      filter?: string;
    },
    DeviceClassesList
  >;

  /**
   * Gets the properties of a device class.
   */
  @operationId("DeviceManagement_GetDeviceClass")
  @route("/deviceUpdate/{instanceId}/management/deviceClasses/{deviceClassId}")
  @get
  getDeviceClass is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...DeviceClassIdParameter;
    },
    DeviceClass
  >;

  /**
   * Update device class details.
   */
  @operationId("DeviceManagement_UpdateDeviceClass")
  @route("/deviceUpdate/{instanceId}/management/deviceClasses/{deviceClassId}")
  @patch
  updateDeviceClass is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...DeviceClassIdParameter;

      /**
       * The device class json merge patch body. Currently only supports patching
       * friendlyName.
       */
      @header("Content-Type")
      contentType: "application/merge-patch+json";

      /**
       * The device class json merge patch body. Currently only supports patching
       * friendlyName.
       */
      @bodyRoot
      deviceClassPatch: PatchBody;
    },
    DeviceClass
  >;

  /**
   * Deletes a device class. Device classes are created automatically when Device
   * Update-enabled devices are connected to the hub but are not automatically
   * cleaned up since they are referenced by DeviceClassSubgroups. If the user has
   * deleted all DeviceClassSubgroups for a device class they can also delete the
   * device class to remove the records from the system and to stop checking the
   * compatibility of this device class with new updates. If a device is ever
   * reconnected for this device class it will be re-created.
   */
  @operationId("DeviceManagement_DeleteDeviceClass")
  @route("/deviceUpdate/{instanceId}/management/deviceClasses/{deviceClassId}")
  @delete
  deleteDeviceClass is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...DeviceClassIdParameter;
    },
    void
  >;

  /**
   * Gets a list of installable updates for a device class.
   */
  @operationId("DeviceManagement_ListInstallableUpdatesForDeviceClass")
  @route("/deviceUpdate/{instanceId}/management/deviceClasses/{deviceClassId}/installableUpdates")
  @get
  @list
  listInstallableUpdatesForDeviceClass is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...DeviceClassIdParameter;
    },
    UpdateInfoList
  >;

  /**
   * Gets a list of devices connected to Device Update for IoT Hub.
   */
  @operationId("DeviceManagement_ListDevices")
  @route("/deviceUpdate/{instanceId}/management/devices")
  @get
  @list
  @extension("x-ms-odata", "#/definitions/DeviceFilter")
  listDevices is ServiceOperation<
    {
      ...InstanceIdParameter;

      /**
       * Restricts the set of devices returned. You can filter on GroupId,
       * DeviceClassId, or GroupId and DeploymentStatus. Use DeploymentStatus eq null to
       * query for devices with no deployment status (that have never been deployed to).
       */
      @query("filter")
      filter?: string;
    },
    DevicesList
  >;

  /**
   * Import existing devices from IoT Hub. This is a long-running-operation; use
   * Operation-Location response header value to check for operation status.
   */
  @operationId("DeviceManagement_ImportDevices")
  @route("/deviceUpdate/{instanceId}/management/devices:import")
  @post
  @pollingOperation(DeviceManagementOperationGroup.getOperationStatus)
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "operation-location" }
  )
  importDevices is ServiceOperation<
    {
      ...InstanceIdParameter;

      /**
       * The types of devices to import.
       */
      @header("Content-Type")
      contentType: "application/json";

      /**
       * The types of devices to import.
       */
      @bodyRoot
      importType: ImportType;
    },
    {
      @statusCode _: 202;
      ...Foundations.LongRunningStatusLocation;
    }
  >;

  /**
   * Gets the device properties and latest deployment status for a device connected
   * to Device Update for IoT Hub.
   */
  @operationId("DeviceManagement_GetDevice")
  @route("/deviceUpdate/{instanceId}/management/devices/{deviceId}")
  @get
  getDevice is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...DeviceIdParameter;
    },
    Device
  >;

  /**
   * Gets the device module properties and latest deployment status for a device
   * module connected to Device Update for IoT Hub.
   */
  @operationId("DeviceManagement_GetDeviceModule")
  @route("/deviceUpdate/{instanceId}/management/devices/{deviceId}/modules/{moduleId}")
  @get
  getDeviceModule is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...DeviceIdParameter;
      ...ModuleIdParameter;
    },
    Device
  >;

  /**
   * Gets the breakdown of how many devices are on their latest update, have new
   * updates available, or are in progress receiving new updates.
   */
  @operationId("DeviceManagement_GetUpdateCompliance")
  @route("/deviceUpdate/{instanceId}/management/updateCompliance")
  @get
  getUpdateCompliance is ServiceOperation<
    {
      ...InstanceIdParameter;
    },
    UpdateCompliance
  >;

  /**
   * Gets a list of all device groups.  The $default group will always be returned
   * first.
   */
  @operationId("DeviceManagement_ListGroups")
  @route("/deviceUpdate/{instanceId}/management/groups")
  @get
  @list
  @extension("x-ms-odata", "#/definitions/GroupOrderBy")
  listGroups is ServiceOperation<
    {
      ...InstanceIdParameter;

      /**
       * Orders the set of groups returned. You can order by groupId, deviceCount,
       * createdDate, subgroupsWithNewUpdatesAvailableCount,
       * subgroupsWithUpdatesInProgressCount, or subgroupsOnLatestUpdateCount.
       */
      @query("orderby")
      orderBy?: string;
    },
    GroupsList
  >;

  /**
   * Gets the device group properties.
   */
  @operationId("DeviceManagement_GetGroup")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}")
  @get
  getGroup is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
    },
    Group
  >;

  /**
   * Deletes a device group. This group is automatically created when a Device
   * Update-enabled device is connected to the hub and reports its properties.
   * Groups, subgroups, and deployments are not automatically cleaned up but are
   * retained for history purposes. Users can call this method to delete a group if
   * they do not need to retain any of the history of the group and no longer need
   * it. If a device is ever connected again for this group after the group was
   * deleted it will be automatically re-created but there will be no history.
   */
  @operationId("DeviceManagement_DeleteGroup")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}")
  @delete
  deleteGroup is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
    },
    void
  >;

  /**
   * Get device group update compliance information such as how many devices are on
   * their latest update, how many need new updates, and how many are in progress on
   * receiving a new update.
   */
  @operationId("DeviceManagement_GetUpdateComplianceForGroup")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/updateCompliance")
  @get
  getUpdateComplianceForGroup is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
    },
    UpdateCompliance
  >;

  /**
   * Get the best available updates for a device group and a count of how many
   * devices need each update.
   */
  @operationId("DeviceManagement_ListBestUpdatesForGroup")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/bestUpdates")
  @get
  @list
  listBestUpdatesForGroup is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
    },
    DeviceClassSubgroupUpdatableDevicesList
  >;

  /**
   * Gets a list of deployments for a device group.
   */
  @operationId("DeviceManagement_ListDeploymentsForGroup")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deployments")
  @get
  @list
  @extension("x-ms-odata", "#/definitions/DeploymentOrderBy")
  listDeploymentsForGroup is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;

      /**
       * Orders the set of deployments returned. You can order by start date.
       */
      @query("orderby")
      orderBy?: string;
    },
    DeploymentsList
  >;

  /**
   * Gets the deployment properties.
   */
  @operationId("DeviceManagement_GetDeployment")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deployments/{deploymentId}")
  @get
  getDeployment is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
      ...DeploymentIdParameter;
    },
    Deployment
  >;

  /**
   * Creates or updates a deployment.
   */
  @operationId("DeviceManagement_CreateOrUpdateDeployment")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deployments/{deploymentId}")
  @put
  createOrUpdateDeployment is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
      ...DeploymentIdParameter;

      /**
       * The deployment properties.
       */
      @bodyRoot
      deployment: Deployment;
    },
    Deployment
  >;

  /**
   * Gets the status of a deployment including a breakdown of how many devices in
   * the deployment are in progress, completed, or failed.
   */
  @operationId("DeviceManagement_GetDeploymentStatus")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deployments/{deploymentId}/status")
  @get
  getDeploymentStatus is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
      ...DeploymentIdParameter;
    },
    DeploymentStatus
  >;

  /**
   * Get the device class subgroups for the group. A device class subgroup is the
   * set of devices within the group that share the same device class. All devices
   * within the same device class are compatible with the same updates.
   */
  @operationId("DeviceManagement_ListDeviceClassSubgroupsForGroup")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups")
  @get
  @list
  @extension("x-ms-odata", "#/definitions/DeviceClassSubgroupFilter")
  listDeviceClassSubgroupsForGroup is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;

      /**
       * Restricts the set of device class subgroups returned. You can filter on compat
       * properties by name and value. (i.e. filter=compatProperties/propertyName1 eq
       * 'value1' and compatProperties/propertyName2 eq 'value2')
       */
      @query("filter")
      filter?: string;
    },
    DeviceClassSubgroupsList
  >;

  /**
   * Gets device class subgroup details. A device class subgroup is the set of
   * devices within the group that share the same device class. All devices within
   * the same device class are compatible with the same updates.
   */
  @operationId("DeviceManagement_GetDeviceClassSubgroup")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}")
  @get
  getDeviceClassSubgroup is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
      ...DeviceClassIdParameter;
    },
    DeviceClassSubgroup
  >;

  /**
   * Deletes a device class subgroup. This subgroup is automatically created when a
   * Device Update-enabled device is connected to the hub and reports its
   * properties. Groups, subgroups, and deployments are not automatically cleaned up
   * but are retained for history purposes. Users can call this method to delete a
   * subgroup if they do not need to retain any of the history of the subgroup and
   * no longer need it. If a device is ever connected again for this subgroup after
   * the subgroup was deleted it will be automatically re-created but there will be
   * no history.
   */
  @operationId("DeviceManagement_DeleteDeviceClassSubgroup")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}")
  @delete
  deleteDeviceClassSubgroup is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
      ...DeviceClassIdParameter;
    },
    void
  >;

  /**
   * Get device class subgroup update compliance information such as how many
   * devices are on their latest update, how many need new updates, and how many are
   * in progress on receiving a new update.
   */
  @operationId("DeviceManagement_GetDeviceClassSubgroupUpdateCompliance")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/updateCompliance")
  @get
  getDeviceClassSubgroupUpdateCompliance is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
      ...DeviceClassIdParameter;
    },
    UpdateCompliance
  >;

  /**
   * Get the best available update for a device class subgroup and a count of how
   * many devices need this update.
   */
  @operationId("DeviceManagement_GetBestUpdatesForDeviceClassSubgroup")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/bestUpdates")
  @get
  getBestUpdatesForDeviceClassSubgroup is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
      ...DeviceClassIdParameter;
    },
    DeviceClassSubgroupUpdatableDevices
  >;

  /**
   * Gets a list of deployments for a device class subgroup.
   */
  @operationId("DeviceManagement_ListDeploymentsForDeviceClassSubgroup")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments")
  @get
  @list
  @extension("x-ms-odata", "#/definitions/DeploymentOrderBy")
  listDeploymentsForDeviceClassSubgroup is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
      ...DeviceClassIdParameter;

      /**
       * Orders the set of deployments returned. You can order by start date.
       */
      @query("orderby")
      orderBy?: string;
    },
    DeploymentsList
  >;

  /**
   * Gets the deployment properties.
   */
  @operationId("DeviceManagement_GetDeploymentForDeviceClassSubgroup")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments/{deploymentId}")
  @get
  getDeploymentForDeviceClassSubgroup is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
      ...DeviceClassIdParameter;
      ...DeploymentIdParameter;
    },
    Deployment
  >;

  /**
   * Stops a deployment.
   */
  @operationId("DeviceManagement_StopDeployment")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments/{deploymentId}:cancel")
  @post
  stopDeployment is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
      ...DeviceClassIdParameter;
      ...DeploymentIdParameter;
    },
    Deployment
  >;

  /**
   * Retries a deployment with failed devices.
   */
  @operationId("DeviceManagement_RetryDeployment")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments/{deploymentId}:retry")
  @post
  retryDeployment is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
      ...DeviceClassIdParameter;
      ...DeploymentIdParameter;
    },
    Deployment
  >;

  /**
   * Gets the status of a deployment including a breakdown of how many devices in
   * the deployment are in progress, completed, or failed.
   */
  @operationId("DeviceManagement_GetDeviceClassSubgroupDeploymentStatus")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments/{deploymentId}/status")
  @get
  getDeviceClassSubgroupDeploymentStatus is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
      ...DeviceClassIdParameter;
      ...DeploymentIdParameter;
    },
    DeviceClassSubgroupDeploymentStatus
  >;

  /**
   * Gets a list of devices in a deployment along with their state. Useful for
   * getting a list of failed devices.
   */
  @operationId("DeviceManagement_ListDeviceStatesForDeviceClassSubgroupDeployment")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments/{deploymentId}/devicestates")
  @get
  @list
  @extension("x-ms-odata", "#/definitions/DeploymentDeviceStatesFilter")
  listDeviceStatesForDeviceClassSubgroupDeployment is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
      ...DeviceClassIdParameter;
      ...DeploymentIdParameter;

      /**
       * Restricts the set of deployment device states returned. You can filter on
       * deviceId and moduleId and/or deviceState.
       */
      @query("filter")
      filter?: string;
    },
    DeploymentDeviceStatesList
  >;

  /**
   * Retrieve operation status.
   */
  @operationId("DeviceManagement_GetOperationStatus")
  @route("/deviceUpdate/{instanceId}/management/operations/{operationId}")
  @get
  getOperationStatus is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...OperationIdParameter;
      ...IfNoneMatchParameter;
    },
    {
      /**
       * Number of seconds to wait before checking the operation status again.
       */
      @header("Retry-After")
      retryAfter?: string;

      ...DeviceOperation;
    }
  >;

  /**
   * Get a list of all device import operations. Completed operations are kept for 7
   * days before auto-deleted.
   */
  @operationId("DeviceManagement_ListOperationStatuses")
  @route("/deviceUpdate/{instanceId}/management/operations")
  @get
  @list
  @extension("x-ms-odata", "#/definitions/OperationFilter")
  listOperationStatuses is ServiceOperation<
    {
      ...InstanceIdParameter;

      /**
       * Restricts the set of operations returned. Only one specific filter is
       * supported: "status eq 'NotStarted' or status eq 'Running'"
       */
      @query("filter")
      filter?: string;

      /**
       * Specifies a non-negative integer n that limits the number of items returned
       * from a collection. The service returns the number of available items up to but
       * not greater than the specified value n.
       */
      @query("top")
      top?: int32;
    },
    DeviceOperationsList
  >;

  /**
   * Start the device diagnostics log collection on specified devices.
   */
  @operationId("DeviceManagement_StartLogCollection")
  @route("/deviceUpdate/{instanceId}/management/deviceDiagnostics/logCollections/{operationId}")
  @put
  startLogCollection is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...LogCollectionIdParameter;

      /**
       * The log collection properties.
       */
      @bodyRoot
      logCollection: LogCollection;
    },
    {
      @statusCode _: 201;
      @bodyRoot result: LogCollection;
    }
  >;

  /**
   * Get the device diagnostics log collection
   */
  @operationId("DeviceManagement_GetLogCollection")
  @route("/deviceUpdate/{instanceId}/management/deviceDiagnostics/logCollections/{operationId}")
  @get
  getLogCollection is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...LogCollectionIdParameter;
    },
    LogCollection
  >;

  /**
   * Get all device diagnostics log collections
   */
  @operationId("DeviceManagement_ListLogCollections")
  @route("/deviceUpdate/{instanceId}/management/deviceDiagnostics/logCollections")
  @get
  @list
  listLogCollections is ServiceOperation<
    {
      ...InstanceIdParameter;
    },
    LogCollectionList
  >;

  /**
   * Get log collection with detailed status
   */
  @operationId("DeviceManagement_GetLogCollectionDetailedStatus")
  @route("/deviceUpdate/{instanceId}/management/deviceDiagnostics/logCollections/{operationId}/detailedStatus")
  @get
  getLogCollectionDetailedStatus is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...LogCollectionIdParameter;
    },
    LogCollectionOperationDetailedStatus
  >;

  /**
   * Get list of device health
   */
  @operationId("DeviceManagement_ListHealthOfDevices")
  @route("/deviceUpdate/{instanceId}/management/deviceDiagnostics/deviceHealth")
  @get
  @list
  @extension("x-ms-odata", "#/definitions/DeviceHealthFilter")
  listHealthOfDevices is ServiceOperation<
    {
      ...InstanceIdParameter;

      /**
       * Restricts the set of devices for which device health is returned. You can
       * filter on status, device id and module id.
       */
      @query("filter")
      filter: string;
    },
    DeviceHealthList
  >;
}

@tag("Deployment management")
interface DeploymentManagementOperationGroup {
  /**
   * Deletes a deployment.
   */
  @operationId("DeviceManagement_DeleteDeployment")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deployments/{deploymentId}")
  @delete
  deleteDeployment is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
      ...DeploymentIdParameter;
    },
    void
  >;

  /**
   * Deletes a device class subgroup deployment.
   */
  @operationId("DeviceManagement_DeleteDeploymentForDeviceClassSubgroup")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments/{deploymentId}")
  @delete
  deleteDeploymentForDeviceClassSubgroup is ServiceOperation<
    {
      ...InstanceIdParameter;
      ...GroupIdParameter;
      ...DeviceClassIdParameter;
      ...DeploymentIdParameter;
    },
    void
  >;
}
