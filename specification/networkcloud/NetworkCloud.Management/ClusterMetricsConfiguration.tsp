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

  /**
   * Resource ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

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
  @summary("Retrieve the metrics configuration of the cluster.")
  get is ArmResourceRead<ClusterMetricsConfiguration>;

  /**
   * Create new or update the existing metrics configuration of the provided cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricsConfigurations_CreateOrUpdate")
  @summary("Create or update metrics configuration of the cluster.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ClusterMetricsConfiguration,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    }
  >;

  /**
   * Patch properties of metrics configuration for the provided cluster, or update the tags associated with it. Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("MetricsConfigurations_Update")
  @summary("Patch metrics configuration of the cluster.")
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    ClusterMetricsConfiguration,
    PatchModel = ClusterMetricsConfigurationPatchParameters,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    },
    Response = ArmResponse<ClusterMetricsConfiguration> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = ClusterMetricsConfiguration> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: ClusterMetricsConfiguration;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the metrics configuration of the provided cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricsConfigurations_Delete")
  @summary("Delete the metrics configuration of the cluster.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ClusterMetricsConfiguration,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    },
    Response = ArmResponse<OperationStatusResult> | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of metrics configurations for the provided cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricsConfigurations_ListByCluster")
  @summary("List metrics configurations of the cluster.")
  listByCluster is ArmResourceListByParent<
    ClusterMetricsConfiguration,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;

      /**
       * The opaque token that the server returns to indicate where to continue listing resources from. This is used for paging through large result sets.
       */
      @query("$skipToken")
      $skipToken?: string;
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
