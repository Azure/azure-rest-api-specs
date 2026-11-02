import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace BigDataPools;

/**
 * The type of the spark config properties file.
 */
union ConfigurationType {
  string,

  /**
   * File
   */
  File: "File",

  /**
   * Artifact
   */
  Artifact: "Artifact",
}

/**
 * The level of compute power that each node in the Big Data pool has.
 */
union NodeSize {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Small
   */
  Small: "Small",

  /**
   * Medium
   */
  Medium: "Medium",

  /**
   * Large
   */
  Large: "Large",

  /**
   * XLarge
   */
  XLarge: "XLarge",

  /**
   * XXLarge
   */
  XXLarge: "XXLarge",

  /**
   * XXXLarge
   */
  XXXLarge: "XXXLarge",
}

/**
 * The kind of nodes that the Big Data pool provides.
 */
union NodeSizeFamily {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * MemoryOptimized
   */
  MemoryOptimized: "MemoryOptimized",

  /**
   * HardwareAcceleratedFPGA
   */
  HardwareAcceleratedFPGA: "HardwareAcceleratedFPGA",

  /**
   * HardwareAcceleratedGPU
   */
  HardwareAcceleratedGPU: "HardwareAcceleratedGPU",
}

/**
 * Properties of a Big Data pool powered by Apache Spark
 */
model BigDataPoolResourceProperties {
  /**
   * The state of the Big Data pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  provisioningState?: string;

  /**
   * Auto-scaling properties
   */
  autoScale?: AutoScaleProperties;

  /**
   * The time when the Big Data pool was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * Auto-pausing properties
   */
  autoPause?: AutoPauseProperties;

  /**
   * Whether compute isolation is required or not.
   */
  isComputeIsolationEnabled?: boolean;

  /**
   * Whether autotune is required or not.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isAutotuneEnabled?: boolean;

  /**
   * Whether session level packages enabled.
   */
  sessionLevelPackagesEnabled?: boolean;

  /**
   * The cache size
   */
  cacheSize?: int32;

  /**
   * Dynamic Executor Allocation
   */
  dynamicExecutorAllocation?: DynamicExecutorAllocation;

  /**
   * The Spark events folder
   */
  sparkEventsFolder?: string;

  /**
   * The number of nodes in the Big Data pool.
   */
  nodeCount?: int32;

  /**
   * Library version requirements
   */
  libraryRequirements?: LibraryRequirements;

  /**
   * List of custom libraries/packages associated with the spark pool.
   */
  @identifiers(#[])
  customLibraries?: LibraryInfo[];

  /**
   * Spark configuration file to specify additional properties
   */
  sparkConfigProperties?: SparkConfigProperties;

  /**
   * The Apache Spark version.
   */
  sparkVersion?: string;

  /**
   * The default folder where Spark logs will be written.
   */
  defaultSparkLogFolder?: string;

  /**
   * The level of compute power that each node in the Big Data pool has.
   */
  nodeSize?: NodeSize;

  /**
   * The kind of nodes that the Big Data pool provides.
   */
  nodeSizeFamily?: NodeSizeFamily;

  /**
   * The time when the Big Data pool was updated successfully.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSucceededTimestamp?: utcDateTime;
}

/**
 * Auto-scaling properties of a Big Data pool powered by Apache Spark
 */
model AutoScaleProperties {
  /**
   * The minimum number of nodes the Big Data pool can support.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  minNodeCount?: int32;

  /**
   * Whether automatic scaling is enabled for the Big Data pool.
   */
  enabled?: boolean;

  /**
   * The maximum number of nodes the Big Data pool can support.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  maxNodeCount?: int32;
}

/**
 * Auto-pausing properties of a Big Data pool powered by Apache Spark
 */
model AutoPauseProperties {
  /**
   * Number of minutes of idle time before the Big Data pool is automatically paused.
   */
  delayInMinutes?: int32;

  /**
   * Whether auto-pausing is enabled for the Big Data pool.
   */
  enabled?: boolean;
}

/**
 * Dynamic Executor Allocation Properties
 */
model DynamicExecutorAllocation {
  /**
   * Indicates whether Dynamic Executor Allocation is enabled or not.
   */
  enabled?: boolean;

  /**
   * The minimum number of executors alloted
   */
  minExecutors?: int32;

  /**
   * The maximum number of executors alloted
   */
  maxExecutors?: int32;
}

/**
 * Library requirements for a Big Data pool powered by Apache Spark
 */
model LibraryRequirements {
  /**
   * The last update time of the library requirements file.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  /**
   * The library requirements.
   */
  content?: string;

  /**
   * The filename of the library requirements file.
   */
  filename?: string;
}

/**
 * Library/package information of a Big Data pool powered by Apache Spark
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model LibraryInfo {
  /**
   * Name of the library.
   */
  name?: string;

  /**
   * Storage blob path of library.
   */
  path?: string;

  /**
   * Storage blob container name.
   */
  containerName?: string;

  /**
   * The last update time of the library.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  uploadedTimestamp?: utcDateTime;

  /**
   * Type of the library.
   */
  type?: string;

  /**
   * Provisioning status of the library/package.
   */
  @visibility(Lifecycle.Read)
  provisioningStatus?: string;

  /**
   * Creator Id of the library/package.
   */
  @visibility(Lifecycle.Read)
  creatorId?: string;
}

/**
 * SparkConfig Properties for a Big Data pool powered by Apache Spark
 */
model SparkConfigProperties {
  /**
   * The last update time of the spark config properties file.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  /**
   * The spark config properties.
   */
  content?: string;

  /**
   * The filename of the spark config properties file.
   */
  filename?: string;

  /**
   * The type of the spark config properties file.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  configurationType?: ConfigurationType;
}

/**
 * Properties patch for a Big Data pool
 */
model BigDataPoolPatchInfo {
  /**
   * Updated tags for the Big Data pool
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Azure Synapse nested resource, which belongs to a workspace.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SubResource extends AzureEntityResource {}

/**
 * A list of Library resources.
 */
model LibraryListResponse {
  /**
   * List of Library.
   */
  @pageItems
  value: LibraryResource[];

  /**
   * The link to the next page of results, if any remaining results exist.
   */
  @nextLink
  nextLink?: string;
}

/**
 * SparkConfiguration Artifact information
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SparkConfigurationInfo {
  /**
   * Description about the SparkConfiguration.
   */
  description?: string;

  /**
   * SparkConfiguration configs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  configs: Record<string>;

  /**
   * Annotations for SparkConfiguration.
   */
  annotations?: string[];

  /**
   * additional Notes.
   */
  notes?: string;

  /**
   * The identity that created the resource.
   */
  createdBy?: string;

  /**
   * The timestamp of resource creation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * SparkConfiguration merge configs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  configMergeRule?: Record<string>;
}

/**
 * A list of SparkConfiguration resources.
 */
model SparkConfigurationListResponse {
  /**
   * List of SparkConfiguration.
   */
  @pageItems
  value: SparkConfigurationResource[];

  /**
   * The link to the next page of results, if any remaining results exist.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Collection of Big Data pool information
 */
model BigDataPoolResourceInfoListResult {
  /**
   * List of Big Data pools
   */
  @pageItems
  value?: BigDataPoolResourceInfo[];

  /**
   * Link to the next page of results
   */
  @nextLink
  nextLink?: string;
}
