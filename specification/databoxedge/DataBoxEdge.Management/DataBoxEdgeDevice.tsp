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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;

  /**
   * The etag for the devices.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  /**
   * Msi identity of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ResourceIdentity;

  /**
   * The kind of the device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  kind?: DataBoxEdgeDeviceKind;
}

@armResourceOperations
interface DataBoxEdgeDevices {
  /**
   * Gets the properties of the Data Box Edge/Data Box Gateway device.
   */
  get is ArmResourceRead<DataBoxEdgeDevice, Error = CloudError>;

  /**
   * Creates or updates a Data Box Edge/Data Box Gateway resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DataBoxEdgeDevice,
    Response = ArmResourceUpdatedResponse<DataBoxEdgeDevice>,
    Error = CloudError
  >;

  /**
   * Modifies a Data Box Edge/Data Box Gateway resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    DataBoxEdgeDevice,
    PatchModel = DataBoxEdgeDevicePatch,
    Error = CloudError
  >;

  /**
   * Deletes the Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    DataBoxEdgeDevice,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the Data Box Edge/Data Box Gateway devices in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    DataBoxEdgeDevice,
    Parameters = {
      /**
       * Specify $expand=details to populate additional fields related to the resource or Specify $skipToken=<token> to populate the next page in the list.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = ArmResponse<DataBoxEdgeDeviceList>,
    Error = CloudError
  >;

  /**
   * Gets all the Data Box Edge/Data Box Gateway devices in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    DataBoxEdgeDevice,
    Parameters = {
      /**
       * Specify $expand=details to populate additional fields related to the resource or Specify $skipToken=<token> to populate the next page in the list.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = ArmResponse<DataBoxEdgeDeviceList>,
    Error = CloudError
  >;

  /**
   * Downloads the updates on a Data Box Edge/Data Box Gateway device.
   */
  @summary("Downloads the updates on a Data Box Edge/Data Box Gateway device.")
  downloadUpdates is ArmResourceActionAsync<
    DataBoxEdgeDevice,
    void,
    OkResponse,
    Error = CloudError,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Generates certificate for activation key.
   */
  generateCertificate is ArmResourceActionSync<
    DataBoxEdgeDevice,
    void,
    ArmResponse<GenerateCertResponse>,
    Error = CloudError
  >;

  /**
   * Gets additional information for the specified Azure Stack Edge/Data Box Gateway device.
   */
  getExtendedInformation is ArmResourceActionSync<
    DataBoxEdgeDevice,
    void,
    ArmResponse<DataBoxEdgeDeviceExtendedInfo>,
    Error = CloudError
  >;

  /**
   * Installs the updates on the Data Box Edge/Data Box Gateway device.
   */
  @summary("Installs the updates on the Data Box Edge/Data Box Gateway device.")
  installUpdates is ArmResourceActionAsync<
    DataBoxEdgeDevice,
    void,
    OkResponse,
    Error = CloudError,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Scans for updates on a Data Box Edge/Data Box Gateway device.
   */
  scanForUpdates is ArmResourceActionAsync<
    DataBoxEdgeDevice,
    void,
    OkResponse,
    Error = CloudError,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Updates the security settings on a Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("securitySettings/default/update")
  createOrUpdateSecuritySettings is ArmResourceActionAsync<
    DataBoxEdgeDevice,
    SecuritySettings,
    NoContentResponse,
    Error = CloudError,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Gets additional information for the specified Data Box Edge/Data Box Gateway device.
   */
  @action("updateExtendedInformation")
  updateExtendedInformation is ArmResourceActionSync<
    DataBoxEdgeDevice,
    DataBoxEdgeDeviceExtendedInfoPatch,
    ArmResponse<DataBoxEdgeDeviceExtendedInfo>,
    Error = CloudError
  >;

  /**
   * Uploads registration certificate for the device.
   */
  uploadCertificate is ArmResourceActionSync<
    DataBoxEdgeDevice,
    UploadCertificateRequest,
    ArmResponse<UploadCertificateResponse>,
    Error = CloudError
  >;

  /**
   * Posts the device capacity request info to check feasibility.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
    Error = CloudError,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets all the nodes currently configured under this Data Box Edge device
   */
  @list
  @get
  @action("nodes")
  listByDataBoxEdgeDevice is ArmResourceActionSync<
    DataBoxEdgeDevice,
    void,
    ArmResponse<NodeList>,
    Error = CloudError
  >;

  /**
   * Triggers support package on the device
   */
  @summary("Triggers support package on the device")
  triggerSupportPackage is ArmResourceActionAsync<
    DataBoxEdgeDevice,
    TriggerSupportPackageRequest,
    OkResponse,
    Error = CloudError,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
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
