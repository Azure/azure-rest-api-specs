import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;

namespace Microsoft.DeviceUpdate;

// TODO Verify trait supported
alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;
alias ServiceOperations = Azure.Core.ResourceOperations<ServiceTraits>;

interface DeviceUpdateOperations {
  /** Get a list of all updates that have been imported to Device Update for IoT Hub. */
  @get
  listUpdates is ServiceOperations.ResourceList<
    Update,
    ListQueryParametersTrait<{
      /** Request updates matching a free-text search expression. */
      @query
      search: string;

      /** Optional to filter updates by isDeployable property. */
      @query
      filter: string;
    }>
  >;

  /**
   * Import new update version. This is a long-running-operation; use
   * Operation-Location response header value to check for operation status.
   */
  @post
  @action("import")
  importUpdate is ServiceOperations.ResourceCollectionAction<
    Update,
    {
      /**
       * The update to be imported (see schema https://json.schemastore.org/azure-deviceupdate-import-manifest-5.0.json for details).
       */
      @body updateToImport: ImportUpdateInput;
    },
    Update
  >;

  /** Get a specific update version. */
  @route("/deviceUpdate/{instanceId}/updates/providers/{provider}/names/{name}/versions/{version}")
  @get
  getUpdate is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Update provider. */
      @path
      provider: string;

      /** Update name. */
      @path
      name: string;

      /** Update version. */
      @path
      version: string;

      @doc("""
Defines the If-None-Match condition. The operation will be performed only if
the ETag on the server does not match this value.
""")
      @header
      `If-None-Match`: string;
    },
    Update
  >;

  @doc("""
Delete a specific update version. This is a long-running-operation; use
Operation-Location response header value to check for operation status.
""")
  @route("/deviceUpdate/{instanceId}/updates/providers/{provider}/names/{name}/versions/{version}")
  @delete
  DeleteUpdate is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Update provider. */
      @path
      provider: string;

      /** Update name. */
      @path
      name: string;

      /** Update version. */
      @path
      version: string;
    },
    void
  >;

  /** Get a list of all update providers that have been imported to Device Update for IoT Hub. */
  listProviders is Azure.Core.Foundations.Operation<
    {
      ...InstanceIdParameter;
    },
    StringsList,
    {},
    ErrorResponse
  >;

  /** Get a list of all update names that match the specified provider. */
  listNames is Azure.Core.Foundations.Operation<
    {
      ...InstanceIdParameter;
      ...UpdateProviderParameter;
    },
    StringsList,
    {},
    ErrorResponse
  >;

  /** Get a list of all update versions that match the specified provider and name. */
  listVersions is Azure.Core.Foundations.Operation<
    {
      ...InstanceIdParameter;
      ...UpdateProviderParameter;
      ...UpdateNameParameter;

      /** Optional to filter updates by isDeployable property. */
      @query filter: string;
    },
    StringsList,
    {},
    ErrorResponse
  >;

  /** Get a list of all update file identifiers for the specified version. */
  listFiles is Azure.Core.Foundations.Operation<
    {
      ...InstanceIdParameter;
      ...UpdateProviderParameter;
      ...UpdateNameParameter;
      ...UpdateVersionParameter;

      /** Optional to filter updates by isDeployable property. */
      @query filter: string;
    },
    StringsList,
    {},
    ErrorResponse
  >;

  /** Get a specific update file from the version. */
  @route("/deviceUpdate/{instanceId}/updates/providers/{provider}/names/{name}/versions/{version}/files/{fileId}")
  @get
  getFile is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Update provider. */
      @path
      provider: string;

      /** Update name. */
      @path
      name: string;

      /** Update version. */
      @path
      version: string;

      /** File identifier. */
      @path
      fileId: string;

      @doc("""
Defines the If-None-Match condition. The operation will be performed only if
the ETag on the server does not match this value.
""")
      @header
      `If-None-Match`: string;
    },
    UpdateFile
  >;

  @doc("""
Get a list of all import update operations. Completed operations are kept for 7
days before auto-deleted. Delete operations are not returned by this API
version.
""")
  @route("/deviceUpdate/{instanceId}/updates/operations")
  @get
  listOperationStatuses is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      @doc("""
Optional to filter operations by status property. Only one specific filter is
supported: \"status eq 'NotStarted' or status eq 'Running'\"
""")
      @query
      filter: string;

      @doc("""
Specifies a non-negative integer n that limits the number of items returned
from a collection. The service returns the number of available items up to but
not greater than the specified value n.
""")
      @query
      top: int32;
    },
    UpdateOperationsList
  >;

  /** Retrieve operation status. */
  @route("/deviceUpdate/{instanceId}/updates/operations/{operationId}")
  @get
  GetOperationStatus is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Operation identifier. */
      @path
      operationId: string;

      @doc("""
Defines the If-None-Match condition. The operation will be performed only if
the ETag on the server does not match this value.
""")
      @header
      `If-None-Match`: string;
    },
    UpdateOperation
  >;
}

interface DeviceManagementOperations {
  @doc("""
Gets a list of all device classes (sets of devices compatible with the same
updates based on the model Id and compat properties reported in the Device
Update PnP interface in IoT Hub) for all devices connected to Device Update for
IoT Hub.
""")
  @route("/deviceUpdate/{instanceId}/management/deviceClasses")
  @get
  ListDeviceClasses is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Restricts the set of device classes returned. You can filter on friendly name. */
      @query
      filter: string;
    },
    DeviceClassesList
  >;

  /** Gets the properties of a device class. */
  @route("/deviceUpdate/{instanceId}/management/deviceClasses/{deviceClassId}")
  @get
  GetDeviceClass is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Device class identifier. */
      @path
      deviceClassId: string;
    },
    DeviceClass
  >;

  /** Update device class details. */
  @route("/deviceUpdate/{instanceId}/management/deviceClasses/{deviceClassId}")
  @patch
  UpdateDeviceClass is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Device class identifier. */
      @path
      deviceClassId: string;

      @doc("""
The device class json merge patch body. Currently only supports patching
friendlyName.
""")
      @body
      deviceClassPatch: PatchBody;
    },
    DeviceClass
  >;

  @doc("""
Deletes a device class. Device classes are created automatically when Device
Update-enabled devices are connected to the hub but are not automatically
cleaned up since they are referenced by DeviceClassSubgroups. If the user has
deleted all DeviceClassSubgroups for a device class they can also delete the
device class to remove the records from the system and to stop checking the
compatibility of this device class with new updates. If a device is ever
reconnected for this device class it will be re-created.
""")
  @route("/deviceUpdate/{instanceId}/management/deviceClasses/{deviceClassId}")
  @delete
  DeleteDeviceClass is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Device class identifier. */
      @path
      deviceClassId: string;
    },
    void
  >;

  /** Gets a list of installable updates for a device class. */
  @route("/deviceUpdate/{instanceId}/management/deviceClasses/{deviceClassId}/installableUpdates")
  @get
  ListInstallableUpdatesForDeviceClass is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Device class identifier. */
      @path
      deviceClassId: string;
    },
    UpdateInfoList
  >;

  /** Gets a list of devices connected to Device Update for IoT Hub. */
  @route("/deviceUpdate/{instanceId}/management/devices")
  @get
  listDevices is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      @doc("""
Restricts the set of devices returned. You can filter on GroupId,
DeviceClassId, or GroupId and DeploymentStatus. Use DeploymentStatus eq null to
query for devices with no deployment status (that have never been deployed to).
""")
      @query
      filter: string;
    },
    DevicesList
  >;

  @doc("""
Import existing devices from IoT Hub. This is a long-running-operation; use
Operation-Location response header value to check for operation status.
""")
  @route("/deviceUpdate/{instanceId}/management/devices:import")
  @post
  importDevices is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** The types of devices to import. */
      @body
      importType: ImportType;
    },
    void
  >;

  @doc("""
Gets the device properties and latest deployment status for a device connected
to Device Update for IoT Hub.
""")
  @route("/deviceUpdate/{instanceId}/management/devices/{deviceId}")
  @get
  getDevice is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Device identifier in Azure IoT Hub. */
      @path
      deviceId: string;
    },
    Device
  >;

  @doc("""
Gets the device module properties and latest deployment status for a device
module connected to Device Update for IoT Hub.
""")
  @route("/deviceUpdate/{instanceId}/management/devices/{deviceId}/modules/{moduleId}")
  @get
  getDeviceModule is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Device identifier in Azure IoT Hub. */
      @path
      deviceId: string;

      /** Device module identifier in Azure IoT Hub. */
      @path
      moduleId: string;
    },
    Device
  >;

  @doc("""
Gets the breakdown of how many devices are on their latest update, have new
updates available, or are in progress receiving new updates.
""")
  @route("/deviceUpdate/{instanceId}/management/updateCompliance")
  @get
  GetUpdateCompliance is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;
    },
    UpdateCompliance
  >;

  @doc("""
Gets a list of all device groups.  The $default group will always be returned
first.
""")
  @route("/deviceUpdate/{instanceId}/management/groups")
  @get
  ListGroups is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      @doc("""
Orders the set of groups returned. You can order by groupId, deviceCount,
createdDate, subgroupsWithNewUpdatesAvailableCount,
subgroupsWithUpdatesInProgressCount, or subgroupsOnLatestUpdateCount.
""")
      @query
      orderby: string;
    },
    GroupsList
  >;

  /** Gets the device group properties. */
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}")
  @get
  getGroup is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;
    },
    Group
  >;

  @doc("""
Deletes a device group. This group is automatically created when a Device
Update-enabled device is connected to the hub and reports its properties.
Groups, subgroups, and deployments are not automatically cleaned up but are
retained for history purposes. Users can call this method to delete a group if
they do not need to retain any of the history of the group and no longer need
it. If a device is ever connected again for this group after the group was
deleted it will be automatically re-created but there will be no history.
""")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}")
  @delete
  deleteGroup is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;
    },
    void
  >;

  @doc("""
Get device group update compliance information such as how many devices are on
their latest update, how many need new updates, and how many are in progress on
receiving a new update.
""")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/updateCompliance")
  @get
  getUpdateComplianceForGroup is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;
    },
    UpdateCompliance
  >;

  @doc("""
Get the best available updates for a device group and a count of how many
devices need each update.
""")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/bestUpdates")
  @get
  listBestUpdatesForGroup is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;
    },
    DeviceClassSubgroupUpdatableDevicesList
  >;

  /** Gets a list of deployments for a device group. */
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deployments")
  @get
  listDeploymentsForGroup is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;

      /** Orders the set of deployments returned. You can order by start date. */
      @query
      orderby: string;
    },
    DeploymentsList
  >;

  /** Gets the deployment properties. */
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deployments/{deploymentId}")
  @get
  getDeployment is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;

      /** Deployment identifier. */
      @path
      deploymentId: string;
    },
    Deployment
  >;

  /** Creates or updates a deployment. */
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deployments/{deploymentId}")
  @put
  CreateOrUpdateDeployment is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;

      /** Deployment identifier. */
      @path
      deploymentId: string;

      /** The deployment properties. */
      @body
      deployment: Deployment;
    },
    Deployment
  >;

  /** Deletes a deployment. */
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deployments/{deploymentId}")
  @delete
  DeleteDeployment is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;

      /** Deployment identifier. */
      @path
      deploymentId: string;
    },
    void
  >;

  @doc("""
Gets the status of a deployment including a breakdown of how many devices in
the deployment are in progress, completed, or failed.
""")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deployments/{deploymentId}/status")
  @get
  GetDeploymentStatus is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;

      /** Deployment identifier. */
      @path
      deploymentId: string;
    },
    DeploymentStatus
  >;

  @doc("""
Get the device class subgroups for the group. A device class subgroup is the
set of devices within the group that share the same device class. All devices
within the same device class are compatible with the same updates.
""")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups")
  @get
  ListDeviceClassSubgroupsForGroup is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;

      @doc("""
Restricts the set of device class subgroups returned. You can filter on compat
properties by name and value. (i.e. filter=compatProperties/propertyName1 eq
'value1' and compatProperties/propertyName2 eq 'value2')
""")
      @query
      filter: string;
    },
    DeviceClassSubgroupsList
  >;

  @doc("""
Gets device class subgroup details. A device class subgroup is the set of
devices within the group that share the same device class. All devices within
the same device class are compatible with the same updates.
""")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}")
  @get
  GetDeviceClassSubgroup is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;

      /** Device class identifier. */
      @path
      deviceClassId: string;
    },
    DeviceClassSubgroup
  >;

  @doc("""
Deletes a device class subgroup. This subgroup is automatically created when a
Device Update-enabled device is connected to the hub and reports its
properties. Groups, subgroups, and deployments are not automatically cleaned up
but are retained for history purposes. Users can call this method to delete a
subgroup if they do not need to retain any of the history of the subgroup and
no longer need it. If a device is ever connected again for this subgroup after
the subgroup was deleted it will be automatically re-created but there will be
no history.
""")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}")
  @delete
  DeleteDeviceClassSubgroup is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;

      /** Device class identifier. */
      @path
      deviceClassId: string;
    },
    void
  >;

  @doc("""
Get device class subgroup update compliance information such as how many
devices are on their latest update, how many need new updates, and how many are
in progress on receiving a new update.
""")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/updateCompliance")
  @get
  GetDeviceClassSubgroupUpdateCompliance is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;

      /** Device class identifier. */
      @path
      deviceClassId: string;
    },
    UpdateCompliance
  >;

  @doc("""
Get the best available update for a device class subgroup and a count of how
many devices need this update.
""")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/bestUpdates")
  @get
  GetBestUpdatesForDeviceClassSubgroup is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;

      /** Device class identifier. */
      @path
      deviceClassId: string;
    },
    DeviceClassSubgroupUpdatableDevices
  >;

  /** Gets a list of deployments for a device class subgroup. */
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments")
  @get
  ListDeploymentsForDeviceClassSubgroup is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;

      /** Device class identifier. */
      @path
      deviceClassId: string;

      /** Orders the set of deployments returned. You can order by start date. */
      @query
      orderby: string;
    },
    DeploymentsList
  >;

  /** Gets the deployment properties. */
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments/{deploymentId}")
  @get
  GetDeploymentForDeviceClassSubgroup is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;

      /** Device class identifier. */
      @path
      deviceClassId: string;

      /** Deployment identifier. */
      @path
      deploymentId: string;
    },
    Deployment
  >;

  /** Deletes a device class subgroup deployment. */
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments/{deploymentId}")
  @delete
  DeleteDeploymentForDeviceClassSubgroup is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;

      /** Device class identifier. */
      @path
      deviceClassId: string;

      /** Deployment identifier. */
      @path
      deploymentId: string;
    },
    void
  >;

  /** Stops a deployment. */
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments/{deploymentId}:cancel")
  @post
  StopDeployment is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;

      /** Device class identifier. */
      @path
      deviceClassId: string;

      /** Deployment identifier. */
      @path
      deploymentId: string;
    },
    Deployment
  >;

  /** Retries a deployment with failed devices. */
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments/{deploymentId}:retry")
  @post
  RetryDeployment is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;

      /** Device class identifier. */
      @path
      deviceClassId: string;

      /** Deployment identifier. */
      @path
      deploymentId: string;
    },
    Deployment
  >;

  @doc("""
Gets the status of a deployment including a breakdown of how many devices in
the deployment are in progress, completed, or failed.
""")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments/{deploymentId}/status")
  @get
  GetDeviceClassSubgroupDeploymentStatus is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;

      /** Device class identifier. */
      @path
      deviceClassId: string;

      /** Deployment identifier. */
      @path
      deploymentId: string;
    },
    DeviceClassSubgroupDeploymentStatus
  >;

  @doc("""
Gets a list of devices in a deployment along with their state. Useful for
getting a list of failed devices.
""")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments/{deploymentId}/devicestates")
  @get
  ListDeviceStatesForDeviceClassSubgroupDeployment is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Group identifier. */
      @path
      groupId: string;

      /** Device class identifier. */
      @path
      deviceClassId: string;

      /** Deployment identifier. */
      @path
      deploymentId: string;

      @doc("""
Restricts the set of deployment device states returned. You can filter on
deviceId and moduleId and/or deviceState.
""")
      @query
      filter: string;
    },
    DeploymentDeviceStatesList
  >;

  /** Retrieve operation status. */
  @route("/deviceUpdate/{instanceId}/management/operations/{operationId}")
  @get
  GetOperationStatus is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Operation identifier. */
      @path
      operationId: string;

      @doc("""
Defines the If-None-Match condition. The operation will be performed only if
the ETag on the server does not match this value.
""")
      @header
      `If-None-Match`: string;
    },
    DeviceOperation
  >;

  @doc("""
Get a list of all device import operations. Completed operations are kept for 7
days before auto-deleted.
""")
  @route("/deviceUpdate/{instanceId}/management/operations")
  @get
  ListOperationStatuses is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      @doc("""
Restricts the set of operations returned. Only one specific filter is
supported: \"status eq 'NotStarted' or status eq 'Running'\"
""")
      @query
      filter: string;

      @doc("""
Specifies a non-negative integer n that limits the number of items returned
from a collection. The service returns the number of available items up to but
not greater than the specified value n.
""")
      @query
      top: int32;
    },
    DeviceOperationsList
  >;

  /** Get all device diagnostics log collections */
  listLogCollections is ServiceOperations.ResourceList<LogCollection>;

  /** Get the device diagnostics log collection */
  getLogCollection is ServiceOperations.ResourceRead<LogCollection>;

  /** Start the device diagnostics log collection on specified devices. */
  startLogCollection is ServiceOperations.ResourceCreateOrReplace<LogCollection>;

  /** Get log collection with detailed status */
  @route("/deviceUpdate/{instanceId}/management/deviceDiagnostics/logCollections/{operationId}/detailedStatus")
  getLogCollectionDetailedStatus is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;

      /** Log collection identifier. */
      @path
      operationId: string;
    },
    LogCollectionOperationDetailedStatus
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
      filter: string;
    }>
  >;
}

interface InstanceManagementOperations {
  @doc("""
Gets the instance limits for active deployments, devices, device classes, and
groups.
""")
  @route("/deviceUpdate/{instanceId}/limits")
  @get
  getLimits is Azure.Core.Foundations.Operation<
    {
      /** The Device Update for IoT Hub account instance identifier. */
      @path
      instanceId: string;
    },
    LimitsResponse
  >;
}

model InstanceIdParameter {
  /** The Device Update for IoT Hub account instance identifier. */
  @path instanceId: string;
}

model UpdateProviderParameter {
  /** Update provider. */
  @path provider: string;
}

model UpdateNameParameter {
  /** Update name. */
  @path name: string;
}

model UpdateVersionParameter {
  /** Update version. */
  @path version: string;
}
