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
 * BmcKeySet represents the baseboard management controller key set.
 */
@parentResource(Cluster)
model BmcKeySet
  is Azure.ResourceManager.TrackedResource<BmcKeySetProperties, false> {
  ...ResourceNameParameter<
    Resource = BmcKeySet,
    KeyName = "bmcKeySetName",
    SegmentName = "bmcKeySets",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;

  /**
   * The extended location of the cluster associated with the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface BmcKeySets {
  /**
   * Get baseboard management controller key set of the provided cluster.
   */
  get is ArmResourceRead<BmcKeySet>;

  /**
   * Create a new baseboard management controller key set or update the existing one for the provided cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BmcKeySet,
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
   * Patch properties of baseboard management controller key set for the provided cluster, or update the tags associated with it. Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    BmcKeySet,
    PatchModel = BmcKeySetPatchParameters,
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
    Response = ArmResponse<BmcKeySet> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = BmcKeySet> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: BmcKeySet;

      /**
       * The URL to retrieve the status of the asynchronous operation.
       */
      @header("Location")
      location: string;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the baseboard management controller key set of the provided cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    BmcKeySet,
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
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of baseboard management controller key sets for the provided cluster.
   */
  listByCluster is ArmResourceListByParent<
    BmcKeySet,
    Response = ArmResponse<BmcKeySetList>
  >;
}

@@doc(BmcKeySet.name,
  "The name of the baseboard management controller key set."
);
@@encodedName(BmcKeySet.eTag, "application/json", "etag");
@@doc(BmcKeySet.properties, "The list of the resource properties.");
@@doc(BmcKeySets.createOrUpdate::parameters.resource, "The request body.");
@@doc(BmcKeySets.update::parameters.properties, "The request body.");
