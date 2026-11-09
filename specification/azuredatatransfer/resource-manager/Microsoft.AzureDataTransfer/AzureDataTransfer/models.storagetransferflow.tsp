import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "./models.flowcommon.tsp";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Versioning;

@versioned(Versions)
namespace Microsoft.AzureDataTransfer;

/**
 * Properties of a storage flow
 */
@added(Versions.v2026_06_29_preview)
model StorageTransferFlowProperties {
  ...CommonTransferFlowProperties;

  /**
   * ARM resource ID of the blob container or table used for this flow. The storage
   * account is derived from this ID.
   */
  storageDataResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts/blobServices/containers";
    },
    {
      type: "Microsoft.Storage/storageAccounts/tableServices/tables";
    }
  ]>;
}

/**
 * The storage transfer flow resource patch definition.
 */
@added(Versions.v2026_06_29_preview)
model StorageTransferFlowsPatch {
  ...ManagedServiceIdentityProperty;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
