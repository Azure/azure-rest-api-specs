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
@doc("ClusterMetricsConfiguration represents the metrics configuration of an on-premises Network Cloud cluster.")
@parentResource(Cluster)
model ClusterMetricsConfiguration
  is TrackedResource<ClusterMetricsConfigurationProperties> {
  @doc("The name of the metrics configuration for the cluster.")
  @pattern("^default$")
  @path
  @key("metricsConfigurationName")
  @segment("metricsConfigurations")
  name: string;

  @doc("The extended location of the cluster associated with the resource.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface ClusterMetricsConfigurations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get metrics configuration of the provided cluster.")
  @operationId("MetricsConfigurations_Get")
  get is ArmResourceRead<ClusterMetricsConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create new or update the existing metrics configuration of the provided cluster.")
  @operationId("MetricsConfigurations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ClusterMetricsConfiguration,
    BaseParameters<ClusterMetricsConfiguration>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Patch properties of metrics configuration for the provided cluster, or update the tags associated with it. Properties and tag updates can be done independently.")
  @operationId("MetricsConfigurations_Update")
  update is ArmCustomPatchAsync<
    ClusterMetricsConfiguration,
    ClusterMetricsConfigurationPatchParameters,
    BaseParameters<ClusterMetricsConfiguration>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the metrics configuration of the provided cluster.")
  @operationId("MetricsConfigurations_Delete")
  delete is ArmResourceDeleteAsync<
    ClusterMetricsConfiguration,
    BaseParameters<ClusterMetricsConfiguration>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a list of metrics configurations for the provided cluster.")
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
