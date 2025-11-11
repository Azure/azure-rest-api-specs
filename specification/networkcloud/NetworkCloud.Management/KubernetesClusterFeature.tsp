import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./KubernetesCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
/**
 * KubernetesClusterFeature represents the feature of a Kubernetes cluster.
 */
@parentResource(KubernetesCluster)
model KubernetesClusterFeature
  is Azure.ResourceManager.TrackedResource<KubernetesClusterFeatureProperties> {
  ...ResourceNameParameter<
    Resource = KubernetesClusterFeature,
    KeyName = "featureName",
    SegmentName = "features",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-]{0,61}[a-zA-Z0-9])$"
  >;

  /**
   * Resource ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface KubernetesClusterFeatures {
  /**
   * Get properties of the provided the Kubernetes cluster feature.
   */
  get is ArmResourceRead<KubernetesClusterFeature>;

  /**
   * Create a new Kubernetes cluster feature or update properties of the Kubernetes cluster feature if it exists.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    KubernetesClusterFeature,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    }
  >;

  /**
   * Patch properties of the provided Kubernetes cluster feature.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    KubernetesClusterFeature,
    PatchModel = KubernetesClusterFeaturePatchParameters,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    },
    Response = ArmResponse<KubernetesClusterFeature> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = KubernetesClusterFeature> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: KubernetesClusterFeature;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided Kubernetes cluster feature.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    KubernetesClusterFeature,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    },
    Response = ArmResponse<OperationStatusResult> | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of features for the provided Kubernetes cluster.
   */
  listByKubernetesCluster is ArmResourceListByParent<
    KubernetesClusterFeature,
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
    Response = ArmResponse<KubernetesClusterFeatureList>
  >;
}

@@doc(KubernetesClusterFeature.name, "The name of the feature.");
@@doc(KubernetesClusterFeature.properties,
  "The list of the resource properties."
);
@@doc(KubernetesClusterFeatures.createOrUpdate::parameters.resource,
  "The request body."
);
@@doc(KubernetesClusterFeatures.update::parameters.properties,
  "The request body."
);
