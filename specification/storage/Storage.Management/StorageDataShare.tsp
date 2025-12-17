import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Storage;
/**
 * A DataShare is a tracked ARM resource modeled as a sub-resource of a Storage Account.
 */
@parentResource(StorageAccount)
@added(Versions.v2025_08_01)
model DataShare
  is Azure.ResourceManager.TrackedResource<StorageDataShareProperties> {
  ...ResourceNameParameter<
    Resource = DataShare,
    KeyName = "dataShareName",
    SegmentName = "dataShares",
    NamePattern = "^[a-z0-9](?!.*--)[a-z0-9-]{1,61}[a-z0-9]$"
  >;
}

@armResourceOperations
@added(Versions.v2025_08_01)
interface DataShares {
  /**
   * Get the specified Storage DataShare.
   */
  get is ArmResourceRead<DataShare>;

  /**
   * Create a Storage DataShare if it does not already exist; otherwise, error out. This API will not allow you to replace an already existing resource.
   */
  create is ArmResourceCreateOrReplaceAsync<DataShare>;

  /**
   * Update a Storage DataShare.
   */
  update is ArmResourcePatchAsync<DataShare, StorageDataShareProperties>;

  /**
   * Delete a Storage DataShare.
   */
  delete is ArmResourceDeleteWithoutOkAsync<DataShare>;

  /**
   * List all Storage DataShares in a Storage Account.
   */
  listByStorageAccount is ArmResourceListByParent<DataShare>;
}

@@maxLength(DataShare.name, 63);
@@minLength(DataShare.name, 3);
@@doc(DataShare.name, "The name of the Storage DataShare.");
@@doc(DataShare.properties, "The properties of the Storage DataShare.");
@@doc(DataShares.create::parameters.resource,
  "Create a Storage DataShare if it does not already exist; otherwise, error out. This API will not allow you to replace an already existing resource."
);
@@doc(DataShares.update::parameters.properties,
  "The updated properties of the Storage DataShare."
);
