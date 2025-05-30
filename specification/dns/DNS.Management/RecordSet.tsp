import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Zone.tsp";
import "./legacy.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager.Private;

namespace Microsoft.Network;
/**
 * Describes a DNS record set (a collection of DNS records with the same name and type).
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@Azure.ResourceManager.Private.armResourceInternal(RecordSetProperties)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
@parentResource(Zone)
model RecordSet extends Foundations.ProxyResource {
  ...ResourceNameParameter<
    Resource = RecordSet,
    KeyName = "relativeRecordSetName",
    SegmentName = "{recordType}",
    NamePattern = ""
  >;

  /**
   * The etag of the record set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(true)
  properties?: RecordSetProperties;
}
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
interface RecordSetOperationOps
  extends Azure.ResourceManager.Legacy.CustomLegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /**
         * The name of the DNS zone (without a terminating dot).
         */
        @path
        @segment("dnsZones")
        zoneName: string,
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
interface RecordSetOps
  extends Azure.ResourceManager.Legacy.CustomLegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /**
         * The name of the DNS zone (without a terminating dot).
         */
        @path
        @segment("dnsZones")
        zoneName: string,
      },
      {
        /**
         * The name of the record set, relative to the name of the zone.
         */
        @path
        relativeRecordSetName: string,

        /**
         * The type of DNS record in this record set.
         */
        @path
        recordType: RecordType,
      },
      CloudError
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
interface RecordSets {
  /**
   * Gets a record set.
   */
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/{recordType}/{+relativeRecordSetName}")
  get is RecordSetOps.ActionSync<
    RecordSet,
    void,
    Response = ArmResponse<RecordSet>
  >;

  /**
   * Creates or updates a record set within a DNS zone. Record sets of type SOA can be updated but not created (they are created when the DNS zone is created).
   */
  @put
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/{recordType}/{+relativeRecordSetName}")
  createOrUpdate is RecordSetOps.CreateOrUpdateAsync<
    RecordSet,
    Parameters = {
      /**
       * The etag of the record set. Omit this value to always overwrite the current record set. Specify the last-seen etag value to prevent accidentally overwriting any concurrent changes.
       */
      @header("If-Match")
      IfMatch?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing record set. Other values will be ignored.
       */
      @header("If-None-Match")
      IfNoneMatch?: string;
    },
    Response = ArmResponse<RecordSet> | ArmCreatedResponse<RecordSet>
  >;
  /**
   * Updates a record set within a DNS zone.
   */
  @patch(#{ implicitOptionality: false })
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/{recordType}/{+relativeRecordSetName}")
  update is RecordSetOps.CustomPatchAsync<
    RecordSet,
    PatchModel = RecordSet,
    Parameters = {
      /**
       * The etag of the record set. Omit this value to always overwrite the current record set. Specify the last-seen etag value to prevent accidentally overwriting concurrent changes.
       */
      @header("If-Match")
      IfMatch?: string;
    },
    Response = ArmResponse<RecordSet>
  >;
  /**
   * Deletes a record set from a DNS zone. This operation cannot be undone. Record sets of type SOA cannot be deleted (they are deleted when the DNS zone is deleted).
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/{recordType}/{+relativeRecordSetName*}")
  delete is RecordSetOps.DeleteSync<
    RecordSet,
    Parameters = {
      /**
       * The etag of the record set. Omit this value to always delete the current record set. Specify the last-seen etag value to prevent accidentally deleting any concurrent changes.
       */
      @header("If-Match")
      IfMatch?: string;
    }
  >;
  /**
   * Lists the record sets of a specified type in a DNS zone.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @operationId("RecordSets_ListByType")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/{recordType}")
  listByType is RecordSetOperationOps.ActionSync<
    RecordSet,
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
