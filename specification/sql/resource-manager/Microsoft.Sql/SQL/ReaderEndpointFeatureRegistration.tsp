import "@azure-tools/typespec-azure-resource-manager";
import "./RestoreFromDroppedManagedInstanceFeatureRegistration.tsp";

namespace Microsoft.SqlFeatureRegistration;

/** Generator-only feature registration, outside the public SQL service namespace. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "The legacy feature registry requires enum members; this enum is not an API schema."
enum ReaderEndpointFeatures {
  ...Microsoft.SqlFeatureRegistration.RestoreFromDroppedManagedInstanceFeatures,

  /** Reader endpoints under a logical server. */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserves the source Swagger operation-group filename."
  @Azure.ResourceManager.Legacy.featureOptions(#{
    featureName: "ReaderEndpoints",
    fileName: "ReaderEndpoints",
    description: "Manage reader endpoints under a logical server.",
  })
  ReaderEndpoints,

  /** Reader endpoints associated with a primary database. */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserves the source Swagger operation-group filename."
  @Azure.ResourceManager.Legacy.featureOptions(#{
    featureName: "ReaderEndpointsList",
    fileName: "ReaderEndpointsList",
    description: "List reader endpoints for a primary database.",
  })
  ReaderEndpointsList,
}
