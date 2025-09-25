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
 * Describes an inbound endpoint for a DNS resolver.
 */
@parentResource(DnsResolver)
model InboundEndpoint
  is Azure.ResourceManager.TrackedResource<InboundEndpointProperties, false> {
  ...ResourceNameParameter<
    Resource = InboundEndpoint,
    KeyName = "inboundEndpointName",
    SegmentName = "inboundEndpoints",
    NamePattern = ""
  >;
  ...Legacy.EntityTagProperty;
}

@armResourceOperations
interface InboundEndpoints {
  /**
   * Gets properties of an inbound endpoint for a DNS resolver.
   */
  get is ArmResourceRead<InboundEndpoint, Error = CloudError>;

  /**
   * Creates or updates an inbound endpoint for a DNS resolver.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    InboundEndpoint,
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
    Response = ArmResourceUpdatedResponse<InboundEndpoint> | ArmResourceCreatedResponse<
      InboundEndpoint,
      ArmLroLocationHeader<FinalResult = InboundEndpoint> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse,
    Error = CloudError
  >;

  /**
   * Updates an inbound endpoint for a DNS resolver.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    InboundEndpoint,
    PatchModel = InboundEndpointPatch,
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
   * Deletes an inbound endpoint for a DNS resolver. WARNING: This operation cannot be undone.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    InboundEndpoint,
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
   * Lists inbound endpoints for a DNS resolver.
   */
  list is ArmResourceListByParent<
    InboundEndpoint,
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

@@doc(InboundEndpoint.name,
  "The name of the inbound endpoint for the DNS resolver."
);
@@doc(InboundEndpoint.properties, "Properties of the inbound endpoint.");
@@doc(InboundEndpoints.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate operation."
);
@@doc(InboundEndpoints.update::parameters.properties,
  "Parameters supplied to the Update operation."
);
