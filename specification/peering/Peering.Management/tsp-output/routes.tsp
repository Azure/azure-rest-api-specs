import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace PeeringManagementClient;

interface CdnPeeringPrefixesOperations {
  @doc("Lists all of the advertised prefixes for the specified peering location")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/cdnPeeringPrefixes")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The peering location.")
      @query
      peeringLocation: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    CdnPeeringPrefixListResult
  >;
}

@doc("""
Checks if the peering service provider is present within 1000 miles of
customer's location
""")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/checkServiceProviderAvailability")
@post
op CheckServiceProviderAvailability is Azure.Core.Foundations.Operation<
  {
    @doc("The Azure subscription ID.")
    @path
    subscriptionId: string;

    @doc("""
The CheckServiceProviderAvailabilityInput indicating customer location and
service provider.
""")
    @body
    checkServiceProviderAvailabilityInput: CheckServiceProviderAvailabilityInput;
  },
  void
>;

interface LegacyPeeringsOperations {
  @doc("""
Lists all of the legacy peerings under the given subscription matching the
specified kind and location.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/legacyPeerings")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The location of the peering.")
      @query
      peeringLocation: string;

      @doc("The kind of the peering.")
      @query
      kind: LegacyPeeringsKind;

      @doc("The ASN number associated with a legacy peering.")
      @query
      asn: int32;

      @doc("The direct peering type.")
      @query
      directPeeringType: DirectPeeringType;

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
      @query
      command: LookingGlassCommand;

      @doc("The type of the source: Edge site or Azure Region.")
      @query
      sourceType: LookingGlassSourceType;

      @doc("The location of the source.")
      @query
      sourceLocation: string;

      @doc("The IP address of the destination.")
      @query
      destinationIP: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    LookingGlassOutput
  >;
}

interface OperationsOperations {
  @doc("Lists all of the available API operations for peering resources.")
  @route("/providers/Microsoft.Peering/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface PeerAsnsOperations {
  @doc("Gets the peer ASN with the specified name under the given subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/peerAsns/{peerAsnName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The peer ASN name.")
      @path
      peerAsnName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeerAsn
  >;

  @doc("""
Creates a new peer ASN or updates an existing peer ASN with the specified name
under the given subscription.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/peerAsns/{peerAsnName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The peer ASN name.")
      @path
      peerAsnName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The peer ASN.")
      @body
      peerAsn: PeerAsn;
    },
    PeerAsn
  >;

  @doc("""
Deletes an existing peer ASN with the specified name under the given
subscription.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/peerAsns/{peerAsnName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The peer ASN name.")
      @path
      peerAsnName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Lists all of the peer ASNs under the given subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/peerAsns")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeerAsnListResult
  >;
}

interface PeeringLocationsOperations {
  @doc("Lists all of the available peering locations for the specified kind of peering.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/peeringLocations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The kind of the peering.")
      @query
      kind: PeeringLocationsKind;

      @doc("The type of direct peering.")
      @query
      directPeeringType: PeeringLocationsDirectPeeringType;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringLocationListResult
  >;
}

interface RegisteredAsnsOperations {
  @doc("""
Gets an existing registered ASN with the specified name under the given
subscription, resource group and peering.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peerings/{peeringName}/registeredAsns/{registeredAsnName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering.")
      @path
      peeringName: string;

      @doc("The name of the registered ASN.")
      @path
      registeredAsnName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringRegisteredAsn
  >;

  @doc("""
Creates a new registered ASN with the specified name under the given
subscription, resource group and peering.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peerings/{peeringName}/registeredAsns/{registeredAsnName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering.")
      @path
      peeringName: string;

      @doc("The name of the ASN.")
      @path
      registeredAsnName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The properties needed to create a registered ASN.")
      @body
      registeredAsn: PeeringRegisteredAsn;
    },
    PeeringRegisteredAsn
  >;

  @doc("""
Deletes an existing registered ASN with the specified name under the given
subscription, resource group and peering.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peerings/{peeringName}/registeredAsns/{registeredAsnName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering.")
      @path
      peeringName: string;

      @doc("The name of the registered ASN.")
      @path
      registeredAsnName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("""
Lists all registered ASNs under the given subscription, resource group and
peering.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peerings/{peeringName}/registeredAsns")
  @get
  ListByPeering is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering.")
      @path
      peeringName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringRegisteredAsnListResult
  >;
}

interface RegisteredPrefixesOperations {
  @doc("""
Gets an existing registered prefix with the specified name under the given
subscription, resource group and peering.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peerings/{peeringName}/registeredPrefixes/{registeredPrefixName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering.")
      @path
      peeringName: string;

      @doc("The name of the registered prefix.")
      @path
      registeredPrefixName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringRegisteredPrefix
  >;

  @doc("""
Creates a new registered prefix with the specified name under the given
subscription, resource group and peering.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peerings/{peeringName}/registeredPrefixes/{registeredPrefixName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering.")
      @path
      peeringName: string;

      @doc("The name of the registered prefix.")
      @path
      registeredPrefixName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The properties needed to create a registered prefix.")
      @body
      registeredPrefix: PeeringRegisteredPrefix;
    },
    PeeringRegisteredPrefix
  >;

  @doc("""
Deletes an existing registered prefix with the specified name under the given
subscription, resource group and peering.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peerings/{peeringName}/registeredPrefixes/{registeredPrefixName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering.")
      @path
      peeringName: string;

      @doc("The name of the registered prefix.")
      @path
      registeredPrefixName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("""
Lists all registered prefixes under the given subscription, resource group and
peering.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peerings/{peeringName}/registeredPrefixes")
  @get
  ListByPeering is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering.")
      @path
      peeringName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringRegisteredPrefixListResult
  >;

  @doc("""
Validates an existing registered prefix with the specified name under the given
subscription, resource group and peering.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peerings/{peeringName}/registeredPrefixes/{registeredPrefixName}/validate")
  @post
  Validate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering.")
      @path
      peeringName: string;

      @doc("The name of the registered prefix.")
      @path
      registeredPrefixName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringRegisteredPrefix
  >;
}

interface PeeringsOperations {
  @doc("""
Gets an existing peering with the specified name under the given subscription
and resource group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peerings/{peeringName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering.")
      @path
      peeringName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    Peering
  >;

  @doc("""
Creates a new peering or updates an existing peering with the specified name
under the given subscription and resource group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peerings/{peeringName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering.")
      @path
      peeringName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The properties needed to create or update a peering.")
      @body
      peering: Peering;
    },
    Peering
  >;

  @doc("""
Deletes an existing peering with the specified name under the given
subscription and resource group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peerings/{peeringName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering.")
      @path
      peeringName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("""
Updates tags for a peering with the specified name under the given subscription
and resource group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peerings/{peeringName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering.")
      @path
      peeringName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The resource tags.")
      @body
      tags: ResourceTags;
    },
    Peering
  >;

  @doc("Lists all of the peerings under the given subscription and resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peerings")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringListResult
  >;

  @doc("Lists all of the peerings under the given subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/peerings")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringListResult
  >;
}

interface ReceivedRoutesOperations {
  @doc("""
Lists the prefixes received over the specified peering under the given
subscription and resource group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peerings/{peeringName}/receivedRoutes")
  @get
  ListByPeering is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering.")
      @path
      peeringName: string;

      @doc("The optional prefix that can be used to filter the routes.")
      @query
      prefix: string;

      @doc("The optional AS path that can be used to filter the routes.")
      @query
      asPath: string;

      @doc("The optional origin AS validation state that can be used to filter the routes.")
      @query
      originAsValidationState: string;

      @doc("The optional RPKI validation state that can be used to filter the routes.")
      @query
      rpkiValidationState: string;

      @doc("""
The optional page continuation token that is used in the event of paginated
result.
""")
      @query
      $skipToken: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringReceivedRouteListResult
  >;
}

interface ConnectionMonitorTestsOperations {
  @doc("""
Gets an existing connection monitor test with the specified name under the
given subscription, resource group and peering service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peeringServices/{peeringServiceName}/connectionMonitorTests/{connectionMonitorTestName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering service.")
      @path
      peeringServiceName: string;

      @doc("The name of the connection monitor test")
      @path
      connectionMonitorTestName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    ConnectionMonitorTest
  >;

  @doc("""
Creates or updates a connection monitor test with the specified name under the
given subscription, resource group and peering service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peeringServices/{peeringServiceName}/connectionMonitorTests/{connectionMonitorTestName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering service.")
      @path
      peeringServiceName: string;

      @doc("The name of the connection monitor test")
      @path
      connectionMonitorTestName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The properties needed to create a connection monitor test")
      @body
      connectionMonitorTest: ConnectionMonitorTest;
    },
    ConnectionMonitorTest
  >;

  @doc("""
Deletes an existing connection monitor test with the specified name under the
given subscription, resource group and peering service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peeringServices/{peeringServiceName}/connectionMonitorTests/{connectionMonitorTestName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering service.")
      @path
      peeringServiceName: string;

      @doc("The name of the connection monitor test")
      @path
      connectionMonitorTestName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("""
Lists all connection monitor tests under the given subscription, resource group
and peering service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peeringServices/{peeringServiceName}/connectionMonitorTests")
  @get
  ListByPeeringService is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering service.")
      @path
      peeringServiceName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    ConnectionMonitorTestListResult
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
      @query
      country: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringServiceLocationListResult
  >;
}

interface PrefixesOperations {
  @doc("""
Gets an existing prefix with the specified name under the given subscription,
resource group and peering service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peeringServices/{peeringServiceName}/prefixes/{prefixName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering service.")
      @path
      peeringServiceName: string;

      @doc("The name of the prefix.")
      @path
      prefixName: string;

      @doc("The properties to be expanded.")
      @query
      $expand: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringServicePrefix
  >;

  @doc("""
Creates a new prefix with the specified name under the given subscription,
resource group and peering service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peeringServices/{peeringServiceName}/prefixes/{prefixName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering service.")
      @path
      peeringServiceName: string;

      @doc("The name of the prefix.")
      @path
      prefixName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The properties needed to create a prefix.")
      @body
      peeringServicePrefix: PeeringServicePrefix;
    },
    PeeringServicePrefix
  >;

  @doc("""
Deletes an existing prefix with the specified name under the given
subscription, resource group and peering service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peeringServices/{peeringServiceName}/prefixes/{prefixName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering service.")
      @path
      peeringServiceName: string;

      @doc("The name of the prefix.")
      @path
      prefixName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("""
Lists all prefixes under the given subscription, resource group and peering
service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peeringServices/{peeringServiceName}/prefixes")
  @get
  ListByPeeringService is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering service.")
      @path
      peeringServiceName: string;

      @doc("The properties to be expanded.")
      @query
      $expand: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringServicePrefixListResult
  >;
}

interface PeeringServiceProvidersOperations {
  @doc("""
Lists all of the available peering service locations for the specified kind of
peering.
""")
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

interface PeeringServicesOperations {
  @doc("""
Gets an existing peering service with the specified name under the given
subscription and resource group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peeringServices/{peeringServiceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering.")
      @path
      peeringServiceName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringService
  >;

  @doc("""
Creates a new peering service or updates an existing peering with the specified
name under the given subscription and resource group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peeringServices/{peeringServiceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering service.")
      @path
      peeringServiceName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The properties needed to create or update a peering service.")
      @body
      peeringService: PeeringService;
    },
    PeeringService
  >;

  @doc("""
Deletes an existing peering service with the specified name under the given
subscription and resource group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peeringServices/{peeringServiceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering service.")
      @path
      peeringServiceName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("""
Updates tags for a peering service with the specified name under the given
subscription and resource group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peeringServices/{peeringServiceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering service.")
      @path
      peeringServiceName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The resource tags.")
      @body
      tags: ResourceTags;
    },
    PeeringService
  >;

  @doc("""
Lists all of the peering services under the given subscription and resource
group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peeringServices")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringServiceListResult
  >;

  @doc("Lists all of the peerings under the given subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/peeringServices")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringServiceListResult
  >;

  @doc("Initialize Peering Service for Connection Monitor functionality")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Peering/initializeConnectionMonitor")
  @post
  InitializeConnectionMonitor is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface RpUnbilledPrefixesOperations {
  @doc("Lists all of the RP unbilled prefixes for the specified peering")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peerings/{peeringName}/rpUnbilledPrefixes")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure resource group name.")
      @path
      resourceGroupName: string;

      @doc("The peering name.")
      @path
      peeringName: string;

      @doc("Flag to enable consolidation prefixes")
      @query
      consolidate: boolean;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    RpUnbilledPrefixListResult
  >;
}
