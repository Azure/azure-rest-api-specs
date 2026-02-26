import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Peering, "PeeringManagementClient", "python,javascript");
@@clientName(Microsoft.Peering.CheckServiceProviderAvailabilityResponse,
  "Enum0",
  "go, javascript"
);

@@clientName(Microsoft.Peering.PeeringPropertiesDirect,
  "DirectPeeringProperties ",
  "csharp"
);
@@clientName(Microsoft.Peering.PeeringPropertiesExchange,
  "ExchangePeeringProperties",
  "csharp"
);
@@clientName(Microsoft.Peering.DirectConnection,
  "PeeringDirectConnection ",
  "csharp"
);
@@clientName(Microsoft.Peering.ExchangeConnection,
  "PeeringExchangeConnection ",
  "csharp"
);
@@clientName(Microsoft.Peering.PeeringLocationPropertiesDirect,
  "DirectPeeringLocationProperties",
  "csharp"
);
@@clientName(Microsoft.Peering.LogAnalyticsWorkspaceProperties,
  "PeeringLogAnalyticsWorkspaceProperties",
  "csharp"
);
@@clientName(Microsoft.Peering.BgpSession, "PeeringBgpSession", "csharp");
@@clientName(Microsoft.Peering.ContactDetail, "PeerAsnContactDetail", "csharp");
@@clientName(Microsoft.Peering.ResourceTags,
  "PeeringResourceTagsPatch",
  "csharp"
);
@@clientName(Microsoft.Peering.RpUnbilledPrefix,
  "RoutingPreferenceUnbilledPrefix",
  "csharp"
);
@@clientName(Microsoft.Peering.CheckServiceProviderAvailabilityInput,
  "CheckPeeringServiceProviderAvailabilityContent",
  "csharp"
);
@@clientName(Microsoft.Peering.CheckServiceProviderAvailabilityResponse,
  "PeeringServiceProviderAvailability",
  "csharp"
);

@@clientName(Microsoft.Peering.ProvisioningState,
  "PeeringProvisioningState",
  "csharp"
);
@@clientName(Microsoft.Peering.SessionAddressProvider,
  "PeeringSessionAddressProvider",
  "csharp"
);
@@clientName(Microsoft.Peering.SessionStateV4,
  "PeeringSessionStateV4",
  "csharp"
);
@@clientName(Microsoft.Peering.SessionStateV6,
  "PeeringSessionStateV6",
  "csharp"
);
@@clientName(Microsoft.Peering.ConnectionState,
  "PeeringConnectionState",
  "csharp"
);
@@clientName(Microsoft.Peering.PrefixValidationState,
  "PeeringPrefixValidationState",
  "csharp"
);
@@clientName(Microsoft.Peering.LearnedType, "PeeringLearnedType", "csharp");
@@clientName(Microsoft.Peering.ValidationState,
  "PeeringValidationState",
  "csharp"
);
@@clientName(Microsoft.Peering.ValidationState,
  "PeerAsnValidationState",
  "csharp"
);
@@clientName(Microsoft.Peering.Tier, "PeeringTier", "csharp");
@@clientName(Microsoft.Peering.Size, "PeeringSize", "csharp");
@@clientName(Microsoft.Peering.Family, "PeeringFamily", "csharp");
@@clientName(Microsoft.Peering.Role, "PeeringRole", "csharp");

@@clientName(Microsoft.Peering.PeeringLocationProperties.peeringLocation,
  "PeeringLocationValue",
  "csharp"
);
@@clientName(Microsoft.Peering.PeeringPropertiesDirect.peerAsn,
  "peerAsnId",
  "csharp"
);
@@clientName(Microsoft.Peering.PeeringPropertiesExchange.peerAsn,
  "peerAsnId",
  "csharp"
);
@@clientName(Microsoft.Peering.LogAnalyticsWorkspaceProperties.workspaceID,
  "workspaceId",
  "csharp"
);

@@clientName(Microsoft.Peering.checkServiceProviderAvailability,
  "CheckPeeringServiceProviderAvailability",
  "csharp"
);
@@clientName(Microsoft.Peering.PeeringServicesOperationGroup.initializeConnectionMonitor,
  "initializePeeringServiceConnectionMonitor",
  "csharp"
);
@@clientName(Microsoft.Peering.LookingGlassOperationGroup.invoke,
  "invokeLookingGlass",
  "csharp"
);
@@clientName(Microsoft.Peering.Peerings.listByPeering,
  "listReceivedRoutes",
  "csharp"
);
@@clientName(Microsoft.Peering.Peerings.list,
  "listRpUnbilledPrefixes",
  "csharp"
);
@@clientName(Microsoft.Peering.LegacyPeeringsOperationGroup.list,
  "listPeeringsByLegacyPeering",
  "csharp"
);
@@clientName(Microsoft.Peering.PeeringLocationsOperationGroup.list,
  "listPeeringLocations",
  "csharp"
);
@@clientName(Microsoft.Peering.CdnPeeringPrefixesOperationGroup.list,
  "listCdnPeeringPrefixes",
  "csharp"
);
@@clientName(Microsoft.Peering.PeeringServiceLocationsOperationGroup.list,
  "listPeeringServiceLocations",
  "csharp"
);
@@clientName(Microsoft.Peering.PeeringServiceCountriesOperationGroup.list,
  "listPeeringServiceCountries",
  "csharp"
);
@@clientName(Microsoft.Peering.PeeringServiceProvidersOperationGroup.list,
  "listPeeringServiceProviders",
  "csharp"
);

@@clientName(Microsoft.Peering.ConnectivityProbe,
  "PeeringConnectivityProbe",
  "csharp"
);

@@clientName(Microsoft.Peering.Protocol, "PeeringProtocol ", "csharp");

@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.Peering.PeeringPropertiesDirect.peerAsn,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.Peering.PeeringPropertiesExchange.peerAsn,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.Peering.PeeringServiceLocationProperties.azureRegion,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(Microsoft.Peering.PeeringLocationProperties.azureRegion,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(Microsoft.Peering.CdnPeeringPrefixProperties.azureRegion,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(Microsoft.Peering.RpUnbilledPrefix.azureRegion,
  Azure.Core.azureLocation,
  "csharp"
);

@@alternateType(Microsoft.Peering.ExchangeConnection.connectionIdentifier,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(Microsoft.Peering.ExchangePeeringFacility.microsoftIPv4Address,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(Microsoft.Peering.ExchangePeeringFacility.microsoftIPv6Address,
  Azure.Core.ipV6Address,
  "csharp"
);
@@alternateType(Microsoft.Peering.BgpSession.microsoftSessionIPv4Address,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(Microsoft.Peering.BgpSession.microsoftSessionIPv6Address,
  Azure.Core.ipV6Address,
  "csharp"
);
@@alternateType(Microsoft.Peering.BgpSession.peerSessionIPv4Address,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(Microsoft.Peering.BgpSession.peerSessionIPv6Address,
  Azure.Core.ipV6Address,
  "csharp"
);

@@alternateType(Microsoft.Peering.LookingGlassOutput.command,
  Microsoft.Peering.LookingGlassCommand,
  "csharp"
);

@@usage(Microsoft.Peering.PeeringServiceLocation,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(Microsoft.Peering.PeeringServiceProvider,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(Microsoft.Peering.LogAnalyticsWorkspaceProperties,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(Microsoft.Peering.PeeringProperties,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(Microsoft.Peering.PeeringPropertiesExchange,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(Microsoft.Peering.PeeringBandwidthOffer,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(Microsoft.Peering.ExchangePeeringFacility,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(Microsoft.Peering.DirectPeeringFacility,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(Microsoft.Peering.ExchangeConnection,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(Microsoft.Peering.PeeringLocation,
  Usage.input | Usage.output,
  "csharp"
);
