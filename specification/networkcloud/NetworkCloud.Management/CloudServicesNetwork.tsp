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
 * Upon creation, the additional services that are provided by the platform will be allocated and represented in the status of this resource. All resources associated with this cloud services network will be part of the same layer 2 (L2) isolation domain. At least one service network must be created but may be reused across many virtual machines and/or Hybrid AKS clusters.
 */
model CloudServicesNetwork
  is Azure.ResourceManager.TrackedResource<CloudServicesNetworkProperties> {
  ...ResourceNameParameter<
    Resource = CloudServicesNetwork,
    KeyName = "cloudServicesNetworkName",
    SegmentName = "cloudServicesNetworks",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
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
interface CloudServicesNetworks {
  /**
   * Get properties of the provided cloud services network.
   */
  get is ArmResourceRead<CloudServicesNetwork>;

  /**
   * Create a new cloud services network or update the properties of the existing cloud services network.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CloudServicesNetwork,
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
   * Update properties of the provided cloud services network, or update the tags associated with it. Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    CloudServicesNetwork,
    PatchModel = CloudServicesNetworkPatchParameters,
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
    Response = ArmResponse<CloudServicesNetwork> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = CloudServicesNetwork> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: CloudServicesNetwork;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided cloud services network.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    CloudServicesNetwork,
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
   * Get a list of cloud services networks in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    CloudServicesNetwork,
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
    Response = ArmResponse<CloudServicesNetworkList>
  >;

  /**
   * Get a list of cloud services networks in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    CloudServicesNetwork,
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
    Response = ArmResponse<CloudServicesNetworkList>
  >;
}

@@doc(CloudServicesNetwork.name, "The name of the cloud services network.");
@@doc(CloudServicesNetwork.properties, "The list of the resource properties.");
@@doc(CloudServicesNetworks.createOrUpdate::parameters.resource,
  "The request body."
);
@@doc(CloudServicesNetworks.update::parameters.properties, "The request body.");
