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
 * BareMetalMachineKeySet represents the bare metal machine key set.
 */
@parentResource(Cluster)
model BareMetalMachineKeySet
  is Azure.ResourceManager.TrackedResource<
    BareMetalMachineKeySetProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = BareMetalMachineKeySet,
    KeyName = "bareMetalMachineKeySetName",
    SegmentName = "bareMetalMachineKeySets",
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
interface BareMetalMachineKeySets {
  /**
   * Get bare metal machine key set of the provided cluster.
   */
  @summary("Retrieve the bare metal machine key set of the cluster.")
  get is ArmResourceRead<BareMetalMachineKeySet>;

  /**
   * Create a new bare metal machine key set or update the existing one for the provided cluster.
   */
  @summary("Create or update the bare metal machine key set of the cluster.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BareMetalMachineKeySet,
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
   * Patch properties of bare metal machine key set for the provided cluster, or update the tags associated with it. Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @summary("Patch bare metal machine key set of the cluster.")
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    BareMetalMachineKeySet,
    PatchModel = BareMetalMachineKeySetPatchParameters,
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
    Response = ArmResponse<BareMetalMachineKeySet> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = BareMetalMachineKeySet> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: BareMetalMachineKeySet;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the bare metal machine key set of the provided cluster.
   */
  @summary("Delete the bare metal machine key set of the cluster.")
  delete is ArmResourceDeleteWithoutOkAsync<
    BareMetalMachineKeySet,
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
   * Get a list of bare metal machine key sets for the provided cluster.
   */
  @summary("List bare metal machine key sets of the cluster.")
  listByCluster is ArmResourceListByParent<
    BareMetalMachineKeySet,
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
    Response = ArmResponse<BareMetalMachineKeySetList>
  >;
}

@@doc(BareMetalMachineKeySet.name,
  "The name of the bare metal machine key set."
);
@@doc(BareMetalMachineKeySet.properties,
  "The list of the resource properties."
);
@@doc(BareMetalMachineKeySets.createOrUpdate::parameters.resource,
  "The request body."
);
@@doc(BareMetalMachineKeySets.update::parameters.properties,
  "The request body."
);
