import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.SqlFeatureRegistration;

/** Generator-only feature registration, outside the public SQL service namespace. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "The legacy feature registry requires enum members; this enum is not an API schema."
enum Features {
  ...Microsoft.Sql.Features,

  /** Read, list, and update the singleton managed instance protection settings. */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The project uses legacy-feature-files output splitting; preserve the requested server protection settings specification filename."
  @Azure.ResourceManager.Legacy.featureOptions(#{
    featureName: "ManagedInstanceServerProtectionSettings",
    fileName: "ManagedInstanceServerProtectionSettings",
    description: "Read and update managed instance protection settings for retained immutable backups.",
  })
  ManagedInstanceServerProtectionSettings,

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
