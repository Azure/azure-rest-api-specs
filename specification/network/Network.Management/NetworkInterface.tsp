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
 * A network interface in a resource group.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model NetworkInterface extends Resource {
  properties?: NetworkInterfacePropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("networkInterfaceName")
  @segment("networkInterfaces")
  name: string;

  /**
   * The extended location of the network interface.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

alias NetworkInterfaceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("providers")
    providerName: "microsoft.Compute";

    /** The name of the cloud service. */
    @path
    @segment("cloudServices")
    @key
    cloudServiceName: string;

    /** The name of role instance. */
    @path
    @segment("roleInstances")
    @key
    roleInstanceName: string;
  },
  {
    /** The name of the network interface. */
    @path
    @segment("networkInterfaces")
    @key
    networkInterfaceName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations
interface NetworkInterfaces {
  /**
   * Get the specified network interface in a cloud service.
   */
  getCloudServiceNetworkInterface is NetworkInterfaceOps.Read<
    NetworkInterface,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * Gets information about all network interfaces in a role instance in a cloud service.
   */
  listCloudServiceRoleInstanceNetworkInterfaces is NetworkInterfaceOps.List<
    NetworkInterface,
    OverrideErrorType = CloudError
  >;
}
alias NetworkInterfaceOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    /** The name of the network interface. */
    @path
    @segment("networkInterfaces")
    @key
    networkInterfaceName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations
interface NetworkInterfaceOperationGroup {
  /**
   * Gets information about the specified network interface.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkInterfaces_Get")
  get is NetworkInterfaceOperationGroupOps.Read<
    NetworkInterface,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * Creates or updates a network interface.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkInterfaces_CreateOrUpdate")
  createOrUpdate is NetworkInterfaceOperationGroupOps.CreateOrUpdateAsync<
    NetworkInterface,
    OverrideErrorType = CloudError
  >;

  /**
   * Updates a network interface tags.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkInterfaces_UpdateTags")
  @patch(#{ implicitOptionality: false })
  updateTags is NetworkInterfaceOperationGroupOps.CustomPatchSync<
    NetworkInterface,
    PatchModel = TagsObject,
    OverrideErrorType = CloudError
  >;

  /**
   * Deletes the specified network interface.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkInterfaces_Delete")
  delete is NetworkInterfaceOperationGroupOps.DeleteWithoutOkAsync<
    NetworkInterface,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets all network interfaces in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkInterfaces_List")
  list is NetworkInterfaceOperationGroupOps.List<
    NetworkInterface,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets all network interfaces in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkInterfaces_ListAll")
  listAll is ArmListBySubscription<NetworkInterface, Error = CloudError>;

  /**
   * Gets all route tables applied to a network interface.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkInterfaces_GetEffectiveRouteTable")
  @post
  @action("effectiveRouteTable")
  getEffectiveRouteTable is NetworkInterfaceOperationGroupOps.ActionAsync<
    NetworkInterface,
    void,
    EffectiveRouteListResult,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets all network security groups applied to a network interface.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkInterfaces_ListEffectiveNetworkSecurityGroups")
  @post
  @action("effectiveNetworkSecurityGroups")
  listEffectiveNetworkSecurityGroups is NetworkInterfaceOperationGroupOps.ActionAsync<
    NetworkInterface,
    void,
    EffectiveNetworkSecurityGroupListResult,
    OverrideErrorType = CloudError
  >;

  /**
   * List all load balancers in a network interface.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkInterfaceLoadBalancers_List")
  @list
  @get
  @action("loadBalancers")
  networkInterfaceLoadBalancersList is NetworkInterfaceOperationGroupOps.ActionSync<
    NetworkInterface,
    void,
    ArmResponse<NetworkInterfaceLoadBalancerListResult>,
    OverrideErrorType = CloudError
  >;
}

@@doc(NetworkInterface.name, "The name of the network interface.");
@@doc(NetworkInterface.properties, "Properties of the network interface.");
@@doc(NetworkInterfaceOperationGroup.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update network interface operation."
);
@@doc(NetworkInterfaceOperationGroup.updateTags::parameters.properties,
  "Parameters supplied to update network interface tags."
);
