// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Peering;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface CdnPeeringPrefixesOperationGroup {
  /**
   * Lists all of the advertised prefixes for the specified peering location
   */
  @autoRoute
  @list
  @get
  @action("cdnPeeringPrefixes")
  list is ArmProviderActionSync<
    Response = ResourceListResult<CdnPeeringPrefix>,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The peering location.
       */
      @query("peeringLocation")
      peeringLocation: string;
    }
  >;
}

@doc("Response for checking service provider availability")
union CheckServiceProviderAvailabilityResponse {
  string,

  @doc("available")
  "Available",

  @doc("unavailable")
  "Unavailable",
}

/**
 * Checks if the peering service provider is present within 1000 miles of customer's location
 */
@autoRoute
op checkServiceProviderAvailability is ArmProviderActionSync<
  Request = CheckServiceProviderAvailabilityInput,
  Response = {
    @header contentType: "application/json";
    @body body: CheckServiceProviderAvailabilityResponse;
  },
  Scope = SubscriptionActionScope
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface LegacyPeeringsOperationGroup {
  /**
   * Lists all of the legacy peerings under the given subscription matching the specified kind and location.
   */
  @autoRoute
  @get
  @list
  @action("legacyPeerings")
  list is ArmProviderActionSync<
    Response = ResourceListResult<Peering>,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The location of the peering.
       */
      @query("peeringLocation")
      peeringLocation: string;

      /**
       * The kind of the peering.
       */
      @query("kind")
      kind: LegacyPeeringsKind;

      /**
       * The ASN number associated with a legacy peering.
       */
      @query("asn")
      asn?: int32;

      /**
       * The direct peering type.
       */
      @query("directPeeringType")
      directPeeringType?: DirectPeeringType;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface LookingGlassOperationGroup {
  /**
   * Run looking glass functionality
   */
  @autoRoute
  @action("lookingGlass")
  invoke is ArmProviderActionSync<
    Response = LookingGlassOutput,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The command to be executed: ping, traceroute, bgpRoute.
       */
      @query("command")
      command: LookingGlassCommand;

      /**
       * The type of the source: Edge site or Azure Region.
       */
      @query("sourceType")
      sourceType: LookingGlassSourceType;

      /**
       * The location of the source.
       */
      @query("sourceLocation")
      sourceLocation: string;

      /**
       * The IP address of the destination.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing parameter name"
      @query("destinationIP")
      destinationIP: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PeeringLocationsOperationGroup {
  /**
   * Lists all of the available peering locations for the specified kind of peering.
   */
  @autoRoute
  @get
  @list
  @action("peeringLocations")
  list is ArmProviderActionSync<
    Response = ResourceListResult<PeeringLocation>,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The kind of the peering.
       */
      @query("kind")
      kind: PeeringLocationsKind;

      /**
       * The type of direct peering.
       */
      @query("directPeeringType")
      directPeeringType?: PeeringLocationsDirectPeeringType;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PeeringServiceCountriesOperationGroup {
  /**
   * Lists all of the available countries for peering service.
   */
  @autoRoute
  @get
  @list
  @action("peeringServiceCountries")
  list is ArmProviderActionSync<
    Response = ResourceListResult<PeeringServiceCountry>,
    Scope = SubscriptionActionScope
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PeeringServiceLocationsOperationGroup {
  /**
   * Lists all of the available locations for peering service.
   */
  @autoRoute
  @get
  @list
  @action("peeringServiceLocations")
  list is ArmProviderActionSync<
    Response = ResourceListResult<PeeringServiceLocation>,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The country of interest, in which the locations are to be present.
       */
      @query("country")
      country?: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PeeringServiceProvidersOperationGroup {
  /**
   * Lists all of the available peering service locations for the specified kind of peering.
   */
  @autoRoute
  @get
  @list
  @action("peeringServiceProviders")
  list is ArmProviderActionSync<
    Response = ResourceListResult<PeeringServiceProvider>,
    Scope = SubscriptionActionScope
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PeeringServicesOperationGroup {
  /**
   * Initialize Peering Service for Connection Monitor functionality
   */
  @autoRoute
  initializeConnectionMonitor is ArmProviderActionSync<
    Response = OkResponse,
    Scope = SubscriptionActionScope
  >;
}
