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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
@parentResource(Profile)
model Endpoint extends ProxyResource {
  properties: EndpointProperties;
}

alias EndpointOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider<Endpoint>;
  },
  {
    /**
     * The name of the Profile.
     */
    @path
    @segment("trafficmanagerprofiles")
    profileName: string;

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
// @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/trafficmanagerprofiles/{profileName}/{endpointType}/{endpointName}")
interface Endpoints {
  /**
   * Gets a Traffic Manager endpoint.
   */
  get is EndpointOps.Read<Endpoint>;

  /**
   * Create or update a Traffic Manager endpoint.
   */
  createOrUpdate is EndpointOps.CreateOrUpdateSync<Endpoint>;

  /**
   * Update a Traffic Manager endpoint.
   */
  @patch(#{ implicitOptionality: false })
  update is EndpointOps.CustomPatchSync<Endpoint, PatchModel = Endpoint>;

  /**
   * Deletes a Traffic Manager endpoint.
   */
  delete is EndpointOps.DeleteSync<
    Endpoint,
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
