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

namespace Microsoft.NetworkCloud;
@doc("StorageAppliance represents on-premises Network Cloud storage appliance.")
model StorageAppliance is TrackedResource<StorageApplianceProperties> {
  @doc("The name of the storage appliance.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("storageApplianceName")
  @segment("storageAppliances")
  name: string;

  @doc("The extended location of the cluster associated with the resource.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface StorageAppliances {
  @doc("Get properties of the provided storage appliance.")
  get is ArmResourceRead<StorageAppliance>;

  @doc("Update properties of the provided storage appliance, or update tags associated with the storage appliance Properties and tag updates can be done independently.")
  update is ArmCustomPatchAsync<
    StorageAppliance,
    StorageAppliancePatchParameters,
    BaseParameters<StorageAppliance>,
    ArmAsyncOperationHeader
  >;

  @doc("Get a list of storage appliances in the provided resource group.")
  listByResourceGroup is ArmResourceListByParent<StorageAppliance>;

  @doc("Get a list of storage appliances in the provided subscription.")
  listBySubscription is ArmListBySubscription<StorageAppliance>;

  @doc("Disable remote vendor management of the provided storage appliance.")
  disableRemoteVendorManagement is ArmResourceActionNoResponseContentAsync<
    StorageAppliance,
    void,
    BaseParameters<StorageAppliance>,
    ArmLroLocationHeader
  >;

  @doc("Enable remote vendor management of the provided storage appliance.")
  enableRemoteVendorManagement is ArmResourceActionNoResponseContentAsync<
    StorageAppliance,
    StorageApplianceEnableRemoteVendorManagementParameters,
    BaseParameters<StorageAppliance>,
    ArmLroLocationHeader
  >;
}

@@projectedName(StorageAppliances.update::parameters.properties,
  "json",
  "storageApplianceUpdateParameters"
);
@@extension(StorageAppliances.update::parameters.properties,
  "x-ms-client-name",
  "storageApplianceUpdateParameters"
);
@@doc(StorageAppliances.update::parameters.properties, "The request body.");
@@projectedName(StorageAppliances.enableRemoteVendorManagement::parameters.body,
  "json",
  "storageApplianceEnableRemoteVendorManagementParameters"
);
@@extension(StorageAppliances.enableRemoteVendorManagement::parameters.body,
  "x-ms-client-name",
  "storageApplianceEnableRemoteVendorManagementParameters"
);
@@doc(StorageAppliances.enableRemoteVendorManagement::parameters.body,
  "The request body."
);
