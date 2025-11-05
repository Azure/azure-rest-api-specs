import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * The Data Box Edge/Gateway device.
 */
model DataBoxEdgeDevice
  is Azure.ResourceManager.TrackedResource<DataBoxEdgeDeviceProperties> {
  ...ResourceNameParameter<
    Resource = DataBoxEdgeDevice,
    KeyName = "deviceName",
    SegmentName = "dataBoxEdgeDevices",
    NamePattern = ""
  >;

  /**
   * The SKU type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;

  /**
   * The etag for the devices.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  /**
   * Msi identity of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ResourceIdentity;

  /**
   * The kind of the device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  kind?: DataBoxEdgeDeviceKind;
}

@armResourceOperations
interface DataBoxEdgeDevices {
  /**
   * Gets the properties of the Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Devices_Get")
  get is ArmResourceRead<DataBoxEdgeDevice>;

  /**
   * Creates or updates a Data Box Edge/Data Box Gateway resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Devices_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DataBoxEdgeDevice,
    Response = ArmResourceUpdatedResponse<DataBoxEdgeDevice>
  >;

  /**
   * Modifies a Data Box Edge/Data Box Gateway resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Devices_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    DataBoxEdgeDevice,
    PatchModel = DataBoxEdgeDevicePatch
  >;

  /**
   * Deletes the Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Devices_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    DataBoxEdgeDevice,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all the Data Box Edge/Data Box Gateway devices in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Devices_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    DataBoxEdgeDevice,
    Parameters = {
      /**
       * Specify $expand=details to populate additional fields related to the resource or Specify $skipToken=<token> to populate the next page in the list.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = ArmResponse<DataBoxEdgeDeviceList>
  >;

  /**
   * Gets all the Data Box Edge/Data Box Gateway devices in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Devices_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    DataBoxEdgeDevice,
    Parameters = {
      /**
       * Specify $expand=details to populate additional fields related to the resource or Specify $skipToken=<token> to populate the next page in the list.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = ArmResponse<DataBoxEdgeDeviceList>
  >;

  /**
   * Downloads the updates on a Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Devices_DownloadUpdates")
  downloadUpdates is ArmResourceActionAsync<
    DataBoxEdgeDevice,
    void,
    OkResponse
  >;

  /**
   * Generates certificate for activation key.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Devices_GenerateCertificate")
  generateCertificate is ArmResourceActionSync<
    DataBoxEdgeDevice,
    void,
    ArmResponse<GenerateCertResponse>
  >;

  /**
   * Gets additional information for the specified Azure Stack Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Devices_GetExtendedInformation")
  getExtendedInformation is ArmResourceActionSync<
    DataBoxEdgeDevice,
    void,
    ArmResponse<DataBoxEdgeDeviceExtendedInfo>
  >;

  /**
   * Installs the updates on the Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Devices_InstallUpdates")
  installUpdates is ArmResourceActionAsync<DataBoxEdgeDevice, void, OkResponse>;

  /**
   * Scans for updates on a Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Devices_ScanForUpdates")
  scanForUpdates is ArmResourceActionAsync<DataBoxEdgeDevice, void, OkResponse>;

  /**
   * Updates the security settings on a Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Devices_CreateOrUpdateSecuritySettings")
  @action("update")
  createOrUpdateSecuritySettings is ArmResourceActionAsync<
    DataBoxEdgeDevice,
    SecuritySettings,
    NoContentResponse
  >;

  /**
   * Gets additional information for the specified Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Devices_UpdateExtendedInformation")
  updateExtendedInformation is ArmResourceActionSync<
    DataBoxEdgeDevice,
    DataBoxEdgeDeviceExtendedInfoPatch,
    ArmResponse<DataBoxEdgeDeviceExtendedInfo>
  >;

  /**
   * Uploads registration certificate for the device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Devices_UploadCertificate")
  uploadCertificate is ArmResourceActionSync<
    DataBoxEdgeDevice,
    UploadCertificateRequest,
    ArmResponse<UploadCertificateResponse>
  >;

  /**
   * Posts the device capacity request info to check feasibility.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeviceCapacityCheck_CheckResourceCreationFeasibility")
  @action("deviceCapacityCheck")
  checkResourceCreationFeasibility is ArmResourceActionAsync<
    DataBoxEdgeDevice,
    DeviceCapacityRequestInfo,
    OkResponse,
    Parameters = {
      /**
       * The capacity name.
       */
      @query("capacityName")
      capacityName?: string;
    },
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets all the nodes currently configured under this Data Box Edge device
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Nodes_ListByDataBoxEdgeDevice")
  @list
  @get
  @action("nodes")
  listByDataBoxEdgeDevice is ArmResourceActionSync<
    DataBoxEdgeDevice,
    void,
    ArmResponse<NodeList>
  >;

  /**
   * Triggers support package on the device
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SupportPackages_TriggerSupportPackage")
  triggerSupportPackage is ArmResourceActionAsync<
    DataBoxEdgeDevice,
    TriggerSupportPackageRequest,
    OkResponse
  >;
}

@@doc(DataBoxEdgeDevice.name, "The device name.");
@@doc(DataBoxEdgeDevice.properties,
  "The properties of the Data Box Edge/Gateway device."
);
@@doc(DataBoxEdgeDevices.createOrUpdate::parameters.resource,
  "The resource object."
);
@@doc(DataBoxEdgeDevices.update::parameters.properties,
  "The resource parameters."
);
@@doc(DataBoxEdgeDevices.createOrUpdateSecuritySettings::parameters.body,
  "The security settings."
);
@@doc(DataBoxEdgeDevices.updateExtendedInformation::parameters.body,
  "The patch object."
);
@@doc(DataBoxEdgeDevices.uploadCertificate::parameters.body,
  "The upload certificate request."
);
@@doc(DataBoxEdgeDevices.checkResourceCreationFeasibility::parameters.body,
  "The device capacity request info."
);
@@doc(DataBoxEdgeDevices.triggerSupportPackage::parameters.body,
  "The trigger support package request object"
);
