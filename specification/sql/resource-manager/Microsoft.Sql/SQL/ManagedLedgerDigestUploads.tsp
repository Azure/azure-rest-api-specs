import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Azure SQL Database ledger digest upload settings.
 */
@parentResource(ManagedDatabase)
model ManagedLedgerDigestUploads
  is Azure.ResourceManager.ProxyResource<ManagedLedgerDigestUploadsProperties> {
  ...ResourceNameParameter<
    Resource = ManagedLedgerDigestUploads,
    KeyName = "ledgerDigestUploads",
    SegmentName = "ledgerDigestUploads",
    NamePattern = "",
    Type = ManagedLedgerDigestUploadsName
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface ManagedLedgerDigestUploadsOperationGroup {
  /**
   * Gets the current ledger digest upload configuration for a database.
   */
  @tag("ManagedLedgerDigestUploads")
  get is ArmResourceRead<ManagedLedgerDigestUploads>;

  /**
   * Enables upload ledger digests to an Azure Storage account or an Azure Confidential Ledger instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedLedgerDigestUploads")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedLedgerDigestUploads,
    Response = ArmResourceUpdatedResponse<ManagedLedgerDigestUploads> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ManagedLedgerDigestUploads> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Gets all ledger digest upload settings on a database.
   */
  @tag("ManagedLedgerDigestUploads")
  listByDatabase is ArmResourceListByParent<ManagedLedgerDigestUploads>;

  /**
   * Disables uploading ledger digests to an Azure Storage account or an Azure Confidential Ledger instance.
   */
  @tag("ManagedLedgerDigestUploads")
  disable is ArmResourceActionAsync<
    ManagedLedgerDigestUploads,
    void,
    Response = ManagedLedgerDigestUploads
  >;
}

@@doc(ManagedLedgerDigestUploads.name, "");
@@doc(ManagedLedgerDigestUploads.properties, "Resource properties.");
@@doc(ManagedLedgerDigestUploadsOperationGroup.createOrUpdate::parameters.resource,
  "The Ledger Digest Storage Endpoint."
);
