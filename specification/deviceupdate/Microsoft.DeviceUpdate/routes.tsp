import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./parameters.tsp";
import "./models-compliance.tsp";
import "./models-deployment.tsp";
import "./models-device.tsp";
import "./models-deviceclass.tsp";
import "./models-diagnostics.tsp";
import "./models-group.tsp";
import "./models-limits.tsp";
import "./models-update.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.IoT.DeviceUpdate;

alias ServiceTraits = SupportsClientRequestId &
  NoConditionalRequests &
  NoRepeatableRequests;

alias ServiceOperations = Azure.Core.ResourceOperations<ServiceTraits>;

interface DeviceUpdate {
  /** Get a list of all updates that have been imported to Device Update for IoT Hub. */
  listUpdates is ServiceOperations.ResourceList<
    Update,
    QueryParametersTrait<{
      /** Request updates matching a free-text search expression. */
      @query
      search?: string;

      /** Optional to filter updates by isDeployable property. */
      @query
      filter?: string;
    }>
  >;

  /** Get a specific update version. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure Core doesn't support composite resource key."
  @route("updates/providers/{provider}/names/{name}/versions/{version}")
  @get
  getUpdate is Azure.Core.Foundations.Operation<
    {
      ...UpdateProviderParameter;
      ...UpdateNameParameter;
      ...UpdateVersionParameter;
      ...IfNoneMatchParameter;
    },
    Update
  >;

  /**
   * Import new update version. This is a long-running-operation; use
   * Operation-Location response header value to check for operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "LRO doesn't return status monitor in 202 resposne body."
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior."
  @pollingOperation(DeviceUpdate.getOperationStatus)
  @route("updates:import")
  @post
  importUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * The update to be imported (see schema https://json.schemastore.org/azure-deviceupdate-import-manifest-5.0.json for details).
       */
      @body updateToImport: ImportUpdateInput;
    },
    {
      @statusCode _: 202;

      @pollingLocation
      @header("Operation-Location")
      operationLocation?: ResourceLocation<UpdateOperation>;
    }
  >;

  /**
   * Delete a specific update version. This is a long-running-operation; use
   * Operation-Location response header value to check for operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "LRO doesn't return status monitor in 202 resposne body."
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior."
  @pollingOperation(DeviceUpdate.getOperationStatus)
  @route("updates/providers/{provider}/names/{name}/versions/{version}")
  @delete
  deleteUpdate is Azure.Core.Foundations.Operation<
    {
      ...UpdateProviderParameter;
      ...UpdateNameParameter;
      ...UpdateVersionParameter;
    },
    {
      @statusCode _: 202;

      @pollingLocation
      @header("Operation-Location")
      operationLocation?: ResourceLocation<UpdateOperation>;
    }
  >;

  /** Get a list of all update providers that have been imported to Device Update for IoT Hub. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Not a standard resource."
  @route("updates/providers")
  listProviders is Azure.Core.Foundations.Operation<
    {},
    StringsList,
    {},
    Azure.Core.Foundations.ErrorResponse
  >;

  /** Get a list of all update names that match the specified provider. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Not a standard resource."
  @route("updates/providers/{provider}/names")
  listNames is Azure.Core.Foundations.Operation<
    {
      ...UpdateProviderParameter;
    },
    StringsList,
    {},
    Azure.Core.Foundations.ErrorResponse
  >;

  /** Get a list of all update versions that match the specified provider and name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Not a standard resource."
  @route("updates/providers/{provider}/names/{name}/versions")
  @get
  listVersions is Azure.Core.Foundations.Operation<
    {
      ...UpdateProviderParameter;
      ...UpdateNameParameter;
    },
    StringsList,
    {},
    Azure.Core.Foundations.ErrorResponse
  >;

  /** Get a list of all update file identifiers for the specified version. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure Core doesn't support composite resource key."
  @route("updates/providers/{provider}/names/{name}/versions/{version}/files")
  @get
  listFiles is Azure.Core.Foundations.Operation<
    {
      ...UpdateProviderParameter;
      ...UpdateNameParameter;
      ...UpdateVersionParameter;
    },
    StringsList,
    {},
    Azure.Core.Foundations.ErrorResponse
  >;

  /** Get a specific update file from the version. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure Core doesn't support composite resource key."
  @route("updates/providers/{provider}/names/{name}/versions/{version}/files/{fileId}")
  @get
  getFile is Azure.Core.Foundations.Operation<
    {
      ...UpdateProviderParameter;
      ...UpdateNameParameter;
      ...UpdateVersionParameter;

      /** File identifier. */
      @path
      fileId: string;

      ...IfNoneMatchParameter;
    },
    UpdateFile
  >;

  /**
   * Get a list of all import update operations. Completed operations are kept for 7
   * days before auto-deleted. Delete operations are not returned by this API
   * version.
   */
  listOperationStatuses is ServiceOperations.ResourceList<
    UpdateOperation,
    QueryParametersTrait<{
      /**
       * Optional to filter operations by status property. Only one specific filter is
       * supported: \"status eq 'NotStarted' or status eq 'Running'\"
       */
      @query
      filter?: string;

      /**
       * Specifies a non-negative integer n that limits the number of items returned
       * from a collection. The service returns the number of available items up to but
       * not greater than the specified value n.
       */
      @query
      top?: int32;
    }>
  >;

  /** Retrieve operation status. */
  getOperationStatus is ServiceOperations.ResourceRead<
    UpdateOperation,
    TraitOverride<RequestHeadersTrait<
      {
        ...IfNoneMatchParameter;
      },
      TraitContext.Read
    >>
  >;
}

interface DeviceManagement {
  /**
   * Gets a list of all device classes (sets of devices compatible with the same
   * updates based on the model Id and compat properties reported in the Device
   * Update PnP interface in IoT Hub) for all devices connected to Device Update for
   * IoT Hub.
   */
  listDeviceClasses is ServiceOperations.ResourceList<
    DeviceClass,
    QueryParametersTrait<{
      /** Restricts the set of device classes returned. You can filter on friendly name. */
      @query
      filter?: string;
    }>
  >;

  /** Gets the properties of a device class. */
  getDeviceClass is ServiceOperations.ResourceRead<DeviceClass>;

  /** Update device class details. */
  updateDeviceClass is ServiceOperations.ResourceUpdate<DeviceClass>;

  /**
   * Deletes a device class. Device classes are created automatically when Device
   * Update-enabled devices are connected to the hub but are not automatically
   * cleaned up since they are referenced by DeviceClassSubgroups. If the user has
   * deleted all DeviceClassSubgroups for a device class they can also delete the
   * device class to remove the records from the system and to stop checking the
   * compatibility of this device class with new updates. If a device is ever
   * reconnected for this device class it will be re-created.
   */
  deleteDeviceClass is ServiceOperations.ResourceDelete<DeviceClass>;

  /** Gets a list of installable updates for a device class. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "UpdateInfo model is not a resource and reused in several places."
  @route("management/deviceClasses/{deviceClassId}/installableUpdates")
  @get
  listInstallableUpdatesForDeviceClass is Azure.Core.Foundations.Operation<
    {
      /** Device class identifier. */
      @path
      deviceClassId: string;
    },
    UpdateInfoList
  >;

  /** Gets a list of devices connected to Device Update for IoT Hub. */
  listDevices is ServiceOperations.ResourceList<
    Device,
    QueryParametersTrait<{
      /**
       * Restricts the set of devices returned. You can filter on GroupId,
       * DeviceClassId, or GroupId and DeploymentStatus. Use DeploymentStatus eq null to
       * query for devices with no deployment status (that have never been deployed to).
       */
      @query
      filter?: string;
    }>
  >;

  /**
   * Import existing devices from IoT Hub. This is a long-running-operation; use
   * Operation-Location response header value to check for operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "LRO doesn't return status monitor in 202 response body."
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior."
  @pollingOperation(DeviceManagement.getOperationStatus)
  @route("management/devices:import")
  @post
  importDevices is Azure.Core.Foundations.Operation<
    {
      /** The types of devices to import. */
      @body
      importType: ImportType;
    },
    {
      @statusCode _: 202;

      @pollingLocation
      @header("Operation-Location")
      operationLocation?: ResourceLocation<DeviceOperation>;
    }
  >;

  /**
   * Gets the device properties and latest deployment status for a device connected
   * to Device Update for IoT Hub.
   */
  getDevice is ServiceOperations.ResourceRead<Device>;

  /**
   * Gets the device module properties and latest deployment status for a device
   * module connected to Device Update for IoT Hub.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Get Module API returns model identical to Device and TS complains about duplicate key."
  @route("management/devices/{deviceId}/modules/{moduleId}")
  @get
  getDeviceModule is Azure.Core.Foundations.Operation<
    {
      /** Device identifier in Azure IoT Hub. */
      @path
      deviceId: string;

      /** Device module identifier in Azure IoT Hub. */
      @path
      moduleId: string;
    },
    Device
  >;

  /**
   * Gets the breakdown of how many devices are on their latest update, have new
   * updates available, or are in progress receiving new updates.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Route segment is both resource type and instance."
  @route("management/updateCompliance")
  @get
  getUpdateCompliance is Azure.Core.Foundations.Operation<{}, UpdateCompliance>;

  /** Gets a list of all device groups.  The $default group will always be returned first. */
  listGroups is ServiceOperations.ResourceList<
    Group,
    ListQueryParametersTrait<{
      /**
       * Orders the set of groups returned. You can order by groupId, deviceCount,
       * createdDate, subgroupsWithNewUpdatesAvailableCount,
       * subgroupsWithUpdatesInProgressCount, or subgroupsOnLatestUpdateCount.
       */
      @query
      orderby?: string;
    }>
  >;

  /** Gets the device group properties. */
  getGroup is ServiceOperations.ResourceRead<Group>;

  /**
   * Deletes a device group. This group is automatically created when a Device
   * Update-enabled device is connected to the hub and reports its properties.
   * Groups, subgroups, and deployments are not automatically cleaned up but are
   * retained for history purposes. Users can call this method to delete a group if
   * they do not need to retain any of the history of the group and no longer need
   * it. If a device is ever connected again for this group after the group was
   * deleted it will be automatically re-created but there will be no history.
   */
  deleteGroup is ServiceOperations.ResourceDelete<Group>;

  /**
   * Get device group update compliance information such as how many devices are on
   * their latest update, how many need new updates, and how many are in progress on
   * receiving a new update.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Route segment is both resource type and instance."
  @route("management/groups/{groupId}/updateCompliance")
  @get
  getUpdateComplianceForGroup is Azure.Core.Foundations.Operation<
    Azure.Core.Foundations.ItemKeysOf<Group>,
    UpdateCompliance
  >;

  /**
   * Get the best available updates for a device group and a count of how many
   * devices need each update.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Route segment is both resource type and instance."
  @route("management/groups/{groupId}/bestUpdates")
  @get
  listBestUpdatesForGroup is Azure.Core.Foundations.Operation<
    Azure.Core.Foundations.ItemKeysOf<Group>,
    DeviceClassSubgroupUpdatableDevicesList
  >;

  /** Gets a list of deployments for a device group. */
  listDeploymentsForGroup is ServiceOperations.ResourceList<
    Deployment,
    ListQueryParametersTrait<{
      /** Orders the set of deployments returned. You can order by start date. */
      @query
      orderby?: string;
    }>
  >;

  /** Gets the deployment properties. */
  getDeployment is ServiceOperations.ResourceRead<Deployment>;

  /** Creates or updates a deployment. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Operation is neither ResourceCreateOrReplace nor ResourceCreateOrUpdate."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Legacy name."
  @createsResource(Deployment)
  @route("management/groups/{groupId}/deployments/{deploymentId}")
  @put
  createOrUpdateDeployment is Azure.Core.Foundations.Operation<
    {
      ...Azure.Core.Foundations.ItemKeysOf<Group>;

      /** Deployment identifier. */
      @path
      deploymentId: string;

      /** Deployment details. */
      @body
      resource: Deployment;
    },
    {
      @statusCode _: 201 | 200;
      @body body: Deployment;
    }
  >;

  /** Deletes a deployment. */
  deleteDeployment is ServiceOperations.ResourceDelete<Deployment>;

  /**
   * Gets the status of a deployment including a breakdown of how many devices in
   * the deployment are in progress, completed, or failed.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Route segment is both resource type and instance."
  @route("management/groups/{groupId}/deployments/{deploymentId}/status")
  @get
  getDeploymentStatus is Azure.Core.Foundations.Operation<
    {
      ...Azure.Core.Foundations.ItemKeysOf<Group>;

      /** Deployment identifier. */
      @path
      deploymentId: string;
    },
    DeploymentStatus
  >;

  /**
   * Get the device class subgroups for the group. A device class subgroup is the
   * set of devices within the group that share the same device class. All devices
   * within the same device class are compatible with the same updates.
   */
  listDeviceClassSubgroupsForGroup is ServiceOperations.ResourceList<
    DeviceClassSubgroup,
    ListQueryParametersTrait<{
      /**
       * Restricts the set of device class subgroups returned. You can filter on compat
       * properties by name and value. (i.e. filter=compatProperties/propertyName1 eq 'value1'
       * and compatProperties/propertyName2 eq 'value2')
       */
      @query
      filter?: string;
    }>
  >;

  /**
   * Gets device class subgroup details. A device class subgroup is the set of
   * devices within the group that share the same device class. All devices within
   * the same device class are compatible with the same updates.
   */
  getDeviceClassSubgroup is ServiceOperations.ResourceRead<DeviceClassSubgroup>;

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
  deleteDeviceClassSubgroup is ServiceOperations.ResourceDelete<DeviceClassSubgroup>;

  /**
   * Get device class subgroup update compliance information such as how many
   * devices are on their latest update, how many need new updates, and how many are
   * in progress on receiving a new update.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Route segment is both resource type and instance."
  @route("management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/updateCompliance")
  @get
  getDeviceClassSubgroupUpdateCompliance is Azure.Core.Foundations.Operation<
    Azure.Core.Foundations.ItemKeysOf<DeviceClassSubgroup>,
    UpdateCompliance
  >;

  /**
   * Get the best available update for a device class subgroup and a count of how
   * many devices need this update.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Route segment is both resource type and instance."
  @route("management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/bestUpdates")
  @get
  getBestUpdatesForDeviceClassSubgroup is Azure.Core.Foundations.Operation<
    Azure.Core.Foundations.ItemKeysOf<DeviceClassSubgroup>,
    DeviceClassSubgroupUpdatableDevices
  >;

  /** Gets a list of deployments for a device class subgroup. */
  listDeploymentsForDeviceClassSubgroup is ServiceOperations.ResourceList<
    DeviceClassSubgroupDeployment,
    ListQueryParametersTrait<{
      /** Orders the set of deployments returned. You can order by start date. */
      @query
      orderby?: string;
    }>
  >;

  /** Gets the deployment properties. */
  getDeploymentForDeviceClassSubgroup is ServiceOperations.ResourceRead<DeviceClassSubgroupDeployment>;

  /** Deletes a device class subgroup deployment. */
  deleteDeploymentForDeviceClassSubgroup is ServiceOperations.ResourceDelete<DeviceClassSubgroupDeployment>;

  /** Stops a deployment. */
  @action("cancel")
  stopDeployment is ServiceOperations.ResourceAction<
    DeviceClassSubgroupDeployment,
    {},
    DeviceClassSubgroupDeployment
  >;

  /** Retries a deployment with failed devices. */
  @action("retry")
  retryDeployment is ServiceOperations.ResourceAction<
    DeviceClassSubgroupDeployment,
    {},
    DeviceClassSubgroupDeployment
  >;

  /**
   * Gets the status of a deployment including a breakdown of how many devices in
   * the deployment are in progress, completed, or failed.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Route segment is both resource type and instance."
  @route("management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments/{deploymentId}/status")
  @get
  getDeviceClassSubgroupDeploymentStatus is Azure.Core.Foundations.Operation<
    {
      ...Azure.Core.Foundations.ItemKeysOf<DeviceClassSubgroupDeployment>;
    },
    DeviceClassSubgroupDeploymentStatus
  >;

  /**
   * Gets a list of devices in a deployment along with their state. Useful for
   * getting a list of failed devices.
   */
  listDeviceStatesForDeviceClassSubgroupDeployment is ServiceOperations.ResourceList<
    DeploymentDeviceState,
    ListQueryParametersTrait<{
      /**
       * Restricts the set of deployment device states returned. You can filter on
       * deviceId and moduleId and/or deviceState.
       */
      @query
      filter?: string;
    }>
  >;

  /** Retrieve operation status. */
  getOperationStatus is ServiceOperations.ResourceRead<DeviceOperation>;

  /**
   * Get a list of all device import operations. Completed operations are kept for 7 days before auto-deleted.
   */
  listOperationStatuses is ServiceOperations.ResourceList<
    DeviceOperation,
    ListQueryParametersTrait<{
      /**
       * Restricts the set of operations returned. Only one specific filter is supported: \"status eq 'NotStarted' or status eq 'Running'\"
       */
      @query
      filter?: string;

      /**
       * Specifies a non-negative integer n that limits the number of items returned
       * from a collection. The service returns the number of available items up to but
       * not greater than the specified value n.
       */
      @query
      top?: int32;
    }>
  >;

  /** Get all device diagnostics log collections */
  listLogCollections is ServiceOperations.ResourceList<LogCollection>;

  /** Get the device diagnostics log collection */
  getLogCollection is ServiceOperations.ResourceRead<LogCollection>;

  /** Start the device diagnostics log collection on specified devices. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Operation is neither ResourceCreateOrReplace nor ResourceCreateOrUpdate."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Legacy name."
  @createsResource(LogCollection)
  @route("management/deviceDiagnostics/logCollections/{operationId}")
  @put
  startLogCollection is Azure.Core.Foundations.Operation<
    {
      ...Azure.Core.Foundations.ItemKeysOf<LogCollection>;

      /** Log collection details. */
      @body
      resource: LogCollection;
    },
    {
      @statusCode _: 201;
      @body body: LogCollection;
    }
  >;

  /** Get log collection with detailed status */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Route segment is both resource type and instance."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Legacy name."
  @route("management/deviceDiagnostics/logCollections/{operationId}/detailedStatus")
  @get
  getLogCollectionDetailedStatus is Azure.Core.Foundations.Operation<
    {
      ...Azure.Core.Foundations.ItemKeysOf<LogCollection>;
    },
    Azure.Core.Page<LogCollectionOperationDetailedStatus>
  >;

  /** Get list of device health */
  listHealthOfDevices is ServiceOperations.ResourceList<
    DeviceHealth,
    ListQueryParametersTrait<{
      /**
       * Restricts the set of devices for which device health is returned. You can
       * filter on status, device id and module id.
       */
      @query
      filter?: string;
    }>
  >;
}

interface InstanceManagement {
  /**
   * Gets the instance limits for active deployments, devices, device classes, and
   * groups.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Route segment is both resource type and instance."
  @route("limits")
  @get
  getLimits is Azure.Core.Foundations.Operation<{}, Limits>;
}
