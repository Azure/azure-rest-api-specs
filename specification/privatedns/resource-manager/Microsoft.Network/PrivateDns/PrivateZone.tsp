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
 * Describes a Private DNS zone.
 */
model PrivateZone
  is Azure.ResourceManager.ProxyResource<PrivateZoneProperties> {
  ...ResourceNameParameter<
    Resource = PrivateZone,
    KeyName = "privateZoneName",
    SegmentName = "privateDnsZones",
    NamePattern = ""
  >;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * The Azure Region where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * The ETag of the zone.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

@armResourceOperations
interface PrivateZones {
  /**
   * Gets a Private DNS zone. Retrieves the zone properties, but not the virtual networks links or the record sets within the zone.
   */
  get is ArmResourceRead<PrivateZone, Error = CloudError>;

  /**
   * Creates or updates a Private DNS zone. Does not modify Links to virtual networks or DNS records within the zone.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PrivateZone,
    Parameters = {
      /**
       * The ETag of the Private DNS zone. Omit this value to always overwrite the current zone. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      IfMatch?: string;

      /**
       * Set to '*' to allow a new Private DNS zone to be created, but to prevent updating an existing zone. Other values will be ignored.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      IfNoneMatch?: string;
    },
    Response = ArmResourceUpdatedResponse<PrivateZone> | ArmResourceCreatedResponse<
      PrivateZone,
      ArmLroLocationHeader<FinalResult = PrivateZone> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse,
    Error = CloudError
  >;

  /**
   * Updates a Private DNS zone. Does not modify virtual network links or DNS records within the zone.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    PrivateZone,
    PatchModel = PrivateZone,
    Parameters = {
      /**
       * The ETag of the Private DNS zone. Omit this value to always overwrite the current zone. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      IfMatch?: string;
    },
    Error = CloudError
  >;

  /**
   * Deletes a Private DNS zone. WARNING: All DNS records in the zone will also be deleted. This operation cannot be undone. Private DNS zone cannot be deleted unless all virtual network links to it are removed.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateZone,
    Parameters = {
      /**
       * The ETag of the Private DNS zone. Omit this value to always delete the current zone. Specify the last-seen ETag value to prevent accidentally deleting any concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      IfMatch?: string;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists the Private DNS zones within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    PrivateZone,
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
   * Lists the Private DNS zones in all resource groups in a subscription.
   */
  list is ArmListBySubscription<
    PrivateZone,
    Parameters = {
      /**
       * The maximum number of Private DNS zones to return. If not specified, returns up to 100 zones.
       */
      @query("$top")
      $top?: int32;
    },
    Error = CloudError
  >;

  /**
   * Lists all record sets in a Private DNS zone.
   */
  @get
  @action("ALL")
  @list
  recordSetsList is ArmResourceActionSync<
    PrivateZone,
    void,
    ArmResponse<ResourceListResult<RecordSet>>,
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
    Error = CloudError
  >;
}

@@doc(PrivateZone.name,
  "The name of the Private DNS zone (without a terminating dot)."
);
@@doc(PrivateZone.properties, "Properties of the Private DNS zone.");
@@doc(PrivateZones.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate operation."
);
@@doc(PrivateZones.update::parameters.properties,
  "Parameters supplied to the Update operation."
);
