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

@armResourceOperations
interface ManagedLedgerDigestUploadsOperationGroup {
  /**
   * Gets the current ledger digest upload configuration for a database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedLedgerDigestUploads_Get")
  get is ArmResourceRead<ManagedLedgerDigestUploads>;

  /**
   * Enables upload ledger digests to an Azure Storage account or an Azure Confidential Ledger instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ManagedLedgerDigestUploads_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedLedgerDigestUploads,
    Response = ArmResourceUpdatedResponse<ManagedLedgerDigestUploads> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ManagedLedgerDigestUploads> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets all ledger digest upload settings on a database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedLedgerDigestUploads_ListByDatabase")
  listByDatabase is ArmResourceListByParent<ManagedLedgerDigestUploads>;

  /**
   * Disables uploading ledger digests to an Azure Storage account or an Azure Confidential Ledger instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedLedgerDigestUploads_Disable")
  disable is ArmResourceActionAsync<
    ManagedLedgerDigestUploads,
    void,
    ArmResponse<ManagedLedgerDigestUploads>
  >;
}

@@doc(ManagedLedgerDigestUploads.name, "");
@@doc(ManagedLedgerDigestUploads.properties, "Resource properties.");
@@doc(ManagedLedgerDigestUploadsOperationGroup.createOrUpdate::parameters.resource,
  "The Ledger Digest Storage Endpoint."
);
