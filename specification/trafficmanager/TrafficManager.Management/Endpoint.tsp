import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Class representing a Traffic Manager endpoint.
 */
@parentResource(Profile)
model Endpoint is Azure.ResourceManager.ProxyResource<EndpointProperties> {
  ...ResourceNameParameter<
    Resource = Endpoint,
    KeyName = "endpointName",
    SegmentName = "{endpointType}",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Endpoints {
  /**
   * Gets a Traffic Manager endpoint.
   */
  get is ArmResourceRead<
    Endpoint,
    Parameters = {
      /**
       * The type of the Traffic Manager endpoint.
       */
      @path
      endpointType: EndpointType;
    }
  >;

  /**
   * Create or update a Traffic Manager endpoint.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Endpoint,
    Parameters = {
      /**
       * The type of the Traffic Manager endpoint to be created or updated.
       */
      @path
      endpointType: EndpointType;
    }
  >;

  /**
   * Update a Traffic Manager endpoint.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Endpoint,
    PatchModel = Endpoint,
    Parameters = {
      /**
       * The type of the Traffic Manager endpoint to be updated.
       */
      @path
      endpointType: EndpointType;
    }
  >;

  /**
   * Deletes a Traffic Manager endpoint.
   */
  delete is ArmResourceDeleteSync<
    Endpoint,
    Parameters = {
      /**
       * The type of the Traffic Manager endpoint to be deleted.
       */
      @path
      endpointType: EndpointType;
    },
    Response = ArmResponse<DeleteOperationResult> | ArmDeletedNoContentResponse
  >;
}

@@doc(Endpoint.name, "The name of the Traffic Manager endpoint.");
@@doc(Endpoint.properties, "The properties of the Traffic Manager endpoint.");
@@doc(Endpoints.createOrUpdate::parameters.resource,
  "The Traffic Manager endpoint parameters supplied to the CreateOrUpdate operation."
);
@@doc(Endpoints.update::parameters.properties,
  "The Traffic Manager endpoint parameters supplied to the Update operation."
);
