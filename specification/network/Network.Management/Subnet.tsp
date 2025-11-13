import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Subnet in a virtual network resource.
 */
@parentResource(VirtualNetwork)
model Subnet is Azure.ResourceManager.ProxyResource<SubnetPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = Subnet,
    KeyName = "subnetName",
    SegmentName = "subnets",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface Subnets {
  /**
   * Gets the specified subnet by virtual network and resource group.
   */
  get is ArmResourceRead<
    Subnet,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Creates or updates a subnet in the specified virtual network.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Subnet>;

  /**
   * Deletes the specified subnet.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Subnet,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all subnets in a virtual network.
   */
  list is ArmResourceListByParent<Subnet>;

  /**
   * Prepares a subnet by applying network intent policies.
   */
  @action("PrepareNetworkPolicies")
  prepareNetworkPolicies is ArmResourceActionAsync<
    Subnet,
    PrepareNetworkPoliciesRequest,
    OkResponse
  >;

  /**
   * Unprepares a subnet by removing network intent policies.
   */
  @action("UnprepareNetworkPolicies")
  unprepareNetworkPolicies is ArmResourceActionAsync<
    Subnet,
    UnprepareNetworkPoliciesRequest,
    OkResponse
  >;

  /**
   * Gets a list of resource navigation links for a subnet.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceNavigationLinks_List")
  @list
  @get
  @action("ResourceNavigationLinks")
  resourceNavigationLinksList is ArmResourceActionSync<
    Subnet,
    void,
    ArmResponse<ResourceListResult<ResourceNavigationLink>>
  >;

  /**
   * Gets a list of service association links for a subnet.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServiceAssociationLinks_List")
  @list
  @get
  @action("ServiceAssociationLinks")
  serviceAssociationLinksList is ArmResourceActionSync<
    Subnet,
    void,
    ArmResponse<ResourceListResult<ServiceAssociationLink>>
  >;
}

@@doc(Subnet.name, "The name of the subnet.");
@@doc(Subnet.properties, "Properties of the subnet.");
@@doc(Subnets.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update subnet operation."
);
@@doc(Subnets.prepareNetworkPolicies::parameters.body,
  "Parameters supplied to prepare subnet by applying network intent policies."
);
@@doc(Subnets.unprepareNetworkPolicies::parameters.body,
  "Parameters supplied to unprepare subnet to remove network intent policies."
);
