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
 * Rack represents the hardware of the rack and is dependent upon the cluster for lifecycle.
 */
model Rack is Azure.ResourceManager.TrackedResource<RackProperties, false> {
  ...ResourceNameParameter<
    Resource = Rack,
    KeyName = "rackName",
    SegmentName = "racks",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;

  /**
   * The extended location of the cluster associated with the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Racks {
  /**
   * Get properties of the provided rack.
   */
  get is ArmResourceRead<Rack>;

  /**
   * Create a new rack or update properties of the existing one.
   * All customer initiated requests will be rejected as the life cycle of this resource is managed by the system.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Rack,
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
    }
  >;

  /**
   * Patch properties of the provided rack, or update the tags associated with the rack. Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    Rack,
    PatchModel = RackPatchParameters,
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
    },
    Response = ArmResponse<Rack> | (ArmAcceptedLroResponse<ArmAsyncOperationHeader<FinalResult = Rack> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: Rack;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided rack.
   * All customer initiated requests will be rejected as the life cycle of this resource is managed by the system.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Rack,
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
    },
    Response = ArmResponse<OperationStatusResult> | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of racks in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Rack,
    Response = ArmResponse<RackList>
  >;

  /**
   * Get a list of racks in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    Rack,
    Response = ArmResponse<RackList>
  >;
}

@@doc(Rack.name, "The name of the rack.");
@@encodedName(Rack.eTag, "application/json", "etag");
@@doc(Rack.properties, "The list of the resource properties.");
@@doc(Racks.createOrUpdate::parameters.resource, "The request body.");
@@doc(Racks.update::parameters.properties, "The request body.");
