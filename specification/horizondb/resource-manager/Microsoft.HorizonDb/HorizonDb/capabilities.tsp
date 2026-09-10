import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@added(Versions.v2026_10_01_preview)
@doc("The availability status of a HorizonDB capability.")
union CapabilityStatus {
  string,

  /** The capability is available. */
  Available: "Available",

  /** The capability is available and selected by default. */
  Default: "Default",
}

@added(Versions.v2026_10_01_preview)
@doc("A PostgreSQL major version advertised by the HorizonDB capabilities API.")
union PostgreSqlCapabilityVersion {
  string,

  /** PostgreSQL major version 17. */
  V17: "17",

  /** PostgreSQL major version 18. */
  V18: "18",
}

@added(Versions.v2026_10_01_preview)
@doc("A vCore configuration supported by a HorizonDB processor generation.")
model ComputeSizeCapability {
  @doc("The availability status of the vCore configuration.")
  @visibility(Lifecycle.Read)
  status: CapabilityStatus;

  @doc("The number of vCores in the configuration.")
  @visibility(Lifecycle.Read)
  vCores: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "memoryPerVCoreInMb preserves the HorizonDB VCore terminology in the public wire contract."
  @doc("The memory in megabytes available for each vCore.")
  @visibility(Lifecycle.Read)
  memoryPerVCoreInMb: int64;
}

@added(Versions.v2026_10_01_preview)
@doc("The capabilities of a HorizonDB compute model.")
@discriminator("type")
model ComputeModelCapability {
  @doc("The compute model represented by these capabilities.")
  @visibility(Lifecycle.Read)
  type: PoolComputeModelType;

  @doc("The availability status of the compute model.")
  @visibility(Lifecycle.Read)
  status: CapabilityStatus;
}

@added(Versions.v2026_10_01_preview)
@doc("The capabilities of the Provisioned compute model.")
model ProvisionedComputeModelCapability extends ComputeModelCapability {
  @doc("The compute model represented by these capabilities.")
  type: "Provisioned";

  #suppress "@azure-tools/typespec-azure-core/casing-style" "defaultVCoreCount preserves the HorizonDB VCore terminology in the public wire contract."
  @doc("The default number of provisioned vCores.")
  @visibility(Lifecycle.Read)
  defaultVCoreCount: int32;

  @doc("The supported provisioned compute sizes.")
  @visibility(Lifecycle.Read)
  @identifiers(#["vCores"])
  supportedComputeSizes: ComputeSizeCapability[];
}

@added(Versions.v2026_10_01_preview)
@doc("The capabilities of a HorizonDB compute generation.")
model ComputeGenerationCapability {
  @doc("The numeric compute generation used when configuring a HorizonDB pool.")
  @visibility(Lifecycle.Read)
  computeGeneration: int32;

  @doc("The availability status of the compute generation.")
  @visibility(Lifecycle.Read)
  status: CapabilityStatus;

  @doc("The compute models supported by the compute generation.")
  @visibility(Lifecycle.Read)
  @identifiers(#["type"])
  supportedComputeModels: ComputeModelCapability[];
}

@added(Versions.v2026_10_01_preview)
@doc("The capabilities of a processor family supported by HorizonDB.")
model ComputeProcessorCapability {
  @doc("The name of the processor family.")
  @visibility(Lifecycle.Read)
  name: ComputeProcessorType;

  @doc("The availability status of the processor family.")
  @visibility(Lifecycle.Read)
  status: CapabilityStatus;

  @doc("The compute generations supported by the processor family.")
  @visibility(Lifecycle.Read)
  @identifiers(#["computeGeneration"])
  supportedGenerations: ComputeGenerationCapability[];
}

@added(Versions.v2026_10_01_preview)
@doc("The capabilities of a PostgreSQL major version supported by HorizonDB.")
model PostgreSqlVersionCapability {
  @doc("The PostgreSQL major version.")
  @visibility(Lifecycle.Read)
  name: PostgreSqlCapabilityVersion;

  @doc("The availability status of the PostgreSQL major version.")
  @visibility(Lifecycle.Read)
  status: CapabilityStatus;

  @doc("The PostgreSQL major versions to which this version can be upgraded in place. API version 2026-10-01-preview does not support in-place PostgreSQL major-version upgrades, so this array is always empty.")
  @visibility(Lifecycle.Read)
  supportedVersionsToUpgrade: PostgreSqlCapabilityVersion[];
}

@added(Versions.v2026_10_01_preview)
@doc("A HorizonDB Cluster feature supported in a location.")
model ClusterFeatureCapability {
  @doc("The name of the Cluster feature.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The availability status of the Cluster feature.")
  @visibility(Lifecycle.Read)
  status: CapabilityStatus;
}

@added(Versions.v2026_10_01_preview)
@doc("The HorizonDB Cluster capabilities available in a location.")
model ClusterCapability {
  @doc("The availability status of HorizonDB Clusters in the region.")
  @visibility(Lifecycle.Read)
  status: CapabilityStatus;

  @doc("The PostgreSQL major versions supported by Clusters in the region.")
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedPostgreSqlVersions: PostgreSqlVersionCapability[];

  @doc("Additional Cluster features supported in the region.")
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedFeatures: ClusterFeatureCapability[];
}

@added(Versions.v2026_10_01_preview)
@doc("A HorizonDB Pool feature supported in a location.")
model PoolFeatureCapability {
  @doc("The name of the Pool feature.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The availability status of the Pool feature.")
  @visibility(Lifecycle.Read)
  status: CapabilityStatus;
}

@added(Versions.v2026_10_01_preview)
@doc("The HorizonDB Pool capabilities available in a location.")
model PoolCapability {
  @doc("The availability status of HorizonDB Pools in the region.")
  @visibility(Lifecycle.Read)
  status: CapabilityStatus;

  @doc("The processor families and their compute capabilities supported by Pools in the region.")
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedProcessors: ComputeProcessorCapability[];

  @doc("Additional Pool features supported in the region independently of a processor, generation, or compute model.")
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedFeatures: PoolFeatureCapability[];
}

@added(Versions.v2026_10_01_preview)
@doc("The HorizonDB capabilities available to a subscription in a location.")
model LocationCapability {
  @doc("The Azure region represented by this capability entry.")
  @visibility(Lifecycle.Read)
  location: azureLocation;

  @doc("The availability status of HorizonDB in the region.")
  @visibility(Lifecycle.Read)
  status: CapabilityStatus;

  @doc("The Cluster capabilities available in the region.")
  @visibility(Lifecycle.Read)
  clusterCapabilities: ClusterCapability;

  @doc("The Pool capabilities available in the region, including processor, generation, and compute-model details.")
  @visibility(Lifecycle.Read)
  poolCapabilities: PoolCapability;
}

@added(Versions.v2026_10_01_preview)
@doc("A page of HorizonDB location capabilities.")
model PagedLocationCapability {
  @doc("The location capability items on this page.")
  @pageItems
  @identifiers(#["location"])
  value: LocationCapability[];

  @doc("The link to the next page of items.")
  @nextLink
  nextLink?: url;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This is a custom non-resource subscription-level discovery operation with an explicit route and parameters."
@added(Versions.v2026_10_01_preview)
@route("/subscriptions/{subscriptionId}/providers/Microsoft.HorizonDb/locations/{location}/capabilities")
interface Capabilities {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "This subscription-location discovery operation returns capability metadata rather than ARM resources."
  #suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "This subscription-location discovery operation returns capability metadata rather than ARM resources, so no ARM resource operation decorator applies."
  @added(Versions.v2026_10_01_preview)
  @doc("Lists HorizonDB capabilities available to a subscription in a specific region.")
  @get
  @list
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,
  ): ArmResponse<PagedLocationCapability> | ErrorResponse;
}
