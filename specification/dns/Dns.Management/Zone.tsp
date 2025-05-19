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
 * Describes a DNS zone.
 */
model Zone is Azure.ResourceManager.TrackedResource<ZoneProperties> {
  ...ResourceNameParameter<
    Resource = Zone,
    KeyName = "zoneName",
    SegmentName = "dnsZones",
    NamePattern = ""
  >;

  /**
   * The etag of the zone.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface Zones {
  /**
   * Gets a DNS zone. Retrieves the zone properties, but not the record sets within the zone.
   */
  get is ArmResourceRead<Zone>;

  /**
   * Creates or updates a DNS zone. Does not modify DNS records within the zone.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Zone,
    Parameters = {
      /**
       * The etag of the DNS zone. Omit this value to always overwrite the current zone. Specify the last-seen etag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      IfMatch?: string;

      /**
       * Set to '*' to allow a new DNS zone to be created, but to prevent updating an existing zone. Other values will be ignored.
       */
      @header
      IfNoneMatch?: string;
    }
  >;

  /**
   * Updates a DNS zone. Does not modify DNS records within the zone.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Zone,
    PatchModel = ZoneUpdate,
    Parameters = {
      /**
       * The etag of the DNS zone. Omit this value to always overwrite the current zone. Specify the last-seen etag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      IfMatch?: string;
    }
  >;

  /**
   * Deletes a DNS zone. WARNING: All DNS records in the zone will also be deleted. This operation cannot be undone.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Zone,
    Parameters = {
      /**
       * The etag of the DNS zone. Omit this value to always delete the current zone. Specify the last-seen etag value to prevent accidentally deleting any concurrent changes.
       */
      @header
      IfMatch?: string;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists the DNS zones within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Zone,
    Parameters = {
      /**
       * The maximum number of record sets to return. If not specified, returns up to 100 record sets.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Lists the DNS zones in all resource groups in a subscription.
   */
  list is ArmListBySubscription<
    Zone,
    Parameters = {
      /**
       * The maximum number of DNS zones to return. If not specified, returns up to 100 zones.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Lists all record sets in a DNS zone.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("recordsets")
  @operationId("RecordSets_ListByDnsZone")
  listByDnsZone is ArmResourceActionSync<
    Zone,
    void,
    ArmResponse<ResourceListResult<RecordSet>>,
    Parameters = {
      /**
       * The maximum number of record sets to return. If not specified, returns up to 100 record sets.
       */
      @query("$top")
      $top?: int32;

      /**
       * The suffix label of the record set name that has to be used to filter the record set enumerations. If this parameter is specified, Enumeration will return only records that end with .<recordSetNameSuffix>
       */
      @query("$recordsetnamesuffix")
      $recordsetnamesuffix?: string;
    }
  >;

  /**
   * Lists all record sets in a DNS zone.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("all")
  @operationId("RecordSets_ListAllByDnsZone")
  listAllByDnsZone is ArmResourceActionSync<
    Zone,
    void,
    ArmResponse<ResourceListResult<RecordSet>>,
    Parameters = {
      /**
       * The maximum number of record sets to return. If not specified, returns up to 100 record sets.
       */
      @query("$top")
      $top?: int32;

      /**
       * The suffix label of the record set name that has to be used to filter the record set enumerations. If this parameter is specified, Enumeration will return only records that end with .<recordSetNameSuffix>
       */
      @query("$recordsetnamesuffix")
      recordSetNameSuffix?: string;
    }
  >;
}

@@doc(Zone.name, "The name of the DNS zone (without a terminating dot).");
@@doc(Zone.properties, "The properties of the zone.");
@@doc(Zones.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate operation."
);
@@doc(Zones.update::parameters.properties,
  "Parameters supplied to the Update operation."
);
