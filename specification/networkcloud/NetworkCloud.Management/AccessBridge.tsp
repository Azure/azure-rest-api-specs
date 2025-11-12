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
 * AccessBridge represents a managed access bridge resource.
 */
model AccessBridge
  is Azure.ResourceManager.TrackedResource<AccessBridgeProperties, false> {
  ...ResourceNameParameter<
    Resource = AccessBridge,
    KeyName = "accessBridgeName",
    SegmentName = "accessBridges",
    NamePattern = "",
    Type = AccessBridgeAllowedName
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
interface AccessBridges {
  /**
   * Get the properties of the provided access bridge.
   */
  @summary("Retrieve the access bridge.")
  get is ArmResourceRead<AccessBridge>;

  /**
   * Create a new access bridge or update the properties of the existing access bridge.
   */
  @summary("Create or update the access bridge.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AccessBridge>;

  /**
   * Update properties of the provided access bridge, or update tags associated with the access bridge. Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @summary("Patch the access bridge.")
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    AccessBridge,
    PatchModel = AccessBridgePatchParameters,
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
    Response = ArmResponse<AccessBridge> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = AccessBridge> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: AccessBridge;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the specified access bridge.
   */
  @summary("Delete the access bridge.")
  delete is ArmResourceDeleteWithoutOkAsync<
    AccessBridge,
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
    Response = ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of access bridges in the provided resource group.
   */
  @summary("List access bridges in the resource group.")
  listByResourceGroup is ArmResourceListByParent<
    AccessBridge,
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
    Response = ArmResponse<AccessBridgeList>
  >;

  /**
   * Get a list of access bridges in the provided subscription.
   */
  @summary("List access bridges in the subscription.")
  listBySubscription is ArmListBySubscription<
    AccessBridge,
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
    Response = ArmResponse<AccessBridgeList>
  >;
}

@@doc(AccessBridge.name, "The name of the access bridge.");
@@doc(AccessBridge.properties, "The list of the resource properties.");
@@doc(AccessBridges.createOrUpdate::parameters.resource,
  "The access bridge configuration."
);
@@doc(AccessBridges.update::parameters.properties, "The request body.");
