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

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface LedgerDigestUploadsOperationGroup {
  /**
   * Gets the current ledger digest upload configuration for a database.
   */
  @tag("LedgerDigestUploads")
  get is ArmResourceRead<LedgerDigestUploads>;

  /**
   * Enables upload ledger digests to an Azure Storage account or an Azure Confidential Ledger instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("LedgerDigestUploads")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LedgerDigestUploads,
    Response = ArmResourceUpdatedResponse<LedgerDigestUploads> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = LedgerDigestUploads> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Gets all ledger digest upload settings on a database.
   */
  @tag("LedgerDigestUploads")
  listByDatabase is ArmResourceListByParent<LedgerDigestUploads>;

  /**
   * Disables uploading ledger digests to an Azure Storage account or an Azure Confidential Ledger instance.
   */
  @tag("LedgerDigestUploads")
  disable is ArmResourceActionAsync<
    LedgerDigestUploads,
    void,
    Response = LedgerDigestUploads
  >;
}

@@doc(LedgerDigestUploads.name, "");
@@doc(LedgerDigestUploads.properties, "Resource properties.");
@@doc(LedgerDigestUploadsOperationGroup.createOrUpdate::parameters.resource,
  ""
);
