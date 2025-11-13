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
model PrivateEndpoint
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<PrivateEndpointProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpoint,
    KeyName = "privateEndpointName",
    SegmentName = "privateEndpoints",
    NamePattern = ""
  >;

  /**
   * The extended location of the load balancer.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

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
    }
  >;

  /**
   * Creates or updates an private endpoint in the specified resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PrivateEndpoint>;

  /**
   * Deletes the specified private endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpoint,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all private endpoints in a resource group.
   */
  list is ArmResourceListByParent<PrivateEndpoint>;

  /**
   * Gets all private endpoints in a subscription.
   */
  listBySubscription is ArmListBySubscription<PrivateEndpoint>;

  /**
   * Deletes the specified private dns zone group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateDnsZoneGroups_Delete")
  @delete
  @action("{privateDnsZoneGroupName}")
  privateDnsZoneGroupsDelete is ArmResourceActionAsync<
    PrivateEndpoint,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * The name of the private dns zone group.
       */
      @path
      privateDnsZoneGroupName: string;
    }
  >;

  /**
   * Gets the private dns zone group resource by specified private dns zone group name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateDnsZoneGroups_Get")
  @get
  @action("{privateDnsZoneGroupName}")
  privateDnsZoneGroupsGet is ArmResourceActionSync<
    PrivateEndpoint,
    void,
    ArmResponse<PrivateDnsZoneGroup>,
    Parameters = {
      /**
       * The name of the private dns zone group.
       */
      @path
      privateDnsZoneGroupName: string;
    }
  >;

  /**
   * Creates or updates a private dns zone group in the specified private endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateDnsZoneGroups_CreateOrUpdate")
  @put
  @action("{privateDnsZoneGroupName}")
  privateDnsZoneGroupsCreateOrUpdate is ArmResourceActionAsyncBase<
    PrivateEndpoint,
    PrivateDnsZoneGroup,
    ArmResponse<PrivateDnsZoneGroup> | ArmResourceCreatedResponse<PrivateDnsZoneGroup>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<PrivateEndpoint>,
    Parameters = {
      /**
       * The name of the private dns zone group.
       */
      @path
      privateDnsZoneGroupName: string;
    }
  >;

  /**
   * Gets all private dns zone groups in a private endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateDnsZoneGroups_List")
  @list
  @get
  @action("privateDnsZoneGroups")
  privateDnsZoneGroupsList is ArmResourceActionSync<
    PrivateEndpoint,
    void,
    ArmResponse<PrivateDnsZoneGroupListResult>
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
