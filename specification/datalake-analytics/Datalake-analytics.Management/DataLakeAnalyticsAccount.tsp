import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataLakeAnalytics;
/**
 * A Data Lake Analytics account object, containing all information associated with the named Data Lake Analytics account.
 */
model DataLakeAnalyticsAccount
  is Azure.ResourceManager.TrackedResource<DataLakeAnalyticsAccountProperties> {
  ...ResourceNameParameter<
    Resource = DataLakeAnalyticsAccount,
    KeyName = "accountName",
    SegmentName = "accounts",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DataLakeAnalyticsAccounts {
  /**
   * Gets details of the specified Data Lake Analytics account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_Get")
  get is ArmResourceRead<DataLakeAnalyticsAccount>;

  /**
   * Creates the specified Data Lake Analytics account. This supplies the user with computation services for Data Lake Analytics workloads.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_Create")
  create is ArmResourceCreateOrReplaceAsync<
    DataLakeAnalyticsAccount,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates the Data Lake Analytics account object specified by the accountName with the contents of the account object.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("Accounts_Update")
  update is ArmCustomPatchAsync<
    DataLakeAnalyticsAccount,
    PatchModel = UpdateDataLakeAnalyticsAccountParameters,
    Response = ArmResponse<DataLakeAnalyticsAccount> | ArmResourceCreatedResponse<DataLakeAnalyticsAccount> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: DataLakeAnalyticsAccount;
    })
  >;

  /**
   * Begins the delete process for the Data Lake Analytics account object specified by the account name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Accounts_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    DataLakeAnalyticsAccount,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;
}

@@doc(DataLakeAnalyticsAccount.name,
  "The name of the Data Lake Analytics account."
);
@@doc(DataLakeAnalyticsAccount.properties,
  "The properties defined by Data Lake Analytics all properties are specific to each resource provider."
);
@@doc(DataLakeAnalyticsAccounts.create::parameters.resource,
  "Parameters supplied to create a new Data Lake Analytics account."
);
@@doc(DataLakeAnalyticsAccounts.update::parameters.properties,
  "Parameters supplied to the update Data Lake Analytics account operation."
);
