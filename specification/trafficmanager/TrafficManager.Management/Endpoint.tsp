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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/trafficmanagerprofiles/{profileName}/{endpointType}/{endpointName}")
interface Endpoints {
  /**
   * Gets a Traffic Manager endpoint.
   */
  @get
  @armResourceRead(Endpoint)
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the Traffic Manager profile.
     */
    #suppress "@azure-tools/typespec-autorest/unsupported-optional-path-param" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    profileName?: string,

    /**
     * The type of the Traffic Manager endpoint.
     */
    #suppress "@azure-tools/typespec-autorest/unsupported-optional-path-param" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    endpointType?: EndpointType,

    /**
     * The name of the Traffic Manager endpoint.
     */
    #suppress "@azure-tools/typespec-autorest/unsupported-optional-path-param" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    endpointName?: string,
  ): ArmResponse<Endpoint> | CloudError;

  /**
   * Create or update a Traffic Manager endpoint.
   */
  @put
  @armResourceCreateOrUpdate(Endpoint)
  createOrUpdate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the Traffic Manager profile.
     */
    #suppress "@azure-tools/typespec-autorest/unsupported-optional-path-param" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    profileName?: string,

    /**
     * The type of the Traffic Manager endpoint.
     */
    #suppress "@azure-tools/typespec-autorest/unsupported-optional-path-param" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    endpointType?: EndpointType,

    /**
     * The name of the Traffic Manager endpoint.
     */
    #suppress "@azure-tools/typespec-autorest/unsupported-optional-path-param" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    endpointName?: string,

    /**
     * The properties of the Traffic Manager endpoint.
     */
    @bodyRoot
    resource: Endpoint,
  ): ArmResponse<Endpoint> | ArmCreatedResponse<Endpoint> | CloudError;

  /**
   * Update a Traffic Manager endpoint.
   */
  @patch(#{ implicitOptionality: false })
  @armResourceUpdate(Endpoint)
  update(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the Traffic Manager profile.
     */
    #suppress "@azure-tools/typespec-autorest/unsupported-optional-path-param" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    profileName?: string,

    /**
     * The type of the Traffic Manager endpoint.
     */
    #suppress "@azure-tools/typespec-autorest/unsupported-optional-path-param" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    endpointType?: EndpointType,

    /**
     * The name of the Traffic Manager endpoint.
     */
    #suppress "@azure-tools/typespec-autorest/unsupported-optional-path-param" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    endpointName?: string,

    /**
     * The properties of the Traffic Manager endpoint.
     */
    @bodyRoot
    properties: Endpoint,
  ): ArmResponse<Endpoint> | CloudError;

  /**
   * Deletes a Traffic Manager endpoint.
   */
  @delete
  @armResourceDelete(Endpoint)
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the Traffic Manager profile.
     */
    #suppress "@azure-tools/typespec-autorest/unsupported-optional-path-param" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    profileName?: string,

    /**
     * The type of the Traffic Manager endpoint.
     */
    #suppress "@azure-tools/typespec-autorest/unsupported-optional-path-param" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    endpointType?: EndpointType,

    /**
     * The name of the Traffic Manager endpoint.
     */
    #suppress "@azure-tools/typespec-autorest/unsupported-optional-path-param" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    endpointName?: string,
  ): ArmResponse<DeleteOperationResult> | ArmDeletedNoContentResponse | CloudError;
}

@@doc(Endpoint.name, "The name of the Traffic Manager endpoint.");
@@doc(Endpoint.properties, "The properties of the Traffic Manager endpoint.");
@@doc(Endpoints.createOrUpdate::parameters.resource,
  "The Traffic Manager endpoint parameters supplied to the CreateOrUpdate operation."
);
@@doc(Endpoints.update::parameters.properties,
  "The Traffic Manager endpoint parameters supplied to the Update operation."
);
