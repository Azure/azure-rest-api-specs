using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Private;
using TypeSpec.Versioning;

namespace Microsoft.Workloads;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-12-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_12_01_preview: "2023-12-01-preview",

  /**
   * The 2024-02-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_02_01_preview: "2024-02-01-preview",
}

/**
 * State of provisioning of the SAP monitor.
 */
union ProvisioningState {
  string,

  /** The resource request has been accepted. */
  Accepted: "Accepted",

  /** The resource is being created. */
  Creating: "Creating",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource creation failed. */
  Failed: "Failed",

  /** The resource creation has succeeded. */
  Succeeded: "Succeeded",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  /** The resource is being migrated. */
  Migrating: "Migrating",

  /** The resource operation was canceled. */
  Canceled: "Canceled",
}

/**
 * The Provider Types for Monitor.
 */
union ProviderType {
  string,

  /** SapHana Provider. */
  SapHana: "SapHana",

  /** SapNetWeaver Provider. */
  SapNetWeaver: "SapNetWeaver",

  /** PrometheusOS Provider. */
  PrometheusOS: "PrometheusOS",

  /** MsSqlServer Provider. */
  MsSqlServer: "MsSqlServer",

  /** PrometheusHaCluster Provider. */
  PrometheusHaCluster: "PrometheusHaCluster",

  /** Db2 Provider. */
  Db2: "Db2",

  /** Oracle Provider. */
  @added(Versions.v2024_02_01_preview)
  Oracle: "Oracle",
}
