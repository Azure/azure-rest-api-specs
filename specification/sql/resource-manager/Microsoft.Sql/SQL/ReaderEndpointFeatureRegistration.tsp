import "@azure-tools/typespec-azure-resource-manager";
import "./ServerProtectionSettingsFeatureRegistration.tsp";

namespace Microsoft.SqlFeatureRegistration;

/** Generator-only registration for the reader endpoint specification files. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "The legacy feature registry requires enum members; this enum is not an API schema."
enum ReaderEndpointFeatures {
  ...Features,

  /** Manage reader endpoints under a server. */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The SQL project splits its specifications by legacy feature."
  @Azure.ResourceManager.Legacy.featureOptions(#{
    featureName: "ReaderEndpoints",
    fileName: "ReaderEndpoints",
    description: "Manage reader endpoints under a server.",
  })
  ReaderEndpoints,

  /** List reader endpoints associated with a primary database. */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The SQL project splits its specifications by legacy feature."
  @Azure.ResourceManager.Legacy.featureOptions(#{
    featureName: "ReaderEndpointsList",
    fileName: "ReaderEndpointsList",
    description: "List reader endpoints associated with a primary database.",
  })
  ReaderEndpointsList,
}
