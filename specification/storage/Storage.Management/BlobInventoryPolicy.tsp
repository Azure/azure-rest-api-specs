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

namespace Microsoft.Storage;
/**
 * The storage account blob inventory policy.
 */
@parentResource(StorageAccount)
@singleton
model BlobInventoryPolicy
  is Azure.ResourceManager.ProxyResource<BlobInventoryPolicyProperties> {
  ...ResourceNameParameter<
    Resource = BlobInventoryPolicy,
    KeyName = "blobInventoryPolicyName",
    SegmentName = "inventoryPolicies",
    NamePattern = "",
    Type = BlobInventoryPolicyName
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Legacy operations to preserve path parameter for singleton resource"
interface BlobInventoryPolicyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        @doc("The name of the storage account within the specified resource group. Storage account names must be between 3 and 24 characters in length and use numbers and lower-case letters only.")
        @path
        @segment("storageAccounts")
        @minLength(3)
        @maxLength(24)
        @pattern("^[a-z0-9]+$")
        accountName: string,
      },
      {
        @doc("The name of the storage account blob inventory policy. It should always be 'default'")
        @path
        @segment("inventoryPolicies")
        blobInventoryPolicyName: BlobInventoryPolicyName,
      },
      ErrorType = CloudError
    > {}

@armResourceOperations
interface BlobInventoryPolicies {
  /**
   * Gets the blob inventory policy associated with the specified storage account.
   */
  get is BlobInventoryPolicyOps.Read<BlobInventoryPolicy>;

  /**
   * Sets the blob inventory policy to the specified storage account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is BlobInventoryPolicyOps.CreateOrUpdateSync<
    BlobInventoryPolicy,
    Response = ArmResourceUpdatedResponse<BlobInventoryPolicy>
  >;

  /**
   * Deletes the blob inventory policy associated with the specified storage account.
   */
  delete is BlobInventoryPolicyOps.DeleteSync<BlobInventoryPolicy>;

  /**
   * Gets the blob inventory policy associated with the specified storage account.
   */
  list is ArmResourceListByParent<
    BlobInventoryPolicy,
    Response = ArmResponse<ListBlobInventoryPolicy>,
    Error = ErrorResponse
  >;
}

@@doc(BlobInventoryPolicy.name,
  "The name of the storage account blob inventory policy. It should always be 'default'"
);
@@doc(BlobInventoryPolicy.properties,
  "Returns the storage account blob inventory policy rules."
);
@@doc(BlobInventoryPolicies.createOrUpdate::parameters.resource,
  "The blob inventory policy set to a storage account."
);
