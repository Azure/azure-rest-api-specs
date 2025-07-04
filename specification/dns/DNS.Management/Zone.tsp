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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Private.armResourceInternal(ZoneProperties)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
model Zone extends Foundations.TrackedResource {
  ...ResourceNameParameter<
    Resource = Zone,
    KeyName = "zoneName",
    SegmentName = "dnsZones",
    NamePattern = ""
  >;

  /**
   * The etag of the zone.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  /*
   * The properties of the zone.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ZoneProperties;
}

@armResourceOperations
interface Zones {
  /**
   * Gets a DNS zone. Retrieves the zone properties, but not the record sets within the zone.
   */
  get is ArmResourceRead<Zone, Error = CloudError>;

  /**
   * Creates or updates a DNS zone. Does not modify DNS records within the zone.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Zone,
    Parameters = {
      /**
       * The etag of the DNS zone. Omit this value to always overwrite the current zone. Specify the last-seen etag value to prevent accidentally overwriting any concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      IfMatch?: string;

      /**
       * Set to '*' to allow a new DNS zone to be created, but to prevent updating an existing zone. Other values will be ignored.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      IfNoneMatch?: string;
    },
    Error = CloudError
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
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      IfMatch?: string;
    },
    Error = CloudError
  >;

  /**
   * Deletes a DNS zone. WARNING: All DNS records in the zone will also be deleted. This operation cannot be undone.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Zone,
    Parameters = {
      /**
       * The etag of the DNS zone. Omit this value to always delete the current zone. Specify the last-seen etag value to prevent accidentally deleting any concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      IfMatch?: string;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
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
    },
    Error = CloudError
  >;

  /**
   * Lists the DNS zones in all resource groups in a subscription.
   */
  @segment("dnszones")
  list is ArmListBySubscription<
    Zone,
    Parameters = {
      /**
       * The maximum number of DNS zones to return. If not specified, returns up to 100 zones.
       */
      @query("$top")
      $top?: int32;
    },
    Error = CloudError
  >;

  /**
   * Lists all record sets in a DNS zone.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("recordsets")
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
    },
    Error = CloudError
  >;

  /**
   * Lists all record sets in a DNS zone.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("all")
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
    },
    Error = CloudError
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
