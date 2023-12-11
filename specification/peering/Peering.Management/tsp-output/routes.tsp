import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.Peering;

interface CdnPeeringPrefixesOperations {
  @doc("Lists all of the advertised prefixes for the specified peering location")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/cdnPeeringPrefixes")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The peering location.")
      @query("peeringLocation")
      peeringLocation: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    CdnPeeringPrefixListResult
  >;
}

@doc("Checks if the peering service provider is present within 1000 miles of customer's location")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/checkServiceProviderAvailability")
@post
op CheckServiceProviderAvailability is Azure.Core.Foundations.Operation<
  {
    @doc("The Azure subscription ID.")
    @path
    subscriptionId: string;

    @doc("The CheckServiceProviderAvailabilityInput indicating customer location and service provider.")
    @body
    checkServiceProviderAvailabilityInput: CheckServiceProviderAvailabilityInput;
  },
  void
>;

interface LegacyPeeringsOperations {
  @doc("Lists all of the legacy peerings under the given subscription matching the specified kind and location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/legacyPeerings")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The location of the peering.")
      @query("peeringLocation")
      peeringLocation: string;

      @doc("The kind of the peering.")
      @query("kind")
      kind: LegacyPeeringsKind;

      @doc("The ASN number associated with a legacy peering.")
      @query("asn")
      asn?: int32;

      @doc("The direct peering type.")
      @query("directPeeringType")
      directPeeringType?: DirectPeeringType;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringListResult
  >;
}

interface LookingGlassOperations {
  @doc("Run looking glass functionality")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/lookingGlass")
  @post
  Invoke is Azure.Core.Foundations.Operation<
    {
      @doc("The command to be executed: ping, traceroute, bgpRoute.")
      @query("command")
      command: LookingGlassCommand;

      @doc("The type of the source: Edge site or Azure Region.")
      @query("sourceType")
      sourceType: LookingGlassSourceType;

      @doc("The location of the source.")
      @query("sourceLocation")
      sourceLocation: string;

      @doc("The IP address of the destination.")
      @query("destinationIP")
      destinationIP: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    LookingGlassOutput
  >;
}

interface PeeringLocationsOperations {
  @doc("Lists all of the available peering locations for the specified kind of peering.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/peeringLocations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The kind of the peering.")
      @query("kind")
      kind: PeeringLocationsKind;

      @doc("The type of direct peering.")
      @query("directPeeringType")
      directPeeringType?: PeeringLocationsDirectPeeringType;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringLocationListResult
  >;
}

interface PeeringServiceCountriesOperations {
  @doc("Lists all of the available countries for peering service.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/peeringServiceCountries")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringServiceCountryListResult
  >;
}

interface PeeringServiceLocationsOperations {
  @doc("Lists all of the available locations for peering service.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/peeringServiceLocations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The country of interest, in which the locations are to be present.")
      @query("country")
      country?: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringServiceLocationListResult
  >;
}

interface PeeringServiceProvidersOperations {
  @doc("Lists all of the available peering service locations for the specified kind of peering.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/peeringServiceProviders")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringServiceProviderListResult
  >;
}
