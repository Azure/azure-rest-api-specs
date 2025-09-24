import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DnsResolver.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Describes an outbound endpoint for a DNS resolver.
 */
@parentResource(DnsResolver)
model OutboundEndpoint
  is Azure.ResourceManager.TrackedResource<OutboundEndpointProperties, false> {
  ...ResourceNameParameter<
    Resource = OutboundEndpoint,
    KeyName = "outboundEndpointName",
    SegmentName = "outboundEndpoints",
    NamePattern = ""
  >;
  ...Legacy.EntityTagProperty;
}

@armResourceOperations
interface OutboundEndpoints {
  /**
   * Gets properties of an outbound endpoint for a DNS resolver.
   */
  get is ArmResourceRead<OutboundEndpoint, Error = CloudError>;

  /**
   * Creates or updates an outbound endpoint for a DNS resolver.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    OutboundEndpoint,
    Parameters = {
      /**
       * ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      ifMatch?: string;

      /**
       * Set to '*' to allow a new resource to be created, but to prevent updating an existing resource. Other values will be ignored.
       */
      @header
      ifNoneMatch?: string;
    },
    Response = ArmResourceUpdatedResponse<OutboundEndpoint> | ArmResourceCreatedResponse<
      OutboundEndpoint,
      ArmLroLocationHeader<FinalResult = OutboundEndpoint> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse,
    Error = CloudError
  >;

  /**
   * Updates an outbound endpoint for a DNS resolver.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    OutboundEndpoint,
    PatchModel = OutboundEndpointPatch,
    Parameters = {
      /**
       * ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      ifMatch?: string;
    },
    Error = CloudError
  >;

  /**
   * Deletes an outbound endpoint for a DNS resolver. WARNING: This operation cannot be undone.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    OutboundEndpoint,
    Parameters = {
      /**
       * ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      ifMatch?: string;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists outbound endpoints for a DNS resolver.
   */
  list is ArmResourceListByParent<
    OutboundEndpoint,
    Parameters = {
      /**
       * The maximum number of results to return. If not specified, returns up to 100 results.
       */
      @query("$top")
      $top?: int32;
    },
    Error = CloudError
  >;
}

@@doc(OutboundEndpoint.name,
  "The name of the outbound endpoint for the DNS resolver."
);
@@doc(OutboundEndpoint.properties, "Properties of the outbound endpoint.");
@@doc(OutboundEndpoints.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate operation."
);
@@doc(OutboundEndpoints.update::parameters.properties,
  "Parameters supplied to the Update operation."
);
