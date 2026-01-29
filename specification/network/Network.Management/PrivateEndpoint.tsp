import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Private endpoint resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateEndpoint extends Resource {
  properties?: PrivateEndpointProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("privateEndpointName")
  @segment("privateEndpoints")
  name: string;

  /**
   * The extended location of the load balancer.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

alias PrivateDnsZoneGroupOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The name of the private endpoint. */
    @path
    @segment("privateEndpoints")
    @key
    privateEndpointName: string;
  },
  {
    /** The name of the private endpoint. */
    @path
    @segment("privateDnsZoneGroups")
    @key
    privateDnsZoneGroupName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}",
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations(#{ allowStaticRoutes: true })
interface PrivateEndpoints {
  /**
   * Gets the specified private endpoint by resource group.
   */
  @autoRoute
  get is ArmResourceRead<
    PrivateEndpoint,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = Error
  >;

  /**
   * Creates or updates an private endpoint in the specified resource group.
   */
  @autoRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PrivateEndpoint,
    Error = Error
  >;

  /**
   * Deletes the specified private endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpoint,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = Error
  >;

  /**
   * Gets all private endpoints in a resource group.
   */
  @autoRoute
  list is ArmResourceListByParent<PrivateEndpoint, Error = Error>;

  /**
   * Gets all private endpoints in a subscription.
   */
  @autoRoute
  listBySubscription is ArmListBySubscription<PrivateEndpoint, Error = Error>;

  /**
   * Deletes the specified private dns zone group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PrivateDnsZoneGroups_Delete")
  @delete
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}")
  privateDnsZoneGroupsDelete is PrivateDnsZoneGroupOps.ActionAsync<
    PrivateEndpoint,
    void,
    void,
    Response = {
      @body body: void;
    } | ArmAcceptedLroResponse | NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets the private dns zone group resource by specified private dns zone group name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PrivateDnsZoneGroups_Get")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}")
  privateDnsZoneGroupsGet is PrivateDnsZoneGroupOps.ActionSync<
    PrivateEndpoint,
    void,
    Response = ArmResponse<PrivateDnsZoneGroup>,
    OverrideErrorType = CloudError
  >;

  /**
   * Creates or updates a private dns zone group in the specified private endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PrivateDnsZoneGroups_CreateOrUpdate")
  @put
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}")
  privateDnsZoneGroupsCreateOrUpdate is PrivateDnsZoneGroupOps.ActionAsync<
    PrivateEndpoint,
    PrivateDnsZoneGroup,
    void,
    Response = ArmResponse<PrivateDnsZoneGroup> | ArmResourceCreatedResponse<
      PrivateDnsZoneGroup,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = PrivateDnsZoneGroup> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets all private dns zone groups in a private endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PrivateDnsZoneGroups_List")
  @list
  @get
  @action("privateDnsZoneGroups")
  @autoRoute
  privateDnsZoneGroupsList is ArmResourceActionSync<
    PrivateEndpoint,
    void,
    ArmResponse<PrivateDnsZoneGroupListResult>,
    Error = CloudError
  >;
}

@@doc(PrivateEndpoint.name, "The name of the private endpoint.");
@@doc(PrivateEndpoint.properties, "Properties of the private endpoint.");
@@doc(PrivateEndpoints.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update private endpoint operation."
);
@@doc(PrivateEndpoints.privateDnsZoneGroupsCreateOrUpdate::parameters.body,
  "Parameters supplied to the create or update private dns zone group operation."
);
