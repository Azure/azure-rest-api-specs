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
 * The Get Storage Account ManagementPolicies operation response.
 */
@parentResource(StorageAccount)
@singleton
model ManagementPolicy
  is Azure.ResourceManager.ProxyResource<ManagementPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ManagementPolicy,
    KeyName = "managementPolicyName",
    SegmentName = "managementPolicies",
    NamePattern = "",
    Type = ManagementPolicyName
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Legacy operations to preserve path parameter for singleton resource"
interface ManagementPolicyOps
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
        @doc("The name of the Storage Account Management Policy. It should always be 'default'")
        @path
        @segment("managementPolicies")
        managementPolicyName: ManagementPolicyName,
      },
      ErrorType = ErrorResponse
    > {}

@armResourceOperations
interface ManagementPolicies {
  /**
   * Gets the managementpolicy associated with the specified storage account.
   */
  get is ManagementPolicyOps.Read<ManagementPolicy>;

  /**
   * Sets the managementpolicy to the specified storage account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ManagementPolicyOps.CreateOrUpdateSync<
    ManagementPolicy,
    Response = ArmResourceUpdatedResponse<ManagementPolicy>
  >;

  /**
   * Deletes the managementpolicy associated with the specified storage account.
   */
  delete is ManagementPolicyOps.DeleteSync<ManagementPolicy>;
}

@@doc(ManagementPolicy.name,
  "The name of the Storage Account Management Policy. It should always be 'default'"
);
@@doc(ManagementPolicy.properties,
  "Returns the Storage Account Data Policies Rules."
);
@@doc(ManagementPolicies.createOrUpdate::parameters.resource,
  "The ManagementPolicy set to a storage account."
);
