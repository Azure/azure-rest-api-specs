import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace DnsManagementClient;

interface RecordSetsOperations {
  @doc("Updates a record set within a DNS zone.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/{recordType}/{relativeRecordSetName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS zone (without a terminating dot).")
      @path
      zoneName: string;

      @doc("The name of the record set, relative to the name of the zone.")
      @path
      relativeRecordSetName: string;

      @doc("The type of DNS record in this record set.")
      @path
      recordType: RecordType;

      @doc("""
The etag of the record set. Omit this value to always overwrite the current
record set. Specify the last-seen etag value to prevent accidentally
overwriting concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Specifies the Azure subscription ID, which uniquely identifies the Microsoft
Azure subscription.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the Update operation.")
      @body
      parameters: RecordSet;
    },
    RecordSet
  >;

  @doc("Creates or updates a record set within a DNS zone.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/{recordType}/{relativeRecordSetName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS zone (without a terminating dot).")
      @path
      zoneName: string;

      @doc("The name of the record set, relative to the name of the zone.")
      @path
      relativeRecordSetName: string;

      @doc("""
The type of DNS record in this record set. Record sets of type SOA can be
updated but not created (they are created when the DNS zone is created).
""")
      @path
      recordType: RecordType;

      @doc("""
The etag of the record set. Omit this value to always overwrite the current
record set. Specify the last-seen etag value to prevent accidentally
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
Specifies the Azure subscription ID, which uniquely identifies the Microsoft
Azure subscription.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the CreateOrUpdate operation.")
      @body
      parameters: RecordSet;
    },
    RecordSet
  >;

  @doc("Deletes a record set from a DNS zone. This operation cannot be undone.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/{recordType}/{relativeRecordSetName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS zone (without a terminating dot).")
      @path
      zoneName: string;

      @doc("The name of the record set, relative to the name of the zone.")
      @path
      relativeRecordSetName: string;

      @doc("""
The type of DNS record in this record set. Record sets of type SOA cannot be
deleted (they are deleted when the DNS zone is deleted).
""")
      @path
      recordType: RecordType;

      @doc("""
The etag of the record set. Omit this value to always delete the current record
set. Specify the last-seen etag value to prevent accidentally deleting any
concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Specifies the Azure subscription ID, which uniquely identifies the Microsoft
Azure subscription.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets a record set.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/{recordType}/{relativeRecordSetName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS zone (without a terminating dot).")
      @path
      zoneName: string;

      @doc("The name of the record set, relative to the name of the zone.")
      @path
      relativeRecordSetName: string;

      @doc("The type of DNS record in this record set.")
      @path
      recordType: RecordType;

      @doc("""
Specifies the Azure subscription ID, which uniquely identifies the Microsoft
Azure subscription.
""")
      @path
      subscriptionId: string;
    },
    RecordSet
  >;

  @doc("Lists the record sets of a specified type in a DNS zone.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/{recordType}")
  @get
  ListByType is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS zone (without a terminating dot).")
      @path
      zoneName: string;

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
The suffix label of the record set name that has to be used to filter the
record set enumerations. If this parameter is specified, Enumeration will
return only records that end with .<recordSetNameSuffix>
""")
      @query
      $recordsetnamesuffix: string;

      @doc("""
Specifies the Azure subscription ID, which uniquely identifies the Microsoft
Azure subscription.
""")
      @path
      subscriptionId: string;
    },
    RecordSetListResult
  >;

  @doc("Lists all record sets in a DNS zone.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/recordsets")
  @get
  ListByDnsZone is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS zone (without a terminating dot).")
      @path
      zoneName: string;

      @doc("""
The maximum number of record sets to return. If not specified, returns up to
100 record sets.
""")
      @query
      $top: int32;

      @doc("""
The suffix label of the record set name that has to be used to filter the
record set enumerations. If this parameter is specified, Enumeration will
return only records that end with .<recordSetNameSuffix>
""")
      @query
      $recordsetnamesuffix: string;

      @doc("""
Specifies the Azure subscription ID, which uniquely identifies the Microsoft
Azure subscription.
""")
      @path
      subscriptionId: string;
    },
    RecordSetListResult
  >;

  @doc("Lists all record sets in a DNS zone.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/all")
  @get
  ListAllByDnsZone is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS zone (without a terminating dot).")
      @path
      zoneName: string;

      @doc("""
The maximum number of record sets to return. If not specified, returns up to
100 record sets.
""")
      @query
      $top: int32;

      @doc("""
The suffix label of the record set name that has to be used to filter the
record set enumerations. If this parameter is specified, Enumeration will
return only records that end with .<recordSetNameSuffix>
""")
      @query
      $recordsetnamesuffix: string;

      @doc("""
Specifies the Azure subscription ID, which uniquely identifies the Microsoft
Azure subscription.
""")
      @path
      subscriptionId: string;
    },
    RecordSetListResult
  >;
}

interface ZonesOperations {
  @doc("Creates or updates a DNS zone. Does not modify DNS records within the zone.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS zone (without a terminating dot).")
      @path
      zoneName: string;

      @doc("""
The etag of the DNS zone. Omit this value to always overwrite the current zone.
Specify the last-seen etag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Set to '*' to allow a new DNS zone to be created, but to prevent updating an
existing zone. Other values will be ignored.
""")
      @header
      `If-None-Match`: string;

      @doc("""
Specifies the Azure subscription ID, which uniquely identifies the Microsoft
Azure subscription.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the CreateOrUpdate operation.")
      @body
      parameters: Zone;
    },
    Zone
  >;

  @doc("""
Deletes a DNS zone. WARNING: All DNS records in the zone will also be deleted.
This operation cannot be undone.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS zone (without a terminating dot).")
      @path
      zoneName: string;

      @doc("""
The etag of the DNS zone. Omit this value to always delete the current zone.
Specify the last-seen etag value to prevent accidentally deleting any
concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Specifies the Azure subscription ID, which uniquely identifies the Microsoft
Azure subscription.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("""
Gets a DNS zone. Retrieves the zone properties, but not the record sets within
the zone.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS zone (without a terminating dot).")
      @path
      zoneName: string;

      @doc("""
Specifies the Azure subscription ID, which uniquely identifies the Microsoft
Azure subscription.
""")
      @path
      subscriptionId: string;
    },
    Zone
  >;

  @doc("Updates a DNS zone. Does not modify DNS records within the zone.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the DNS zone (without a terminating dot).")
      @path
      zoneName: string;

      @doc("""
The etag of the DNS zone. Omit this value to always overwrite the current zone.
Specify the last-seen etag value to prevent accidentally overwriting any
concurrent changes.
""")
      @header
      `If-Match`: string;

      @doc("""
Specifies the Azure subscription ID, which uniquely identifies the Microsoft
Azure subscription.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the Update operation.")
      @body
      parameters: ZoneUpdate;
    },
    Zone
  >;

  @doc("Lists the DNS zones within a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones")
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
Specifies the Azure subscription ID, which uniquely identifies the Microsoft
Azure subscription.
""")
      @path
      subscriptionId: string;
    },
    ZoneListResult
  >;

  @doc("Lists the DNS zones in all resource groups in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Network/dnszones")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The maximum number of DNS zones to return. If not specified, returns up to 100
zones.
""")
      @query
      $top: int32;

      @doc("""
Specifies the Azure subscription ID, which uniquely identifies the Microsoft
Azure subscription.
""")
      @path
      subscriptionId: string;
    },
    ZoneListResult
  >;
}

interface DnsResourceReferenceOperations {
  @doc("Returns the DNS records specified by the referencing targetResourceIds.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Network/getDnsResourceReference")
  @post
  GetByTargetResources is Azure.Core.Foundations.Operation<
    {
      @doc("""
Specifies the Azure subscription ID, which uniquely identifies the Microsoft
Azure subscription.
""")
      @path
      subscriptionId: string;

      @doc("Properties for dns resource reference request.")
      @body
      parameters: DnsResourceReferenceRequest;
    },
    DnsResourceReferenceResult
  >;
}
