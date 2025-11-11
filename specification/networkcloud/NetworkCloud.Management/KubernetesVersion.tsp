import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
/**
 * KubernetesVersion represents the available Kubernetes versions for a cluster.
 */
model KubernetesVersion
  is Azure.ResourceManager.TrackedResource<KubernetesVersionProperties, false> {
  ...ResourceNameParameter<
    Resource = KubernetesVersion,
    KeyName = "kubernetesVersionName",
    SegmentName = "kubernetesVersions",
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
interface KubernetesVersions {
  /**
   * Retrieve the Kubernetes version resource that describes the available Kubernetes versions for deployment.
   */
  get is ArmResourceRead<KubernetesVersion>;

  /**
   * Create the Kubernetes version resource or update its tags. This resource is system managed and should only be created with the name "default".
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    KubernetesVersion,
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
   * Update tags associated with the Kubernetes version resource. No other properties are supported for update.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    KubernetesVersion,
    PatchModel = KubernetesVersionPatchParameters,
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
    Response = ArmResponse<KubernetesVersion> | (ArmAcceptedLroResponse<ArmAsyncOperationHeader<FinalResult = KubernetesVersion> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: KubernetesVersion;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the specified Kubernetes version resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    KubernetesVersion,
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
   * Get a list of Kubernetes version resources in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    KubernetesVersion,
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
    Response = ArmResponse<KubernetesVersionList>
  >;

  /**
   * Get a list of Kubernetes version resources in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    KubernetesVersion,
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
    Response = ArmResponse<KubernetesVersionList>
  >;
}

@@doc(KubernetesVersion.name, "The name of the Kubernetes version resource.");
@@doc(KubernetesVersion.properties, "The list of the resource properties.");
@@doc(KubernetesVersions.createOrUpdate::parameters.resource,
  "The request body."
);
@@doc(KubernetesVersions.update::parameters.properties, "The request body.");
