import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Relay;

/**
 * Name of the Relay cluster SKU.
 */
@added(Versions.v2026_07_01_preview)
union RelayClusterSkuName {
  string,

  /** The dedicated Relay cluster SKU. */
  Dedicated: "Dedicated",
}

/**
 * Tier of the Relay cluster SKU.
 */
@added(Versions.v2026_07_01_preview)
union RelayClusterSkuTier {
  string,

  /** The dedicated Relay cluster SKU tier. */
  Dedicated: "Dedicated",
}

/**
 * Scaling mode supported by a Relay cluster SKU.
 */
@added(Versions.v2026_07_01_preview)
union RelayClusterSkuScaleType {
  string,

  /** Capacity can be scaled automatically. */
  Automatic: "Automatic",
}

/**
 * Provisioning state of a Relay cluster.
 */
@added(Versions.v2026_07_01_preview)
union RelayClusterProvisioningState {
  Azure.ResourceManager.ResourceProvisioningState,

  /** The cluster is being created. */
  Creating: "Creating",

  /** The cluster is being deleted. */
  Deleting: "Deleting",

  /** The cluster is being scaled. */
  Scaling: "Scaling",
}

/**
 * SKU parameters for a Relay cluster.
 */
@added(Versions.v2026_07_01_preview)
model RelayClusterSku {
  /**
   * Name of the Relay cluster SKU.
   */
  name: RelayClusterSkuName;

  /**
   * Tier of the Relay cluster SKU.
   */
  tier?: RelayClusterSkuTier;

  /**
   * The number of capacity units assigned to the Relay cluster.
   */
  @minValue(1)
  capacity?: int32;
}

/**
 * Relay cluster properties.
 */
@added(Versions.v2026_07_01_preview)
model RelayClusterProperties {
  /**
   * The provisioning state of the Relay cluster.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: RelayClusterProvisioningState;

  /**
   * The metric ID of the Relay cluster.
   */
  @visibility(Lifecycle.Read)
  metricId?: string;

  /**
   * The status of the Relay cluster.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Indicates whether the Relay cluster supports capacity scaling.
   */
  @visibility(Lifecycle.Read)
  supportsScaling?: boolean;

  /**
   * Indicates whether the Relay cluster was created as zone redundant.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  zoneRedundant?: boolean;
}

/**
 * Mutable Relay cluster SKU parameters.
 */
@added(Versions.v2026_07_01_preview)
model RelayClusterSkuUpdate {
  /**
   * Name of the Relay cluster SKU.
   */
  name?: RelayClusterSkuName;

  /**
   * Tier of the Relay cluster SKU.
   */
  tier?: RelayClusterSkuTier;

  /**
   * The number of capacity units assigned to the Relay cluster.
   */
  @minValue(1)
  capacity?: int32;
}

/**
 * Parameters for updating a Relay cluster.
 */
@added(Versions.v2026_07_01_preview)
model RelayClusterUpdate {
  /**
   * The Relay cluster SKU.
   */
  sku?: RelayClusterSkuUpdate;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}

/**
 * A Relay dedicated cluster.
 */
@added(Versions.v2026_07_01_preview)
model RelayCluster
  is Azure.ResourceManager.TrackedResource<RelayClusterProperties> {
  ...ResourceNameParameter<
    Resource = RelayCluster,
    KeyName = "clusterName",
    SegmentName = "clusters",
    NamePattern = "^(?!.*--)[a-zA-Z][a-zA-Z0-9-]{4,48}[a-zA-Z0-9]$"
  >;

  /**
   * The Relay cluster SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The Relay service implements the established Event Hubs cluster envelope with the SKU outside properties."
  sku: RelayClusterSku;
}

/**
 * The response from listing Relay namespace references in a cluster.
 */
@added(Versions.v2026_07_01_preview)
model RelayNamespaceIdListResult {
  /**
   * Relay namespace references assigned to the cluster.
   */
  value: RelayNamespaceReference[];
}

/**
 * A reference to a Relay namespace assigned to a cluster.
 */
@added(Versions.v2026_07_01_preview)
model RelayNamespaceReference {
  /**
   * The full Azure resource ID of the Relay namespace.
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Relay/namespaces";
    }
  ]>;
}

/**
 * The response from listing regions that have available Relay cluster capacity.
 */
@added(Versions.v2026_07_01_preview)
model AvailableRelayClustersList {
  /**
   * Regions containing available Relay cluster capacity.
   */
  @identifiers(#["location"])
  value: AvailableRelayClusterRegion[];
}

/**
 * A region with available Relay cluster capacity.
 */
@added(Versions.v2026_07_01_preview)
model AvailableRelayClusterRegion {
  /**
   * The Azure region location.
   */
  @visibility(Lifecycle.Read)
  location?: string;
}

/**
 * The response from listing supported SKUs for a Relay cluster.
 */
@added(Versions.v2026_07_01_preview)
model RelayClusterSkuListResult {
  /**
   * The SKUs supported by the Relay cluster.
   */
  @identifiers(#["resourceType"])
  value: RelayClusterSkuInfo[];
}

/**
 * A SKU supported by a Relay cluster.
 */
@added(Versions.v2026_07_01_preview)
model RelayClusterSkuInfo {
  /**
   * The resource type to which the SKU applies.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The SKU name and tier.
   */
  @visibility(Lifecycle.Read)
  sku?: RelayClusterSkuDetails;

  /**
   * Capacity information for the SKU.
   */
  @visibility(Lifecycle.Read)
  capacity?: RelayClusterSkuCapacity;
}

/**
 * Relay cluster SKU name and tier.
 */
@added(Versions.v2026_07_01_preview)
model RelayClusterSkuDetails {
  /**
   * The SKU name.
   */
  @visibility(Lifecycle.Read)
  name?: RelayClusterSkuName;

  /**
   * The SKU tier.
   */
  @visibility(Lifecycle.Read)
  tier?: RelayClusterSkuTier;
}

/**
 * Relay cluster SKU capacity information.
 */
@added(Versions.v2026_07_01_preview)
model RelayClusterSkuCapacity {
  /**
   * The minimum supported capacity.
   */
  @visibility(Lifecycle.Read)
  minimum?: int32;

  /**
   * The maximum supported capacity.
   */
  @visibility(Lifecycle.Read)
  maximum?: int32;

  /**
   * The allowed capacity values.
   */
  @visibility(Lifecycle.Read)
  allowedValues?: int32[];

  /**
   * The default capacity.
   */
  @visibility(Lifecycle.Read)
  default?: int32;

  /**
   * The supported scaling mode.
   */
  @visibility(Lifecycle.Read)
  scaleType?: RelayClusterSkuScaleType;
}

@added(Versions.v2026_07_01_preview)
@armResourceOperations
interface Clusters {
  /**
   * Gets a Relay cluster.
   */
  get is ArmResourceRead<
    RelayCluster,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Creates or updates a Relay cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    RelayCluster,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Updates mutable properties of a Relay cluster.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    RelayCluster,
    PatchModel = RelayClusterUpdate,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Deletes a Relay cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    RelayCluster,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Lists Relay clusters in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    RelayCluster,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Lists Relay clusters in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    RelayCluster,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Lists Relay namespace resource IDs assigned to a Relay cluster.
   */
  @get
  @action("namespaces")
  listNamespaces is ArmResourceActionSync<
    RelayCluster,
    void,
    ArmResponse<RelayNamespaceIdListResult>,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Lists SKUs supported by a Relay cluster.
   */
  @get
  @action("skus")
  listSkus is ArmResourceActionSync<
    RelayCluster,
    void,
    ArmResponse<RelayClusterSkuListResult>,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;
}

@@maxLength(RelayCluster.name, 50);
@@minLength(RelayCluster.name, 6);
@@doc(RelayCluster.name, "The name of the Relay cluster.");
@@doc(
  Clusters.createOrUpdate::parameters.resource,
  "Parameters for creating or updating a Relay cluster."
);
@@doc(
  Clusters.update::parameters.properties,
  "The Relay cluster properties to update."
);
