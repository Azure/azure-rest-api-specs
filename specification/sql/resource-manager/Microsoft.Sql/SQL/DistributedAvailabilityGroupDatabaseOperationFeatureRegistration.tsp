import "@azure-tools/typespec-azure-resource-manager";
import "./ReaderEndpointFeatureRegistration.tsp";

namespace Microsoft.SqlFeatureRegistration;

/** Generator-only feature registration, outside the public SQL service namespace. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "The legacy feature registry requires enum members; this enum is not an API schema."
enum DistributedAvailabilityGroupDatabaseOperationFeatures {
  ...Microsoft.SqlFeatureRegistration.ReaderEndpointFeatures,

  /** Database operations of a distributed availability group. */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserves the source Swagger operation-group filename."
  @Azure.ResourceManager.Legacy.featureOptions(#{
    featureName: "DistributedAvailabilityGroupsDatabaseOperations",
    fileName: "distributedAvailabilityGroupsDatabaseOperations",
    description: "Read database operations of a distributed availability group.",
  })
  DistributedAvailabilityGroupsDatabaseOperations,
}
