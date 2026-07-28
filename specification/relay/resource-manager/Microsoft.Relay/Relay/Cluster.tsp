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
 * Provisioning state of a Relay cluster.
 */
@added(Versions.v2026_07_01_preview)
union RelayClusterProvisioningState {
  string,

  /** The provisioning state is unknown. */
  Unknown: "Unknown",

  /** The cluster is being created. */
  Creating: "Creating",

  /** The cluster is being deleted. */
  Deleting: "Deleting",

  /** The cluster is being scaled. */
  Scaling: "Scaling",

  /** The cluster is active. */
  Active: "Active",

  /** The cluster operation failed. */
  Failed: "Failed",

  /** The cluster operation succeeded. */
  Succeeded: "Succeeded",

  /** The cluster operation was canceled. */
  Canceled: "Canceled",
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
   * The UTC time when the Relay cluster was created.
   */
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  /**
   * The provisioning state of the Relay cluster.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: RelayClusterProvisioningState;

  /**
   * The UTC time when the Relay cluster was last updated.
   */
  @visibility(Lifecycle.Read)
  updatedAt?: utcDateTime;

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
   * Indicates whether the Relay cluster is zone redundant.
   */
  zoneRedundant?: boolean;
}

/**
 * A Relay dedicated cluster.
 */
@added(Versions.v2026_07_01_preview)
model RelayCluster
  is Azure.ResourceManager.ProxyResource<RelayClusterProperties> {
  ...ResourceNameParameter<
    Resource = RelayCluster,
    KeyName = "clusterName",
    SegmentName = "clusters",
    NamePattern = ""
  >;

  /**
   * The Relay cluster SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The Relay service implements the established Event Hubs cluster envelope with the SKU outside properties."
  sku?: RelayClusterSku;

  /**
   * The Azure region where the Relay cluster is located.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The Relay service implements the established Event Hubs cluster envelope with location on the resource."
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The Relay cluster wire contract uses a string dictionary for tags."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The Relay service implements the established Event Hubs cluster envelope with tags on the resource."
  tags?: Record<string>;
}

/**
 * The response from listing Relay namespace resource IDs in a cluster.
 */
@added(Versions.v2026_07_01_preview)
model RelayNamespaceIdListResult {
  /**
   * Relay namespace resource IDs assigned to the cluster.
   */
  @Azure.ResourceManager.identifiers(#["id"])
  value?: RelayNamespaceId[];
}

/**
 * A Relay namespace resource ID.
 */
@added(Versions.v2026_07_01_preview)
model RelayNamespaceId {
  /**
   * The full ARM resource ID of the Relay namespace.
   */
  id?: string;
}

/**
 * The response from listing regions that have pre-provisioned Relay clusters.
 */
@added(Versions.v2026_07_01_preview)
model AvailableRelayClustersList {
  /**
   * Regions containing available pre-provisioned Relay clusters.
   */
  @Azure.ResourceManager.identifiers(#["location"])
  value?: AvailableRelayCluster[];
}

/**
 * A region containing an available pre-provisioned Relay cluster.
 */
@added(Versions.v2026_07_01_preview)
model AvailableRelayCluster {
  /**
   * The Azure region of the available Relay cluster.
   */
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
  @Azure.ResourceManager.identifiers(#[
    "resourceType",
    "/sku/name",
    "/sku/tier"
  ])
  value?: RelayClusterSkuInfo[];
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
  tier?: RelayClusterSkuName;
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
  scaleType?: string;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The response codes match the implemented Relay cluster contract."
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    RelayCluster,
    Response =
      | ArmResourceUpdatedResponse<RelayCluster>
      | ArmResourceCreatedResponse<RelayCluster>
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = RelayCluster> &
          Azure.Core.Foundations.RetryAfterHeader>,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Updates mutable properties of a Relay cluster.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    RelayCluster,
    PatchModel = RelayCluster,
    Response =
      | ArmResponse<RelayCluster>
      | ArmResourceCreatedResponse<RelayCluster>
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = RelayCluster> &
          Azure.Core.Foundations.RetryAfterHeader>,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Deletes a Relay cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "The response codes match the implemented Relay cluster contract."
  delete is ArmResourceDeleteWithoutOkAsync<
    RelayCluster,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse,
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
