import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateZone.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Describes a DNS record set (a collection of DNS records with the same name and type) in a Private DNS zone.
 */
@parentResource(PrivateZone)
model RecordSet is Azure.ResourceManager.ProxyResource<RecordSetProperties> {
  ...ResourceNameParameter<
    Resource = RecordSet,
    KeyName = "relativeRecordSetName",
    SegmentName = "{recordType}",
    NamePattern = ""
  >;

  /**
   * The ETag of the record set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface RecordSetOperationOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * The name of the DNS zone (without a terminating dot).
         */
        @path
        @segment("privateDnsZones")
        privateZoneName: string,
      },
      {
        /**
         * The type of DNS record in this record set.
         */
        @path
        recordType: RecordType,
      },
      CloudError
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface RecordSetOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * The name of the DNS zone (without a terminating dot).
         */
        @path
        @segment("privateDnsZones")
        privateZoneName: string,
      },
      {
        /**
         * The type of DNS record in this record set.
         */
        @path
        recordType: RecordType,

        /**
         * The name of the record set, relative to the name of the zone.
         */
        @path(#{ allowReserved: true })
        relativeRecordSetName: string,
      },
      CloudError
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface RecordSets {
  /**
   * Gets a record set.
   */
  get is RecordSetOps.Read<RecordSet>;

  /**
   * Creates or updates a record set within a Private DNS zone.
   */
  createOrUpdate is RecordSetOps.CreateOrUpdateSync<
    RecordSet,
    Parameters = {
      /**
       * The ETag of the record set. Omit this value to always overwrite the current record set. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      IfMatch?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing record set. Other values will be ignored.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      IfNoneMatch?: string;
    }
  >;

  /**
   * Updates a record set within a Private DNS zone.
   */
  @patch(#{ implicitOptionality: false })
  update is RecordSetOps.CustomPatchAsync<
    RecordSet,
    PatchModel = RecordSet,
    Parameters = {
      /**
       * The ETag of the record set. Omit this value to always overwrite the current record set. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      IfMatch?: string;
    },
    Response = ArmResponse<RecordSet>
  >;

  /**
   * Deletes a record set from a Private DNS zone. This operation cannot be undone.
   */
  delete is RecordSetOps.DeleteSync<
    RecordSet,
    Parameters = {
      /**
       * The ETag of the record set. Omit this value to always delete the current record set. Specify the last-seen ETag value to prevent accidentally deleting any concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      IfMatch?: string;
    }
  >;

  /**
   * Lists the record sets of a specified type in a Private DNS zone.
   */
  @list
  listByType is RecordSetOperationOps.Read<
    RecordSet,
    Parameters = {
      /**
       * The maximum number of record sets to return. If not specified, returns up to 100 record sets.
       */
      @query("$top")
      $top?: int32;

      /**
       * The suffix label of the record set name to be used to filter the record set enumeration. If this parameter is specified, the returned enumeration will only contain records that end with ".<recordsetnamesuffix>".
       */
      @query("$recordsetnamesuffix")
      $recordsetnamesuffix?: string;
    },
    Response = ArmResponse<ResourceListResult<RecordSet>>
  >;
}

@@doc(RecordSet.name,
  "The name of the record set, relative to the name of the zone."
);
@@doc(RecordSet.properties, "The properties of the record set.");
@@doc(RecordSets.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate operation."
);
@@doc(RecordSets.update::parameters.properties,
  "Parameters supplied to the Update operation."
);
