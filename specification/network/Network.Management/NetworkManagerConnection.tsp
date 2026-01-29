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
 * The Network Manager Connection resource
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@subscriptionResource
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkManagerConnection extends ChildResource {
  properties?: NetworkManagerConnectionProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("networkManagerConnectionName")
  @segment("networkManagerConnections")
  name: string;

  /**
   * The system metadata related to this resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: Azure.ResourceManager.Foundations.SystemData;
}

alias NetworkManagerConnectionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Network";
  },
  {},
  {
    /** Name for the network manager connection. */
    @path
    @segment("networkManagerConnections")
    @key
    networkManagerConnectionName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
@armResourceOperations
interface NetworkManagerConnections {
  /**
   * Get a specified connection created by this subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SubscriptionNetworkManagerConnections_Get")
  get is NetworkManagerConnectionOps.Read<
    NetworkManagerConnection,
    ErrorType = CloudError
  >;

  /**
   * Create a network manager connection on this subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SubscriptionNetworkManagerConnections_CreateOrUpdate")
  createOrUpdate is NetworkManagerConnectionOps.CreateOrUpdateSync<
    NetworkManagerConnection,
    ErrorType = CloudError
  >;

  /**
   * Delete specified connection created by this subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SubscriptionNetworkManagerConnections_Delete")
  delete is NetworkManagerConnectionOps.DeleteSync<
    NetworkManagerConnection,
    ErrorType = CloudError
  >;

  /**
   * List all network manager connections created by this subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SubscriptionNetworkManagerConnections_List")
  list is NetworkManagerConnectionOps.List<
    NetworkManagerConnection,
    Parameters = {
      /**
       * An optional query parameter which specifies the maximum number of records to be returned by the server.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    ErrorType = CloudError
  >;
}

@armResourceOperations
interface ManagementGroupNetworkManagerConnections {
  /**
   * Get a specified connection created by this management group.
   */
  get is Extension.Read<
    Extension.ManagementGroup<"managementGroupId">,
    NetworkManagerConnection,
    Error = CloudError
  >;

  /**
   * Create a network manager connection on this management group.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    Extension.ManagementGroup<"managementGroupId">,
    NetworkManagerConnection,
    Error = CloudError
  >;

  /**
   * Delete specified pending connection created by this management group.
   */
  delete is Extension.DeleteSync<
    Extension.ManagementGroup<"managementGroupId">,
    NetworkManagerConnection,
    Error = CloudError
  >;

  /**
   * List all network manager connections created by this management group.
   */
  list is Extension.ListByTarget<
    Extension.ManagementGroup<"managementGroupId">,
    NetworkManagerConnection,
    Parameters = {
      /**
       * An optional query parameter which specifies the maximum number of records to be returned by the server.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Error = CloudError
  >;
}

@@doc(NetworkManagerConnection.name,
  "Name for the network manager connection."
);
@@doc(NetworkManagerConnection.properties, "The scope connection properties");
@@doc(NetworkManagerConnections.createOrUpdate::parameters.resource,
  "Network manager connection to be created/updated."
);
@@doc(ManagementGroupNetworkManagerConnections.createOrUpdate::parameters.resource,
  "Network manager connection to be created/updated."
);
