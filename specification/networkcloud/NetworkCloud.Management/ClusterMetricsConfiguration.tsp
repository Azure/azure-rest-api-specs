import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
/**
 * ClusterMetricsConfiguration represents the metrics configuration of an on-premises Network Cloud cluster.
 */
@parentResource(Cluster)
model ClusterMetricsConfiguration
  is Azure.ResourceManager.TrackedResource<
    ClusterMetricsConfigurationProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = ClusterMetricsConfiguration,
    KeyName = "metricsConfigurationName",
    SegmentName = "metricsConfigurations",
    NamePattern = "^default$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;

  /**
   * The extended location of the cluster associated with the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation: ExtendedLocation;
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
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    }
  >;

  /**
   * Patch properties of metrics configuration for the provided cluster, or update the tags associated with it. Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("MetricsConfigurations_Update")
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    ClusterMetricsConfiguration,
    PatchModel = ClusterMetricsConfigurationPatchParameters,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    },
    Response = ArmResponse<ClusterMetricsConfiguration> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = ClusterMetricsConfiguration> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: ClusterMetricsConfiguration;

      /**
       * The URL to retrieve the status of the asynchronous operation.
       */
      @header("Location")
      location: string;
    }),
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
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    },
    Response = ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of metrics configurations for the provided cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricsConfigurations_ListByCluster")
  listByCluster is ArmResourceListByParent<
    ClusterMetricsConfiguration,
    Response = ArmResponse<ClusterMetricsConfigurationList>
  >;
}

@@doc(ClusterMetricsConfiguration.name,
  "The name of the metrics configuration for the cluster."
);
@@encodedName(ClusterMetricsConfiguration.eTag, "application/json", "etag");
@@doc(ClusterMetricsConfiguration.properties,
  "The list of the resource properties."
);
@@doc(ClusterMetricsConfigurations.createOrUpdate::parameters.resource,
  "The request body."
);
@@doc(ClusterMetricsConfigurations.update::parameters.properties,
  "The request body."
);
