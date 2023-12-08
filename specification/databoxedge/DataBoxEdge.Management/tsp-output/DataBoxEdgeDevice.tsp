import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataBoxEdge;
@doc("The Data Box Edge/Gateway device.")
model DataBoxEdgeDevice is TrackedResource<DataBoxEdgeDeviceProperties> {
  @doc("The device name.")
  @path
  @key("deviceName")
  @segment("dataBoxEdgeDevices")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataBoxEdgeDevices {
  @doc("Gets the properties of the Data Box Edge/Data Box Gateway device.")
  get is ArmResourceRead<DataBoxEdgeDevice>;
  @doc("Creates or updates a Data Box Edge/Data Box Gateway resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataBoxEdgeDevice>;
  @doc("Modifies a Data Box Edge/Data Box Gateway resource.")
  update is ArmResourcePatchSync<
    DataBoxEdgeDevice,
    DataBoxEdgeDeviceProperties
  >;
  @doc("Deletes the Data Box Edge/Data Box Gateway device.")
  delete is ArmResourceDeleteAsync<DataBoxEdgeDevice>;
  @doc("Gets all the Data Box Edge/Data Box Gateway devices in a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    DataBoxEdgeDevice,
    {
      ...BaseParameters<DataBoxEdgeDevice>;

      @doc("Specify $expand=details to populate additional fields related to the resource or Specify $skipToken=<token> to populate the next page in the list.")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Gets all the Data Box Edge/Data Box Gateway devices in a subscription.")
  listBySubscription is ArmListBySubscription<DataBoxEdgeDevice>;
  @doc("Downloads the updates on a Data Box Edge/Data Box Gateway device.")
  downloadUpdates is ArmResourceActionAsync<DataBoxEdgeDevice, {}, {}>;
  @doc("Generates certificate for activation key.")
  generateCertificate is ArmResourceActionSync<
    DataBoxEdgeDevice,
    {},
    GenerateCertResponse
  >;
  @doc("Gets additional information for the specified Azure Stack Edge/Data Box Gateway device.")
  getExtendedInformation is ArmResourceActionSync<
    DataBoxEdgeDevice,
    {},
    DataBoxEdgeDeviceExtendedInfo
  >;
  @doc("Installs the updates on the Data Box Edge/Data Box Gateway device.")
  installUpdates is ArmResourceActionAsync<DataBoxEdgeDevice, {}, {}>;
  @doc("Scans for updates on a Data Box Edge/Data Box Gateway device.")
  scanForUpdates is ArmResourceActionAsync<DataBoxEdgeDevice, {}, {}>;
  @doc("Updates the security settings on a Data Box Edge/Data Box Gateway device.")
  createOrUpdateSecuritySettings is ArmResourceActionNoResponseContentAsync<
    DataBoxEdgeDevice,
    SecuritySettings
  >;
  @doc("Gets additional information for the specified Data Box Edge/Data Box Gateway device.")
  updateExtendedInformation is ArmResourceActionSync<
    DataBoxEdgeDevice,
    DataBoxEdgeDeviceExtendedInfoPatch,
    DataBoxEdgeDeviceExtendedInfo
  >;
  @doc("Uploads registration certificate for the device.")
  uploadCertificate is ArmResourceActionSync<
    DataBoxEdgeDevice,
    UploadCertificateRequest,
    UploadCertificateResponse
  >;
  @doc("Posts the device capacity request info to check feasibility.")
  checkResourceCreationFeasibility is ArmResourceActionAsync<
    DataBoxEdgeDevice,
    DeviceCapacityRequestInfo,
    {},
    {
      ...BaseParameters<DataBoxEdgeDevice>;

      @doc("The capacity name.")
      @query("capacityName")
      capacityName?: string;
    }
  >;
  @doc("Triggers support package on the device")
  triggerSupportPackage is ArmResourceActionAsync<
    DataBoxEdgeDevice,
    TriggerSupportPackageRequest,
    {}
  >;
  @doc("Gets the network settings of the specified Data Box Edge/Data Box Gateway device.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/networkSettings/default")
  @get
  GetNetworkSettings is Azure.Core.Foundations.Operation<
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

  @summary("Gets information about the availability of updates based on the last scan of the device. It also gets information about any ongoing download or install jobs on the device.")
  @doc("Gets information about the availability of updates based on the last scan of the device. It also gets information about any ongoing download or install jobs on the device.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/updateSummary/default")
  @get
  GetUpdateSummary is Azure.Core.Foundations.Operation<
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

  @doc("Gets the properties of the specified device capacity info.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/deviceCapacityInfo/default")
  @get
  GetDeviceCapacityInfo is Azure.Core.Foundations.Operation<
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

  @doc("Gets all the nodes currently configured under this Data Box Edge device")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/nodes")
  @get
  ListByDataBoxEdgeDevice is Azure.Core.Foundations.Operation<
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
