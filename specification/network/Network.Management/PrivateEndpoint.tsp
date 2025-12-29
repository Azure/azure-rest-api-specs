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
@Http.Private.includeInapplicableMetadataInPayload(false)
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

alias PrivateDnsZoneGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

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
  }
>;

@armResourceOperations
interface PrivateEndpoints {
  /**
   * Gets the specified private endpoint by resource group.
   */
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PrivateEndpoint,
    Error = Error
  >;

  /**
   * Deletes the specified private endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpoint,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = Error
  >;

  /**
   * Gets all private endpoints in a resource group.
   */
  list is ArmResourceListByParent<PrivateEndpoint, Error = Error>;

  /**
   * Gets all private endpoints in a subscription.
   */
  listBySubscription is ArmListBySubscription<PrivateEndpoint, Error = Error>;

  /**
   * Deletes the specified private dns zone group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PrivateDnsZoneGroups_Delete")
  @delete
  privateDnsZoneGroupsDelete is PrivateDnsZoneGroupOps.DeleteWithoutOkAsync<
    PrivateEndpoint,
    Response = OkResponse | ArmAcceptedLroResponse | NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets the private dns zone group resource by specified private dns zone group name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PrivateDnsZoneGroups_Get")
  @get
  privateDnsZoneGroupsGet is PrivateDnsZoneGroupOps.Read<
    PrivateEndpoint,
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
  privateDnsZoneGroupsCreateOrUpdate is PrivateDnsZoneGroupOps.CreateOrUpdateAsync<
    PrivateEndpoint,
    Response = ArmResponse<PrivateDnsZoneGroup> | ArmResourceCreatedResponse<PrivateDnsZoneGroup>,
    Request = PrivateDnsZoneGroup,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets all private dns zone groups in a private endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PrivateDnsZoneGroups_List")
  @list
  @get
  privateDnsZoneGroupsList is PrivateDnsZoneGroupOps.List<
    PrivateEndpoint,
    Response = ArmResponse<PrivateDnsZoneGroupListResult>,
    OverrideErrorType = Error
  >;
}

@@doc(PrivateEndpoint.name, "The name of the private endpoint.");
@@doc(PrivateEndpoint.properties, "Properties of the private endpoint.");
@@doc(PrivateEndpoints.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update private endpoint operation."
);
@@doc(PrivateEndpoints.privateDnsZoneGroupsCreateOrUpdate::parameters.resource,
  "Parameters supplied to the create or update private dns zone group operation."
);
