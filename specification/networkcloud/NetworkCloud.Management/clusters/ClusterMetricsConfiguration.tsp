import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./Cluster.tsp";
import "./ClusterMetricsConfiguration_models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
/**
 * The name of the metrics configuration for the cluster.
 */
model ClusterMetricsConfigurationNameParameter
  is ResourceNameParameter<
    Resource = ClusterMetricsConfiguration,
    KeyName = "metricsConfigurationName",
    SegmentName = "metricsConfigurations",
    NamePattern = "^default$"
  >;

/**
 * ClusterMetricsConfiguration represents the metrics configuration of an on-premises Network Cloud cluster.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
@parentResource(Cluster)
model ClusterMetricsConfiguration
  is Azure.ResourceManager.TrackedResource<
    ClusterMetricsConfigurationProperties,
    false
  > {
  ...ClusterMetricsConfigurationNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...RequiredExtendedLocationProperty;
}

@armResourceOperations
interface ClusterMetricsConfigurations {
  /**
   * Get metrics configuration of the provided cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricsConfigurations_Get")
  get is ArmResourceRead<ClusterMetricsConfiguration>;

  /**
   * Create new or update the existing metrics configuration of the provided cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricsConfigurations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ClusterMetricsConfiguration,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ClusterMetricsConfiguration>
  >;

  /**
   * Patch properties of metrics configuration for the provided cluster, or update the tags associated with it. Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricsConfigurations_Update")
  @patch(#{ implicitOptionality: false })
  /* Note: It is preferred to use Azure.ResourceManager.ArmCustomPatchAsync, for existing resources the patch body is (nonsensically) "optional", and this is the only way to achieve it. */
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    ClusterMetricsConfiguration,
    PatchModel = ClusterMetricsConfigurationPatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ClusterMetricsConfiguration> &
      ArmLroLocationHeader<FinalResult = ClusterMetricsConfiguration>,
    OptionalRequestBody = true
  >;

  /**
   * Delete the metrics configuration of the provided cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricsConfigurations_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ClusterMetricsConfiguration,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of metrics configurations for the provided cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricsConfigurations_ListByCluster")
  listByCluster is ArmResourceListByParent<
    ClusterMetricsConfiguration,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<ClusterMetricsConfigurationList>
  >;
}

@@doc(ClusterMetricsConfiguration.name,
  "The name of the metrics configuration for the cluster."
);
@@doc(ClusterMetricsConfiguration.properties,
  "The list of the resource properties."
);
@@doc(ClusterMetricsConfigurations.createOrUpdate::parameters.resource,
  "The request body."
);
@@doc(ClusterMetricsConfigurations.update::parameters.properties,
  "The request body."
);
