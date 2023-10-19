import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace DeviceUpdateClient;

interface DeviceUpdateOperations {
  @doc("Get a list of all updates that have been imported to Device Update for IoT Hub.")
  @route("/deviceUpdate/{instanceId}/updates")
  @get
  ListUpdates is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Request updates matching a free-text search expression.")
      @query
      search: string;

      @doc("Optional to filter updates by isDeployable property.")
      @query
      filter: string;
    },
    UpdateList
  >;

  @doc("""
Import new update version. This is a long-running-operation; use
Operation-Location response header value to check for operation status.
""")
  @route("/deviceUpdate/{instanceId}/updates:import")
  @post
  ImportUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("""
The update to be imported (see schema
https://json.schemastore.org/azure-deviceupdate-import-manifest-5.0.json for
details).
""")
      @body
      updateToImport: ImportUpdateInputItem[];
    },
    Update | void
  >;

  @doc("Get a specific update version.")
  @route("/deviceUpdate/{instanceId}/updates/providers/{provider}/names/{name}/versions/{version}")
  @get
  GetUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Update provider.")
      @path
      provider: string;

      @doc("Update name.")
      @path
      name: string;

      @doc("Update version.")
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
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Update provider.")
      @path
      provider: string;

      @doc("Update name.")
      @path
      name: string;

      @doc("Update version.")
      @path
      version: string;
    },
    void
  >;

  @doc("""
Get a list of all update providers that have been imported to Device Update for
IoT Hub.
""")
  ListProviders is Azure.Core.ResourceList<string>;

  @doc("Get a list of all update names that match the specified provider.")
  ListNames is Azure.Core.ResourceList<string>;

  @doc("Get a list of all update versions that match the specified provider and name.")
  ListVersions is Azure.Core.ResourceList<
    string,
    {
      parameters: {
        @doc("Optional to filter updates by isDeployable property.")
        @query
        filter: string;
      };
    }
  >;

  @doc("Get a list of all update file identifiers for the specified version.")
  ListFiles is Azure.Core.ResourceList<string>;

  @doc("Get a specific update file from the version.")
  @route("/deviceUpdate/{instanceId}/updates/providers/{provider}/names/{name}/versions/{version}/files/{fileId}")
  @get
  GetFile is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Update provider.")
      @path
      provider: string;

      @doc("Update name.")
      @path
      name: string;

      @doc("Update version.")
      @path
      version: string;

      @doc("File identifier.")
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
  ListOperationStatuses is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
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

  @doc("Retrieve operation status.")
  @route("/deviceUpdate/{instanceId}/updates/operations/{operationId}")
  @get
  GetOperationStatus is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Operation identifier.")
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
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Restricts the set of device classes returned. You can filter on friendly name.")
      @query
      filter: string;
    },
    DeviceClassesList
  >;

  @doc("Gets the properties of a device class.")
  @route("/deviceUpdate/{instanceId}/management/deviceClasses/{deviceClassId}")
  @get
  GetDeviceClass is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Device class identifier.")
      @path
      deviceClassId: string;
    },
    DeviceClass
  >;

  @doc("Update device class details.")
  @route("/deviceUpdate/{instanceId}/management/deviceClasses/{deviceClassId}")
  @patch
  UpdateDeviceClass is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Device class identifier.")
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
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Device class identifier.")
      @path
      deviceClassId: string;
    },
    void
  >;

  @doc("Gets a list of installable updates for a device class.")
  @route("/deviceUpdate/{instanceId}/management/deviceClasses/{deviceClassId}/installableUpdates")
  @get
  ListInstallableUpdatesForDeviceClass is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Device class identifier.")
      @path
      deviceClassId: string;
    },
    UpdateInfoList
  >;

  @doc("Gets a list of devices connected to Device Update for IoT Hub.")
  @route("/deviceUpdate/{instanceId}/management/devices")
  @get
  ListDevices is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
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
  ImportDevices is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("The types of devices to import.")
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
  GetDevice is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Device identifier in Azure IoT Hub.")
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
  GetDeviceModule is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Device identifier in Azure IoT Hub.")
      @path
      deviceId: string;

      @doc("Device module identifier in Azure IoT Hub.")
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
      @doc("The Device Update for IoT Hub account instance identifier.")
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
      @doc("The Device Update for IoT Hub account instance identifier.")
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

  @doc("Gets the device group properties.")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}")
  @get
  GetGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
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
  DeleteGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
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
  GetUpdateComplianceForGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
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
  ListBestUpdatesForGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
      @path
      groupId: string;
    },
    DeviceClassSubgroupUpdatableDevicesList
  >;

  @doc("Gets a list of deployments for a device group.")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deployments")
  @get
  ListDeploymentsForGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
      @path
      groupId: string;

      @doc("Orders the set of deployments returned. You can order by start date.")
      @query
      orderby: string;
    },
    DeploymentsList
  >;

  @doc("Gets the deployment properties.")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deployments/{deploymentId}")
  @get
  GetDeployment is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
      @path
      groupId: string;

      @doc("Deployment identifier.")
      @path
      deploymentId: string;
    },
    Deployment
  >;

  @doc("Creates or updates a deployment.")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deployments/{deploymentId}")
  @put
  CreateOrUpdateDeployment is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
      @path
      groupId: string;

      @doc("Deployment identifier.")
      @path
      deploymentId: string;

      @doc("The deployment properties.")
      @body
      deployment: Deployment;
    },
    Deployment
  >;

  @doc("Deletes a deployment.")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deployments/{deploymentId}")
  @delete
  DeleteDeployment is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
      @path
      groupId: string;

      @doc("Deployment identifier.")
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
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
      @path
      groupId: string;

      @doc("Deployment identifier.")
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
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
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
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
      @path
      groupId: string;

      @doc("Device class identifier.")
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
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
      @path
      groupId: string;

      @doc("Device class identifier.")
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
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
      @path
      groupId: string;

      @doc("Device class identifier.")
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
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
      @path
      groupId: string;

      @doc("Device class identifier.")
      @path
      deviceClassId: string;
    },
    DeviceClassSubgroupUpdatableDevices
  >;

  @doc("Gets a list of deployments for a device class subgroup.")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments")
  @get
  ListDeploymentsForDeviceClassSubgroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
      @path
      groupId: string;

      @doc("Device class identifier.")
      @path
      deviceClassId: string;

      @doc("Orders the set of deployments returned. You can order by start date.")
      @query
      orderby: string;
    },
    DeploymentsList
  >;

  @doc("Gets the deployment properties.")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments/{deploymentId}")
  @get
  GetDeploymentForDeviceClassSubgroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
      @path
      groupId: string;

      @doc("Device class identifier.")
      @path
      deviceClassId: string;

      @doc("Deployment identifier.")
      @path
      deploymentId: string;
    },
    Deployment
  >;

  @doc("Deletes a device class subgroup deployment.")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments/{deploymentId}")
  @delete
  DeleteDeploymentForDeviceClassSubgroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
      @path
      groupId: string;

      @doc("Device class identifier.")
      @path
      deviceClassId: string;

      @doc("Deployment identifier.")
      @path
      deploymentId: string;
    },
    void
  >;

  @doc("Stops a deployment.")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments/{deploymentId}:cancel")
  @post
  StopDeployment is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
      @path
      groupId: string;

      @doc("Device class identifier.")
      @path
      deviceClassId: string;

      @doc("Deployment identifier.")
      @path
      deploymentId: string;
    },
    Deployment
  >;

  @doc("Retries a deployment with failed devices.")
  @route("/deviceUpdate/{instanceId}/management/groups/{groupId}/deviceClassSubgroups/{deviceClassId}/deployments/{deploymentId}:retry")
  @post
  RetryDeployment is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
      @path
      groupId: string;

      @doc("Device class identifier.")
      @path
      deviceClassId: string;

      @doc("Deployment identifier.")
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
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
      @path
      groupId: string;

      @doc("Device class identifier.")
      @path
      deviceClassId: string;

      @doc("Deployment identifier.")
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
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Group identifier.")
      @path
      groupId: string;

      @doc("Device class identifier.")
      @path
      deviceClassId: string;

      @doc("Deployment identifier.")
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

  @doc("Retrieve operation status.")
  @route("/deviceUpdate/{instanceId}/management/operations/{operationId}")
  @get
  GetOperationStatus is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Operation identifier.")
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
      @doc("The Device Update for IoT Hub account instance identifier.")
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

  @doc("Start the device diagnostics log collection on specified devices.")
  @route("/deviceUpdate/{instanceId}/management/deviceDiagnostics/logCollections/{operationId}")
  @put
  StartLogCollection is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Log collection identifier.")
      @path
      operationId: string;

      @doc("The log collection properties.")
      @body
      logCollection: LogCollection;
    },
    LogCollection
  >;

  @doc("Get the device diagnostics log collection")
  @route("/deviceUpdate/{instanceId}/management/deviceDiagnostics/logCollections/{operationId}")
  @get
  GetLogCollection is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Log collection identifier.")
      @path
      operationId: string;
    },
    LogCollection
  >;

  @doc("Get all device diagnostics log collections")
  @route("/deviceUpdate/{instanceId}/management/deviceDiagnostics/logCollections")
  @get
  ListLogCollections is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;
    },
    LogCollectionList
  >;

  @doc("Get log collection with detailed status")
  @route("/deviceUpdate/{instanceId}/management/deviceDiagnostics/logCollections/{operationId}/detailedStatus")
  @get
  GetLogCollectionDetailedStatus is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("Log collection identifier.")
      @path
      operationId: string;
    },
    LogCollectionOperationDetailedStatus
  >;

  @doc("Get list of device health")
  @route("/deviceUpdate/{instanceId}/management/deviceDiagnostics/deviceHealth")
  @get
  ListHealthOfDevices is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;

      @doc("""
Restricts the set of devices for which device health is returned. You can
filter on status, device id and module id.
""")
      @query
      filter: string;
    },
    DeviceHealthList
  >;
}

interface InstanceManagementOperations {
  @doc("""
Gets the instance limits for active deployments, devices, device classes, and
groups.
""")
  @route("/deviceUpdate/{instanceId}/limits")
  @get
  GetLimits is Azure.Core.Foundations.Operation<
    {
      @doc("The Device Update for IoT Hub account instance identifier.")
      @path
      instanceId: string;
    },
    LimitsResponse
  >;
}
