using Versioning;

namespace Microsoft.ContainerRegistry;

/**
 * The storage access mode used for the customer storage account.
 */
@added(Versions.vLatestPreview)
union StorageAccessMode {
  string,

  /** Managed Identity access mode */
  ManagedIdentity: "ManagedIdentity",

  /** SAS Token access mode */
  SasToken: "SasToken",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.vLatestPreview)
union PipelineOptions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OverwriteTags: "OverwriteTags",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OverwriteBlobs: "OverwriteBlobs",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DeleteSourceBlobOnSuccess: "DeleteSourceBlobOnSuccess",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ContinueOnErrors: "ContinueOnErrors",
}
