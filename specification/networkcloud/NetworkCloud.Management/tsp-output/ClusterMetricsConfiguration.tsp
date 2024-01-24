import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
/**
 * ClusterMetricsConfiguration represents the metrics configuration of an on-premises Network Cloud cluster.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Cluster)
@Azure.ResourceManager.Private.armResourceInternal(
  ClusterMetricsConfigurationProperties
)
@includeInapplicableMetadataInPayload(false)
model ClusterMetricsConfiguration extends TrackedResourceBase {
  /**
   * The name of the metrics configuration for the cluster.
   */
  @pattern("^default$")
  @path
  @key("metricsConfigurationName")
  @segment("metricsConfigurations")
  name: string;

  /**
   * The extended location of the cluster associated with the resource.
   */
  extendedLocation: ExtendedLocation;

  /**
   * The list of the resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: ClusterMetricsConfigurationProperties;
}

@armResourceOperations
interface ClusterMetricsConfigurations {
  /**
   * Get metrics configuration of the provided cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MetricsConfigurations_Get")
  get is ArmResourceRead<ClusterMetricsConfiguration>;

  /**
   * Create new or update the existing metrics configuration of the provided cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MetricsConfigurations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ClusterMetricsConfiguration,
    BaseParameters<ClusterMetricsConfiguration>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patch properties of metrics configuration for the provided cluster, or update the tags associated with it. Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("MetricsConfigurations_Update")
  update is ArmCustomPatchAsync<
    ClusterMetricsConfiguration,
    ClusterMetricsConfigurationPatchParameters,
    BaseParameters<ClusterMetricsConfiguration>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete the metrics configuration of the provided cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MetricsConfigurations_Delete")
  delete is ArmResourceDeleteAsync<
    ClusterMetricsConfiguration,
    BaseParameters<ClusterMetricsConfiguration>,
    ArmLroLocationHeader
  >;

  /**
   * Get a list of metrics configurations for the provided cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MetricsConfigurations_ListByCluster")
  listByCluster is ArmResourceListByParent<ClusterMetricsConfiguration>;
}

@@projectedName(ClusterMetricsConfigurations.createOrUpdate::parameters.resource,
  "json",
  "metricsConfigurationParameters"
);
@@extension(ClusterMetricsConfigurations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "metricsConfigurationParameters"
);
@@doc(ClusterMetricsConfigurations.createOrUpdate::parameters.resource,
  "The request body."
);
@@projectedName(ClusterMetricsConfigurations.update::parameters.properties,
  "json",
  "metricsConfigurationUpdateParameters"
);
@@extension(ClusterMetricsConfigurations.update::parameters.properties,
  "x-ms-client-name",
  "metricsConfigurationUpdateParameters"
);
@@doc(ClusterMetricsConfigurations.update::parameters.properties,
  "The request body."
);
