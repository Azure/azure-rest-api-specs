import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Azure SQL Database ledger digest upload settings.
 */
@parentResource(Database)
model LedgerDigestUploads
  is Azure.ResourceManager.ProxyResource<LedgerDigestUploadsProperties> {
  ...ResourceNameParameter<
    Resource = LedgerDigestUploads,
    KeyName = "ledgerDigestUploads",
    SegmentName = "ledgerDigestUploads",
    NamePattern = "",
    Type = LedgerDigestUploadsName
  >;
}

@armResourceOperations
interface LedgerDigestUploadsOperationGroup {
  /**
   * Gets the current ledger digest upload configuration for a database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LedgerDigestUploads_Get")
  get is ArmResourceRead<LedgerDigestUploads>;

  /**
   * Enables upload ledger digests to an Azure Storage account or an Azure Confidential Ledger instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("LedgerDigestUploads_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LedgerDigestUploads,
    Response = ArmResourceUpdatedResponse<LedgerDigestUploads> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = LedgerDigestUploads> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets all ledger digest upload settings on a database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LedgerDigestUploads_ListByDatabase")
  listByDatabase is ArmResourceListByParent<LedgerDigestUploads>;

  /**
   * Disables uploading ledger digests to an Azure Storage account or an Azure Confidential Ledger instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LedgerDigestUploads_Disable")
  disable is ArmResourceActionAsync<
    LedgerDigestUploads,
    void,
    ArmResponse<LedgerDigestUploads>
  >;
}

@@doc(LedgerDigestUploads.name, "");
@@doc(LedgerDigestUploads.properties, "Resource properties.");
@@doc(LedgerDigestUploadsOperationGroup.createOrUpdate::parameters.resource,
  ""
);
