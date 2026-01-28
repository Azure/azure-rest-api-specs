import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualHub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Virtual Appliance Site resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(VirtualHub)
@Http.Private.includeInapplicableMetadataInPayload(false)
model BgpConnection extends SubResourceModel {
  properties?: BgpConnectionProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("connectionName")
  @segment("bgpConnections")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

alias VirtualHubBgpConnectionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the virtual hub. */
    @path
    @segment("virtualHubs")
    @key
    hubName: string;
  },
  {
    /** The name of the bgp connection. */
    @path
    @segment("bgpConnections")
    @key
    connectionName: string;
  }
>;

@armResourceOperations
interface BgpConnections {
  /**
   * Retrieves the details of a Virtual Hub Bgp Connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualHubBgpConnection_Get")
  get is ArmResourceRead<BgpConnection, Error = CloudError>;

  /**
   * Creates a VirtualHubBgpConnection resource if it doesn't exist else updates the existing VirtualHubBgpConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualHubBgpConnection_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BgpConnection,
    Error = CloudError
  >;

  /**
   * Deletes a VirtualHubBgpConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualHubBgpConnection_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    BgpConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Retrieves the details of all VirtualHubBgpConnections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualHubBgpConnections_List")
  list is ArmResourceListByParent<
    BgpConnection,
    Response = ArmResponse<ListVirtualHubBgpConnectionResults>,
    Error = CloudError
  >;

  /**
   * Retrieves a list of routes the virtual hub bgp connection has learned.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualHubBgpConnections_ListLearnedRoutes")
  @action("learnedRoutes")
  listLearnedRoutes is VirtualHubBgpConnectionOps.ActionAsync<
    BgpConnection,
    void,
    void,
    Response = Record<PeerRoute[]> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = PeerRouteList> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Retrieves a list of routes the virtual hub bgp connection is advertising to the specified peer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualHubBgpConnections_ListAdvertisedRoutes")
  @action("advertisedRoutes")
  listAdvertisedRoutes is VirtualHubBgpConnectionOps.ActionAsync<
    BgpConnection,
    void,
    void,
    Response = Record<PeerRoute[]> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = PeerRouteList> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;
}

@@doc(BgpConnection.name, "The name of the connection.");
@@doc(BgpConnection.properties, "The properties of the Bgp connections.");
@@doc(BgpConnections.createOrUpdate::parameters.resource,
  "Parameters of Bgp connection."
);
