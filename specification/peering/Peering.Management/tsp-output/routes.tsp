import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Peering;

interface CdnPeeringPrefixesOperations {
  /**
   * Lists all of the advertised prefixes for the specified peering location
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/cdnPeeringPrefixes")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The peering location.
       */
      @query("peeringLocation")
      peeringLocation: string;

      /**
       * The Azure subscription ID.
       */
      @path
      subscriptionId: string;
    },
    CdnPeeringPrefixListResult
  >;
}

/**
 * Checks if the peering service provider is present within 1000 miles of customer's location
 */
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/checkServiceProviderAvailability")
@post
op checkServiceProviderAvailability is Azure.Core.Foundations.Operation<
  {
    /**
     * The Azure subscription ID.
     */
    @path
    subscriptionId: string;

    /**
     * The CheckServiceProviderAvailabilityInput indicating customer location and service provider.
     */
    @body
    checkServiceProviderAvailabilityInput: CheckServiceProviderAvailabilityInput;
  },
  void
>;

interface LegacyPeeringsOperations {
  /**
   * Lists all of the legacy peerings under the given subscription matching the specified kind and location.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/legacyPeerings")
  @get
  list is Azure.Core.Foundations.Operation<
    {
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

      /**
       * The Azure subscription ID.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<Peering>
  >;
}

interface LookingGlassOperations {
  /**
   * Run looking glass functionality
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/lookingGlass")
  @post
  invoke is Azure.Core.Foundations.Operation<
    {
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
      @query("destinationIP")
      destinationIP: string;

      /**
       * The Azure subscription ID.
       */
      @path
      subscriptionId: string;
    },
    LookingGlassOutput
  >;
}

interface PeeringLocationsOperations {
  /**
   * Lists all of the available peering locations for the specified kind of peering.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/peeringLocations")
  @get
  list is Azure.Core.Foundations.Operation<
    {
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

      /**
       * The Azure subscription ID.
       */
      @path
      subscriptionId: string;
    },
    PeeringLocationListResult
  >;
}

interface PeeringServiceCountriesOperations {
  /**
   * Lists all of the available countries for peering service.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/peeringServiceCountries")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The Azure subscription ID.
       */
      @path
      subscriptionId: string;
    },
    PeeringServiceCountryListResult
  >;
}

interface PeeringServiceLocationsOperations {
  /**
   * Lists all of the available locations for peering service.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/peeringServiceLocations")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The country of interest, in which the locations are to be present.
       */
      @query("country")
      country?: string;

      /**
       * The Azure subscription ID.
       */
      @path
      subscriptionId: string;
    },
    PeeringServiceLocationListResult
  >;
}

interface PeeringServiceProvidersOperations {
  /**
   * Lists all of the available peering service locations for the specified kind of peering.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/peeringServiceProviders")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The Azure subscription ID.
       */
      @path
      subscriptionId: string;
    },
    PeeringServiceProviderListResult
  >;
}
