import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
@doc("The Data Box Edge/Gateway device.")
model DataBoxEdgeDevice is TrackedResource<DataBoxEdgeDeviceProperties> {
  @doc("The device name.")
  @path
  @key("deviceName")
  @segment("dataBoxEdgeDevices")
  name: string;

  @doc("The etag for the devices.")
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataBoxEdgeDevices {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the properties of the Data Box Edge/Data Box Gateway device.")
  @operationId("Devices_Get")
  get is ArmResourceRead<DataBoxEdgeDevice>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a Data Box Edge/Data Box Gateway resource.")
  @operationId("Devices_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataBoxEdgeDevice>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Modifies a Data Box Edge/Data Box Gateway resource.")
  @operationId("Devices_Update")
  update is ArmCustomPatchSync<DataBoxEdgeDevice, DataBoxEdgeDevicePatch>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the Data Box Edge/Data Box Gateway device.")
  @operationId("Devices_Delete")
  delete is ArmResourceDeleteAsync<DataBoxEdgeDevice>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all the Data Box Edge/Data Box Gateway devices in a resource group.")
  @operationId("Devices_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    DataBoxEdgeDevice,
    {
      ...BaseParameters<DataBoxEdgeDevice>;

      @doc("Specify $expand=details to populate additional fields related to the resource or Specify $skipToken=<token> to populate the next page in the list.")
      @query("$expand")
      $expand?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all the Data Box Edge/Data Box Gateway devices in a subscription.")
  @operationId("Devices_ListBySubscription")
  listBySubscription is ArmListBySubscription<DataBoxEdgeDevice>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Downloads the updates on a Data Box Edge/Data Box Gateway device.")
  @operationId("Devices_DownloadUpdates")
  downloadUpdates is ArmResourceActionAsync<DataBoxEdgeDevice, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Generates certificate for activation key.")
  @operationId("Devices_GenerateCertificate")
  generateCertificate is ArmResourceActionSync<
    DataBoxEdgeDevice,
    void,
    GenerateCertResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets additional information for the specified Azure Stack Edge/Data Box Gateway device.")
  @operationId("Devices_GetExtendedInformation")
  getExtendedInformation is ArmResourceActionSync<
    DataBoxEdgeDevice,
    void,
    DataBoxEdgeDeviceExtendedInfo
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Installs the updates on the Data Box Edge/Data Box Gateway device.")
  @operationId("Devices_InstallUpdates")
  installUpdates is ArmResourceActionAsync<DataBoxEdgeDevice, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Scans for updates on a Data Box Edge/Data Box Gateway device.")
  @operationId("Devices_ScanForUpdates")
  scanForUpdates is ArmResourceActionAsync<DataBoxEdgeDevice, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the security settings on a Data Box Edge/Data Box Gateway device.")
  @operationId("Devices_CreateOrUpdateSecuritySettings")
  createOrUpdateSecuritySettings is ArmResourceActionNoResponseContentAsync<
    DataBoxEdgeDevice,
    SecuritySettings
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets additional information for the specified Data Box Edge/Data Box Gateway device.")
  @operationId("Devices_UpdateExtendedInformation")
  updateExtendedInformation is ArmResourceActionSync<
    DataBoxEdgeDevice,
    DataBoxEdgeDeviceExtendedInfoPatch,
    DataBoxEdgeDeviceExtendedInfo
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Uploads registration certificate for the device.")
  @operationId("Devices_UploadCertificate")
  uploadCertificate is ArmResourceActionSync<
    DataBoxEdgeDevice,
    UploadCertificateRequest,
    UploadCertificateResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Posts the device capacity request info to check feasibility.")
  @operationId("DeviceCapacityCheck_CheckResourceCreationFeasibility")
  checkResourceCreationFeasibility is ArmResourceActionAsync<
    DataBoxEdgeDevice,
    DeviceCapacityRequestInfo,
    void,
    {
      ...BaseParameters<DataBoxEdgeDevice>;

      @doc("The capacity name.")
      @query("capacityName")
      capacityName?: string;
    },
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Triggers support package on the device")
  @operationId("SupportPackages_TriggerSupportPackage")
  triggerSupportPackage is ArmResourceActionAsync<
    DataBoxEdgeDevice,
    TriggerSupportPackageRequest,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Devices_GetNetworkSettings")
  @doc("Gets the network settings of the specified Data Box Edge/Data Box Gateway device.")
  // FIXME: Devices_GetNetworkSettings could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/networkSettings/default")
  @get
  getNetworkSettings is Azure.Core.Foundations.Operation<
    {
      @doc("The device name.")
      @path
      deviceName: string;

      @doc("The subscription ID.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;
    },
    NetworkSettings
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Devices_GetUpdateSummary")
  @summary("Gets information about the availability of updates based on the last scan of the device. It also gets information about any ongoing download or install jobs on the device.")
  @doc("Gets information about the availability of updates based on the last scan of the device. It also gets information about any ongoing download or install jobs on the device.")
  // FIXME: Devices_GetUpdateSummary could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/updateSummary/default")
  @get
  getUpdateSummary is Azure.Core.Foundations.Operation<
    {
      @doc("The device name.")
      @path
      deviceName: string;

      @doc("The subscription ID.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;
    },
    UpdateSummary
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DeviceCapacityInfo_GetDeviceCapacityInfo")
  @doc("Gets the properties of the specified device capacity info.")
  // FIXME: DeviceCapacityInfo_GetDeviceCapacityInfo could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/deviceCapacityInfo/default")
  @get
  getDeviceCapacityInfo is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription ID.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The device name.")
      @path
      deviceName: string;
    },
    DeviceCapacityInfo
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Nodes_ListByDataBoxEdgeDevice")
  @doc("Gets all the nodes currently configured under this Data Box Edge device")
  // FIXME: Nodes_ListByDataBoxEdgeDevice could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/nodes")
  @get
  listByDataBoxEdgeDevice is Azure.Core.Foundations.Operation<
    {
      @doc("The device name.")
      @path
      deviceName: string;

      @doc("The subscription ID.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;
    },
    NodeList
  >;
}

@@projectedName(DataBoxEdgeDevices.createOrUpdate::parameters.resource,
  "json",
  "dataBoxEdgeDevice"
);
@@extension(DataBoxEdgeDevices.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "dataBoxEdgeDevice"
);
@@doc(DataBoxEdgeDevices.createOrUpdate::parameters.resource,
  "The resource object."
);
@@projectedName(DataBoxEdgeDevices.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(DataBoxEdgeDevices.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(DataBoxEdgeDevices.update::parameters.properties,
  "The resource parameters."
);
@@projectedName(DataBoxEdgeDevices.createOrUpdateSecuritySettings::parameters.body,
  "json",
  "securitySettings"
);
@@extension(DataBoxEdgeDevices.createOrUpdateSecuritySettings::parameters.body,
  "x-ms-client-name",
  "securitySettings"
);
@@doc(DataBoxEdgeDevices.createOrUpdateSecuritySettings::parameters.body,
  "The security settings."
);
@@projectedName(DataBoxEdgeDevices.updateExtendedInformation::parameters.body,
  "json",
  "parameters"
);
@@extension(DataBoxEdgeDevices.updateExtendedInformation::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(DataBoxEdgeDevices.updateExtendedInformation::parameters.body,
  "The patch object."
);
@@projectedName(DataBoxEdgeDevices.uploadCertificate::parameters.body,
  "json",
  "parameters"
);
@@extension(DataBoxEdgeDevices.uploadCertificate::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(DataBoxEdgeDevices.uploadCertificate::parameters.body,
  "The upload certificate request."
);
@@projectedName(DataBoxEdgeDevices.checkResourceCreationFeasibility::parameters.body,
  "json",
  "deviceCapacityRequestInfo"
);
@@extension(DataBoxEdgeDevices.checkResourceCreationFeasibility::parameters.body,
  "x-ms-client-name",
  "deviceCapacityRequestInfo"
);
@@doc(DataBoxEdgeDevices.checkResourceCreationFeasibility::parameters.body,
  "The device capacity request info."
);
@@projectedName(DataBoxEdgeDevices.triggerSupportPackage::parameters.body,
  "json",
  "triggerSupportPackageRequest"
);
@@extension(DataBoxEdgeDevices.triggerSupportPackage::parameters.body,
  "x-ms-client-name",
  "triggerSupportPackageRequest"
);
@@doc(DataBoxEdgeDevices.triggerSupportPackage::parameters.body,
  "The trigger support package request object"
);
