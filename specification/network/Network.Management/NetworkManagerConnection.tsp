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
@subscriptionResource
model NetworkManagerConnection
  is Azure.ResourceManager.ProxyResource<NetworkManagerConnectionProperties> {
  ...ResourceNameParameter<
    Resource = NetworkManagerConnection,
    KeyName = "networkManagerConnectionName",
    SegmentName = "networkManagerConnections",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
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

@armResourceOperations
interface NetworkManagerConnections {
  /**
   * Get a specified connection created by this subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SubscriptionNetworkManagerConnections_Get")
  get is NetworkManagerConnectionOps.Read<NetworkManagerConnection>;

  /**
   * Create a network manager connection on this subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SubscriptionNetworkManagerConnections_CreateOrUpdate")
  createOrUpdate is NetworkManagerConnectionOps.CreateOrUpdateSync<NetworkManagerConnection>;

  /**
   * Delete specified connection created by this subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SubscriptionNetworkManagerConnections_Delete")
  delete is NetworkManagerConnectionOps.DeleteSync<NetworkManagerConnection>;

  /**
   * List all network manager connections created by this subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
    }
  >;
}

@armResourceOperations
interface ManagementGroupNetworkManagerConnections {
  /**
   * Get a specified connection created by this management group.
   */
  get is Extension.Read<
    Extension.ManagementGroup<"managementGroupId">,
    NetworkManagerConnection
  >;

  /**
   * Create a network manager connection on this management group.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    Extension.ManagementGroup<"managementGroupId">,
    NetworkManagerConnection
  >;

  /**
   * Delete specified pending connection created by this management group.
   */
  delete is Extension.DeleteSync<
    Extension.ManagementGroup<"managementGroupId">,
    NetworkManagerConnection
  >;

  /**
   * List all network manager connections created by this management group.
   */
  list is Extension.ListByTarget<
    Extension.ManagementGroup<"managementGroupId">,
    NetworkManagerConnection
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
