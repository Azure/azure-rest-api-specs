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
/**
 * StorageAppliance represents on-premises Network Cloud storage appliance.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(StorageApplianceProperties)
@includeInapplicableMetadataInPayload(false)
model StorageAppliance extends TrackedResourceBase {
  /**
   * The name of the storage appliance.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("storageApplianceName")
  @segment("storageAppliances")
  name: string;

  /**
   * The extended location of the cluster associated with the resource.
   */
  extendedLocation: ExtendedLocation;

  /**
   * The list of the resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: StorageApplianceProperties;
}

@armResourceOperations
interface StorageAppliances {
  /**
   * Get properties of the provided storage appliance.
   */
  get is ArmResourceRead<StorageAppliance>;

  /**
   * Update properties of the provided storage appliance, or update tags associated with the storage appliance Properties and tag updates can be done independently.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    StorageAppliance,
    StorageAppliancePatchParameters,
    BaseParameters<StorageAppliance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Get a list of storage appliances in the provided resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StorageAppliances_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<StorageAppliance>;

  /**
   * Get a list of storage appliances in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<StorageAppliance>;

  /**
   * Disable remote vendor management of the provided storage appliance.
   */
  disableRemoteVendorManagement is ArmResourceActionAsync<
    StorageAppliance,
    void,
    OperationStatusResult,
    BaseParameters<StorageAppliance>,
    ArmLroLocationHeader
  >;

  /**
   * Enable remote vendor management of the provided storage appliance.
   */
  enableRemoteVendorManagement is ArmResourceActionAsync<
    StorageAppliance,
    StorageApplianceEnableRemoteVendorManagementParameters,
    OperationStatusResult,
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
