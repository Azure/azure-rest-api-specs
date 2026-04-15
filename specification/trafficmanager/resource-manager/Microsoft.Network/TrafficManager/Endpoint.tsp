import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Network;
/**
 * Class representing a Traffic Manager endpoint.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Profile)
model Endpoint extends ProxyResource {
  properties?: EndpointProperties;
}

alias EndpointsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider<Endpoint>;
    ...ParentKeysOf<Endpoint>;

    /**
     * The name of the Traffic Manager profile.
     */
    @path
    @segment("trafficmanagerprofiles")
    profileName: string;
  },
  {
    /**
     * The type of the Traffic Manager endpoint.
     */
    @path
    endpointType: EndpointType;

    /**
     * The name of the Traffic Manager endpoint.
     */
    @path
    endpointName: string;
  },
  ErrorType = CloudError
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface Endpoints {
  /**
   * Gets a Traffic Manager endpoint.
   */
  get is EndpointsOps.Read<Endpoint>;

  /**
   * Create or update a Traffic Manager endpoint.
   */
  createOrUpdate is EndpointsOps.CreateOrUpdateSync<Endpoint>;

  /**
   * Update a Traffic Manager endpoint.
   */
  @sharedRoute
  @removed(Versions.v2024_04_01_preview)
  @patch(#{ implicitOptionality: false })
  update is EndpointsOps.CustomPatchSync<Endpoint, PatchModel = Endpoint>;

  /**
   * Update a Traffic Manager endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "operationId needed to match stable version"
  @sharedRoute
  @added(Versions.v2024_04_01_preview)
  @operationId("Endpoints_Update")
  @patch(#{ implicitOptionality: false })
  updateV2 is EndpointsOps.CustomPatchSync<
    Endpoint,
    PatchModel = EndpointUpdate
  >;

  /**
   * Deletes a Traffic Manager endpoint.
   */
  delete is EndpointsOps.DeleteSync<
    Endpoint,
    Response = ArmResponse<DeleteOperationResult> | ArmDeletedNoContentResponse
  >;
}

@@doc(Endpoint.properties, "The properties of the Traffic Manager endpoint.");
@@doc(Endpoints.createOrUpdate::parameters.resource,
  "The Traffic Manager endpoint parameters supplied to the CreateOrUpdate operation."
);
@@doc(Endpoints.update::parameters.properties,
  "The Traffic Manager endpoint parameters supplied to the Update operation."
);
@@doc(Endpoints.updateV2::parameters.properties,
  "The Traffic Manager endpoint parameters supplied to the Update operation."
);
