@doc("The properties of ServerSiteResource.")
model ServerSitesProperties {
  @doc("Gets the Master Site this site is linked to.")
  @visibility("read")
  masterSiteId?: string;

  @doc("""
  Gets or sets the service principal identity details used by agent for
  communication
              to the service.
  """)
  servicePrincipalIdentityDetails?: SiteSpnProperties;

  @doc("Gets or sets the on-premises agent details.")
  agentDetails?: SiteAgentProperties;

  @doc("Gets or sets the Appliance Name.")
  applianceName?: string;

  @doc("Gets or sets the ARM ID of migration hub solution for SDS.")
  discoverySolutionId?: string;

  @doc("Gets the service endpoint.")
  @visibility("read")
  serviceEndpoint?: string;

  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Server site usage.")
model ServerSiteUsage {
@doc("Gets or sets the number of run as accounts in the site.")
"runAsAccountCount"?: int32;
@doc("Gets or sets the number of servers part of the site.")
"serverCount"?: int32;
}
