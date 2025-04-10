import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataLakeStore;
/**
 * Data Lake Store account information.
 */
model DataLakeStoreAccount
  is Azure.ResourceManager.TrackedResource<DataLakeStoreAccountProperties> {
  ...ResourceNameParameter<
    Resource = DataLakeStoreAccount,
    KeyName = "accountName",
    SegmentName = "accounts",
    NamePattern = ""
  >;

  /**
   * The Key Vault encryption identity, if any.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  identity?: EncryptionIdentity;
}

@armResourceOperations
interface DataLakeStoreAccounts {
  /**
   * Gets the specified Data Lake Store account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_Get")
  get is ArmResourceRead<DataLakeStoreAccount>;

  /**
   * Creates the specified Data Lake Store account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_Create")
  create is ArmResourceCreateOrReplaceAsync<
    DataLakeStoreAccount,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates the specified Data Lake Store account information.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("Accounts_Update")
  update is ArmCustomPatchAsync<
    DataLakeStoreAccount,
    PatchModel = UpdateDataLakeStoreAccountParameters,
    Response = ArmResponse<DataLakeStoreAccount> | ArmResourceCreatedResponse<DataLakeStoreAccount> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: DataLakeStoreAccount;
    })
  >;

  /**
   * Deletes the specified Data Lake Store account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Accounts_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    DataLakeStoreAccount,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Attempts to enable a user managed Key Vault for encryption of the specified Data Lake Store account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_EnableKeyVault")
  enableKeyVault is ArmResourceActionSync<
    DataLakeStoreAccount,
    void,
    OkResponse
  >;
}

@@doc(DataLakeStoreAccount.name, "The name of the Data Lake Store account.");
@@doc(DataLakeStoreAccount.properties,
  "The Data Lake Store account properties."
);
@@doc(DataLakeStoreAccounts.create::parameters.resource,
  "Parameters supplied to create the Data Lake Store account."
);
@@doc(DataLakeStoreAccounts.update::parameters.properties,
  "Parameters supplied to update the Data Lake Store account."
);
