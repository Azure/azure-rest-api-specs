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
 * A common class for general resource information.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
@Http.Private.includeInapplicableMetadataInPayload(false)
model VirtualNetworkGateway extends Resource {
  properties: VirtualNetworkGatewayPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("virtualNetworkGatewayName")
  @segment("virtualNetworkGateways")
  name: string;

  /**
   * The extended location of type local virtual network gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The identity of the virtual network gateway, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
@armResourceOperations
interface VirtualNetworkGateways {
  /**
   * Gets the specified virtual network gateway by resource group.
   */
  get is ArmResourceRead<VirtualNetworkGateway, Error = CloudError>;

  /**
   * Creates or updates a virtual network gateway in the specified resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualNetworkGateway,
    Error = CloudError
  >;

  /**
   * Updates a virtual network gateway tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchAsync<
    VirtualNetworkGateway,
    PatchModel = TagsObject,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = VirtualNetworkGateway> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Deletes the specified virtual network gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetworkGateway,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all virtual network gateways by resource group.
   */
  list is ArmResourceListByParent<VirtualNetworkGateway, Error = CloudError>;

  /**
   * Gets all the connections in a virtual network gateway.
   */
  @list
  @get
  @action("connections")
  listConnections is ArmResourceActionSync<
    VirtualNetworkGateway,
    void,
    ArmResponse<VirtualNetworkGatewayListConnectionsResult>,
    Error = CloudError
  >;

  /**
   * Resets the primary of the virtual network gateway in the specified resource group.
   */
  reset is ArmResourceActionAsync<
    VirtualNetworkGateway,
    void,
    VirtualNetworkGateway,
    Parameters = {
      /**
       * Virtual network gateway vip address supplied to the begin reset of the active-active feature enabled gateway.
       */
      @query("gatewayVip")
      gatewayVip?: string;
    },
    Error = CloudError
  >;

  /**
   * Resets the VPN client shared key of the virtual network gateway in the specified resource group.
   */
  @action("resetvpnclientsharedkey")
  resetVpnClientSharedKey is ArmResourceActionAsync<
    VirtualNetworkGateway,
    void,
    Response = {
      @body body: void;
    },
    Error = CloudError
  >;

  /**
   * Generates VPN client package for P2S client of the virtual network gateway in the specified resource group.
   */
  generatevpnclientpackage is ArmResourceActionAsync<
    VirtualNetworkGateway,
    VpnClientParameters,
    {
      @body body: stringApplicationJson;
    },
    Error = CloudError
  >;

  /**
   * Generates VPN profile for P2S client of the virtual network gateway in the specified resource group. Used for IKEV2 and radius based authentication.
   */
  @action("generatevpnprofile")
  generateVpnProfile is ArmResourceActionAsync<
    VirtualNetworkGateway,
    VpnClientParameters,
    {
      @body body: stringApplicationJson;
    },
    Error = CloudError
  >;

  /**
   * Gets pre-generated VPN profile for P2S client of the virtual network gateway in the specified resource group. The profile needs to be generated first using generateVpnProfile.
   */
  @action("getvpnprofilepackageurl")
  getVpnProfilePackageUrl is ArmResourceActionAsync<
    VirtualNetworkGateway,
    void,
    {
      @body body: stringApplicationJson;
    },
    Error = CloudError
  >;

  /**
   * The GetBgpPeerStatus operation retrieves the status of all BGP peers.
   */
  @list
  getBgpPeerStatus is ArmResourceActionAsync<
    VirtualNetworkGateway,
    void,
    BgpPeerStatusListResult,
    Parameters = {
      /**
       * The IP address of the peer to retrieve the status of.
       */
      @query("peer")
      peer?: string;
    },
    Error = CloudError
  >;

  /**
   * Gets a xml format representation for supported vpn devices.
   */
  @action("supportedvpndevices")
  supportedVpnDevices is ArmResourceActionSync<
    VirtualNetworkGateway,
    void,
    {
      @body body: stringApplicationJson;
    },
    Error = CloudError
  >;

  /**
   * List all Radius servers with respective radius secrets from virtual network gateway VpnClientConfiguration.
   */
  @post
  listRadiusSecrets is ArmResourceActionSync<
    VirtualNetworkGateway,
    void,
    ArmResponse<RadiusAuthServerListResult>,
    Error = CloudError
  >;

  /**
   * This operation retrieves a list of routes the virtual network gateway has learned, including routes learned from BGP peers.
   */
  @list
  getLearnedRoutes is ArmResourceActionAsync<
    VirtualNetworkGateway,
    void,
    GatewayRouteListResult,
    Error = CloudError
  >;

  /**
   * This operation retrieves a list of routes the virtual network gateway is advertising to the specified peer.
   */
  @list
  getAdvertisedRoutes is ArmResourceActionAsync<
    VirtualNetworkGateway,
    void,
    GatewayRouteListResult,
    Parameters = {
      /**
       * The IP address of the peer.
       */
      @query("peer")
      peer: string;
    },
    Error = CloudError
  >;

  /**
   * This operation retrieves the resiliency information for an Express Route Gateway, including the gateway's current resiliency score and recommendations to further improve the score
   */
  getResiliencyInformation is ArmResourceActionAsync<
    VirtualNetworkGateway,
    void,
    GatewayResiliencyInformation,
    Parameters = {
      /**
       * Attempt to recalculate the Resiliency Information for the gateway
       */
      @query("attemptRefresh")
      attemptRefresh?: boolean;
    },
    Error = CloudError
  >;

  /**
   * This operation retrieves the route set information for an Express Route Gateway based on their resiliency
   */
  getRoutesInformation is ArmResourceActionAsync<
    VirtualNetworkGateway,
    void,
    GatewayRouteSetsInformation,
    Parameters = {
      /**
       * Attempt to recalculate the Route Sets Information for the gateway
       */
      @query("attemptRefresh")
      attemptRefresh?: boolean;
    },
    Error = CloudError
  >;

  /**
   * The Set VpnclientIpsecParameters operation sets the vpnclient ipsec policy for P2S client of virtual network gateway in the specified resource group through Network resource provider.
   */
  @action("setvpnclientipsecparameters")
  setVpnclientIpsecParameters is ArmResourceActionAsync<
    VirtualNetworkGateway,
    VpnClientIPsecParameters,
    VpnClientIPsecParameters,
    Error = CloudError
  >;

  /**
   * The Get VpnclientIpsecParameters operation retrieves information about the vpnclient ipsec policy for P2S client of virtual network gateway in the specified resource group through Network resource provider.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("getvpnclientipsecparameters")
  getVpnclientIpsecParameters is ArmResourceActionAsyncBase<
    VirtualNetworkGateway,
    void,
    Response = VpnClientIPsecParameters &
      ArmLroLocationHeader<FinalResult = VpnClientIPsecParameters> &
      Azure.Core.Foundations.RetryAfterHeader,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VirtualNetworkGateway>,
    Error = CloudError
  >;

  /**
   * Starts packet capture on virtual network gateway in the specified resource group.
   */
  startPacketCapture is ArmResourceActionAsync<
    VirtualNetworkGateway,
    VpnPacketCaptureStartParameters,
    {
      @body body: stringApplicationJson;
    },
    OptionalRequestBody = true,
    Error = Error
  >;

  /**
   * Stops packet capture on virtual network gateway in the specified resource group.
   */
  stopPacketCapture is ArmResourceActionAsync<
    VirtualNetworkGateway,
    VpnPacketCaptureStopParameters,
    {
      @body body: stringApplicationJson;
    },
    Error = Error
  >;

  /**
   * This operation retrieves the details of all the failover tests performed on the gateway for different peering locations
   */
  @action("getFailoverAllTestsDetails")
  getFailoverAllTestDetails is ArmResourceActionAsync<
    VirtualNetworkGateway,
    void,
    Response = {
      #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body body: ExpressRouteFailoverAllTestDetails;
    },
    Parameters = {
      /**
       * The type of failover test
       */
      @query("type")
      type: string;

      /**
       * Fetch only the latest tests for each peering location
       */
      @query("fetchLatest")
      fetchLatest: boolean;
    },
    Error = CloudError
  >;

  /**
   * This operation retrieves the details of a particular failover test performed on the gateway based on the test Guid
   */
  getFailoverSingleTestDetails is ArmResourceActionAsync<
    VirtualNetworkGateway,
    void,
    Response = {
      #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body body: ExpressRouteFailoverSingleTestDetailsObject;
    },
    Parameters = {
      /**
       * Peering location of the test
       */
      @query("peeringLocation")
      peeringLocation: string;

      /**
       * The unique Guid value which identifies the test
       */
      @query("failoverTestId")
      failoverTestId: string;
    },
    Error = CloudError
  >;

  /**
   * This operation starts failover simulation on the gateway for the specified peering location
   */
  @action("startSiteFailoverTest")
  startExpressRouteSiteFailoverSimulation is ArmResourceActionAsync<
    VirtualNetworkGateway,
    void,
    {
      @body body: stringApplicationJson;
    },
    Parameters = {
      /**
       * Peering location of the test
       */
      @query("peeringLocation")
      peeringLocation: string;
    },
    Error = CloudError
  >;

  /**
   * This operation stops failover simulation on the gateway for the specified peering location
   */
  @action("stopSiteFailoverTest")
  stopExpressRouteSiteFailoverSimulation is ArmResourceActionAsync<
    VirtualNetworkGateway,
    ExpressRouteFailoverStopApiParameters,
    {
      @body body: stringApplicationJson;
    },
    Error = CloudError
  >;

  /**
   * Get VPN client connection health detail per P2S client connection of the virtual network gateway in the specified resource group.
   */
  @list
  @action("getVpnClientConnectionHealth")
  getVpnclientConnectionHealth is ArmResourceActionAsync<
    VirtualNetworkGateway,
    void,
    VpnClientConnectionHealthDetailListResult,
    Error = CloudError
  >;

  /**
   * Disconnect vpn connections of virtual network gateway in the specified resource group.
   */
  disconnectVirtualNetworkGatewayVpnConnections is ArmResourceActionAsync<
    VirtualNetworkGateway,
    P2SVpnConnectionRequest,
    Response = {
      @body body: void;
    },
    Error = CloudError
  >;

  /**
   * Trigger prepare migration for the virtual network gateway.
   */
  @action("prepareMigration")
  invokePrepareMigration is ArmResourceActionAsyncBase<
    VirtualNetworkGateway,
    Request = VirtualNetworkGatewayMigrationParameters,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VirtualNetworkGateway>,
    Error = CloudError
  >;

  /**
   * Trigger execute migration for the virtual network gateway.
   */
  @action("executeMigration")
  invokeExecuteMigration is ArmResourceActionAsyncBase<
    VirtualNetworkGateway,
    Request = void,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VirtualNetworkGateway>,
    Error = CloudError
  >;

  /**
   * Trigger commit migration for the virtual network gateway.
   */
  @action("commitMigration")
  invokeCommitMigration is ArmResourceActionAsyncBase<
    VirtualNetworkGateway,
    Request = void,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VirtualNetworkGateway>,
    Error = CloudError
  >;

  /**
   * Trigger abort migration for the virtual network gateway.
   */
  @action("abortMigration")
  invokeAbortMigration is ArmResourceActionAsyncBase<
    VirtualNetworkGateway,
    Request = void,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VirtualNetworkGateway>,
    Error = CloudError
  >;
}

@@doc(VirtualNetworkGateway.name, "The name of the virtual network gateway.");
@@doc(VirtualNetworkGateway.properties,
  "Properties of the virtual network gateway."
);
@@doc(VirtualNetworkGateways.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update virtual network gateway operation."
);
@@doc(VirtualNetworkGateways.updateTags::parameters.properties,
  "Parameters supplied to update virtual network gateway tags."
);
@@doc(VirtualNetworkGateways.generatevpnclientpackage::parameters.body,
  "Parameters supplied to the generate virtual network gateway VPN client package operation."
);
@@doc(VirtualNetworkGateways.generateVpnProfile::parameters.body,
  "Parameters supplied to the generate virtual network gateway VPN client package operation."
);
@@doc(VirtualNetworkGateways.setVpnclientIpsecParameters::parameters.body,
  "Parameters supplied to the Begin Set vpnclient ipsec parameters of Virtual Network Gateway P2S client operation through Network resource provider."
);
@@doc(VirtualNetworkGateways.startPacketCapture::parameters.body,
  "Virtual network gateway packet capture parameters supplied to start packet capture on gateway."
);
@@doc(VirtualNetworkGateways.stopPacketCapture::parameters.body,
  "Virtual network gateway packet capture parameters supplied to stop packet capture on gateway."
);
@@doc(VirtualNetworkGateways.stopExpressRouteSiteFailoverSimulation::parameters.body,
  "Virtual network gateway stop simulation parameters supplied to stop failover simulation on gateway."
);
@@doc(VirtualNetworkGateways.disconnectVirtualNetworkGatewayVpnConnections::parameters.body,
  "The parameters are supplied to disconnect vpn connections."
);
@@doc(VirtualNetworkGateways.invokePrepareMigration::parameters.body,
  "Parameters supplied to the Begin Prepare migration on basic vpn gateway through Network resource provider."
);
