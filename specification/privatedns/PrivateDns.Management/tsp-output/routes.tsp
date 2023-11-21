import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace PrivateDnsManagementClient;

interface PrivateZonesOperations {
  @doc("""
Creates or updates a Private DNS zone. Does not modify Links to virtual
networks or DNS records within the zone.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateDnsZones/{privateZoneName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the Private DNS zone (without a terminating dot).")
      @path
      privateZoneName: string;

      @doc("""
The ETag of the Private DNS zone. Omit this value to always overwrite the
current zone. Specify the last-seen ETag value to prevent accidentally
overwriting any concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Set to '*' to allow a new Private DNS zone to be created, but to prevent
updating an existing zone. Other values will be ignored.
""")
      @header
      `If-None-Match`: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the CreateOrUpdate operation.")
      @body
      parameters: PrivateZone;
    },
    PrivateZone | void
  >;

  @doc("""
Updates a Private DNS zone. Does not modify virtual network links or DNS
records within the zone.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateDnsZones/{privateZoneName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the Private DNS zone (without a terminating dot).")
      @path
      privateZoneName: string;

      @doc("""
The ETag of the Private DNS zone. Omit this value to always overwrite the
current zone. Specify the last-seen ETag value to prevent accidentally
overwriting any concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the Update operation.")
      @body
      parameters: PrivateZone;
    },
    PrivateZone | void
  >;

  @doc("""
Deletes a Private DNS zone. WARNING: All DNS records in the zone will also be
deleted. This operation cannot be undone. Private DNS zone cannot be deleted
unless all virtual network links to it are removed.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateDnsZones/{privateZoneName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the Private DNS zone (without a terminating dot).")
      @path
      privateZoneName: string;

      @doc("""
The ETag of the Private DNS zone. Omit this value to always delete the current
zone. Specify the last-seen ETag value to prevent accidentally deleting any
concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("""
Gets a Private DNS zone. Retrieves the zone properties, but not the virtual
networks links or the record sets within the zone.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateDnsZones/{privateZoneName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the Private DNS zone (without a terminating dot).")
      @path
      privateZoneName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    PrivateZone
  >;

  @doc("Lists the Private DNS zones in all resource groups in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Network/privateDnsZones")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The maximum number of Private DNS zones to return. If not specified, returns up
to 100 zones.
""")
      @query
      $top: int32;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    PrivateZoneListResult
  >;

  @doc("Lists the Private DNS zones within a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateDnsZones")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("""
The maximum number of record sets to return. If not specified, returns up to
100 record sets.
""")
      @query
      $top: int32;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    PrivateZoneListResult
  >;
}

interface VirtualNetworkLinksOperations {
  @doc("Creates or updates a virtual network link to the specified Private DNS zone.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateDnsZones/{privateZoneName}/virtualNetworkLinks/{virtualNetworkLinkName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the Private DNS zone (without a terminating dot).")
      @path
      privateZoneName: string;

      @doc("The name of the virtual network link.")
      @path
      virtualNetworkLinkName: string;

      @doc("""
The ETag of the virtual network link to the Private DNS zone. Omit this value
to always overwrite the current virtual network link. Specify the last-seen
ETag value to prevent accidentally overwriting any concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Set to '*' to allow a new virtual network link to the Private DNS zone to be
created, but to prevent updating an existing link. Other values will be
ignored.
""")
      @header
      `If-None-Match`: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the CreateOrUpdate operation.")
      @body
      parameters: VirtualNetworkLink;
    },
    VirtualNetworkLink | void
  >;

  @doc("Updates a virtual network link to the specified Private DNS zone.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateDnsZones/{privateZoneName}/virtualNetworkLinks/{virtualNetworkLinkName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the Private DNS zone (without a terminating dot).")
      @path
      privateZoneName: string;

      @doc("The name of the virtual network link.")
      @path
      virtualNetworkLinkName: string;

      @doc("""
The ETag of the virtual network link to the Private DNS zone. Omit this value
to always overwrite the current virtual network link. Specify the last-seen
ETag value to prevent accidentally overwriting any concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the Update operation.")
      @body
      parameters: VirtualNetworkLink;
    },
    VirtualNetworkLink | void
  >;

  @doc("""
Deletes a virtual network link to the specified Private DNS zone. WARNING: In
case of a registration virtual network, all auto-registered DNS records in the
zone for the virtual network will also be deleted. This operation cannot be
undone.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateDnsZones/{privateZoneName}/virtualNetworkLinks/{virtualNetworkLinkName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the Private DNS zone (without a terminating dot).")
      @path
      privateZoneName: string;

      @doc("The name of the virtual network link.")
      @path
      virtualNetworkLinkName: string;

      @doc("""
The ETag of the virtual network link to the Private DNS zone. Omit this value
to always delete the current zone. Specify the last-seen ETag value to prevent
accidentally deleting any concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets a virtual network link to the specified Private DNS zone.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateDnsZones/{privateZoneName}/virtualNetworkLinks/{virtualNetworkLinkName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the Private DNS zone (without a terminating dot).")
      @path
      privateZoneName: string;

      @doc("The name of the virtual network link.")
      @path
      virtualNetworkLinkName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    VirtualNetworkLink
  >;

  @doc("Lists the virtual network links to the specified Private DNS zone.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateDnsZones/{privateZoneName}/virtualNetworkLinks")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the Private DNS zone (without a terminating dot).")
      @path
      privateZoneName: string;

      @doc("""
The maximum number of virtual network links to return. If not specified,
returns up to 100 virtual network links.
""")
      @query
      $top: int32;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    VirtualNetworkLinkListResult
  >;
}

interface RecordSetsOperations {
  @doc("Creates or updates a record set within a Private DNS zone.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateDnsZones/{privateZoneName}/{recordType}/{relativeRecordSetName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the Private DNS zone (without a terminating dot).")
      @path
      privateZoneName: string;

      @doc("""
The type of DNS record in this record set. Record sets of type SOA can be
updated but not created (they are created when the Private DNS zone is
created).
""")
      @path
      recordType: RecordType;

      @doc("The name of the record set, relative to the name of the zone.")
      @path
      relativeRecordSetName: string;

      @doc("""
The ETag of the record set. Omit this value to always overwrite the current
record set. Specify the last-seen ETag value to prevent accidentally
overwriting any concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Set to '*' to allow a new record set to be created, but to prevent updating an
existing record set. Other values will be ignored.
""")
      @header
      `If-None-Match`: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the CreateOrUpdate operation.")
      @body
      parameters: RecordSet;
    },
    RecordSet
  >;

  @doc("Updates a record set within a Private DNS zone.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateDnsZones/{privateZoneName}/{recordType}/{relativeRecordSetName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the Private DNS zone (without a terminating dot).")
      @path
      privateZoneName: string;

      @doc("The type of DNS record in this record set.")
      @path
      recordType: RecordType;

      @doc("The name of the record set, relative to the name of the zone.")
      @path
      relativeRecordSetName: string;

      @doc("""
The ETag of the record set. Omit this value to always overwrite the current
record set. Specify the last-seen ETag value to prevent accidentally
overwriting concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the Update operation.")
      @body
      parameters: RecordSet;
    },
    RecordSet
  >;

  @doc("Deletes a record set from a Private DNS zone. This operation cannot be undone.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateDnsZones/{privateZoneName}/{recordType}/{relativeRecordSetName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the Private DNS zone (without a terminating dot).")
      @path
      privateZoneName: string;

      @doc("""
The type of DNS record in this record set. Record sets of type SOA cannot be
deleted (they are deleted when the Private DNS zone is deleted).
""")
      @path
      recordType: RecordType;

      @doc("The name of the record set, relative to the name of the zone.")
      @path
      relativeRecordSetName: string;

      @doc("""
The ETag of the record set. Omit this value to always delete the current record
set. Specify the last-seen ETag value to prevent accidentally deleting any
concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets a record set.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateDnsZones/{privateZoneName}/{recordType}/{relativeRecordSetName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the Private DNS zone (without a terminating dot).")
      @path
      privateZoneName: string;

      @doc("The type of DNS record in this record set.")
      @path
      recordType: RecordType;

      @doc("The name of the record set, relative to the name of the zone.")
      @path
      relativeRecordSetName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    RecordSet
  >;

  @doc("Lists the record sets of a specified type in a Private DNS zone.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateDnsZones/{privateZoneName}/{recordType}")
  @get
  ListByType is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the Private DNS zone (without a terminating dot).")
      @path
      privateZoneName: string;

      @doc("The type of record sets to enumerate.")
      @path
      recordType: RecordType;

      @doc("""
The maximum number of record sets to return. If not specified, returns up to
100 record sets.
""")
      @query
      $top: int32;

      @doc("""
The suffix label of the record set name to be used to filter the record set
enumeration. If this parameter is specified, the returned enumeration will only
contain records that end with \".<recordsetnamesuffix>\".
""")
      @query
      $recordsetnamesuffix: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    RecordSetListResult
  >;

  @doc("Lists all record sets in a Private DNS zone.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateDnsZones/{privateZoneName}/ALL")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the Private DNS zone (without a terminating dot).")
      @path
      privateZoneName: string;

      @doc("""
The maximum number of record sets to return. If not specified, returns up to
100 record sets.
""")
      @query
      $top: int32;

      @doc("""
The suffix label of the record set name to be used to filter the record set
enumeration. If this parameter is specified, the returned enumeration will only
contain records that end with \".<recordsetnamesuffix>\".
""")
      @query
      $recordsetnamesuffix: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    RecordSetListResult
  >;
}
