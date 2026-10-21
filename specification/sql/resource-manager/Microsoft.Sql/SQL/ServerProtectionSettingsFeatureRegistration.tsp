import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.SqlFeatureRegistration;

/** Generator-only feature registration, outside the public SQL service namespace. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "The legacy feature registry requires enum members; this enum is not an API schema."
enum Features {
  ...Microsoft.Sql.Features,

  /** Read, list, and update the singleton logical server protection settings. */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The project uses legacy-feature-files output splitting."
  @Azure.ResourceManager.Legacy.featureOptions(#{
    featureName: "ServerProtectionSettings",
    fileName: "ServerProtectionSettings",
    description: "Read and update logical server protection settings for retained immutable backups.",
  })
  ServerProtectionSettings,

  /** Read, list, and update the singleton managed instance protection settings. */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The project uses legacy-feature-files output splitting; preserve the requested server protection settings specification filename."
  @Azure.ResourceManager.Legacy.featureOptions(#{
    featureName: "ManagedInstanceServerProtectionSettings",
    fileName: "ManagedInstanceServerProtectionSettings",
    description: "Read and update managed instance protection settings for retained immutable backups.",
  })
  ManagedInstanceServerProtectionSettings,
}
