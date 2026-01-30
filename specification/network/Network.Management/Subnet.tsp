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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@parentResource(VirtualNetwork)
@Http.Private.includeInapplicableMetadataInPayload(false)
model Subnet extends SubResourceModel {
  properties?: SubnetPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("subnetName")
  @segment("subnets")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@@doc(Subnet.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);

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
    },
    Error = CloudError
  >;

  /**
   * Creates or updates a subnet in the specified virtual network.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Subnet, Error = CloudError>;

  /**
   * Deletes the specified subnet.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Subnet,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all subnets in a virtual network.
   */
  list is ArmResourceListByParent<Subnet, Error = CloudError>;

  /**
   * Prepares a subnet by applying network intent policies.
   */
  @action("PrepareNetworkPolicies")
  prepareNetworkPolicies is ArmResourceActionAsync<
    Subnet,
    PrepareNetworkPoliciesRequest,
    Response = {
      @body body: void;
    },
    Error = CloudError
  >;

  /**
   * Unprepares a subnet by removing network intent policies.
   */
  @action("UnprepareNetworkPolicies")
  unprepareNetworkPolicies is ArmResourceActionAsync<
    Subnet,
    UnprepareNetworkPoliciesRequest,
    Response = {
      @body body: void;
    },
    Error = CloudError
  >;

  /**
   * Gets a list of resource navigation links for a subnet.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ResourceNavigationLinks_List")
  @get
  @action("ResourceNavigationLinks")
  resourceNavigationLinksList is ArmResourceActionSync<
    Subnet,
    void,
    ResourceNavigationLinksListResult,
    Error = CloudError
  >;

  /**
   * Gets a list of service association links for a subnet.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ServiceAssociationLinks_List")
  @get
  @action("ServiceAssociationLinks")
  serviceAssociationLinksList is ArmResourceActionSync<
    Subnet,
    void,
    ServiceAssociationLinksListResult,
    Error = CloudError
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
