import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EHNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventHub;
/**
 * Single item in List or Get Schema Group operation
 */
@parentResource(EHNamespace)
model SchemaGroup
  is Azure.ResourceManager.ProxyResource<SchemaGroupProperties> {
  ...ResourceNameParameter<
    Resource = SchemaGroup,
    KeyName = "schemaGroupName",
    SegmentName = "schemagroups",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface SchemaGroups {
  /**
   * Gets the details of an EventHub schema group.
   */
  get is ArmResourceRead<SchemaGroup, Error = ErrorResponse>;

  /**
   * Creates or Updates an EventHub schema group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    SchemaGroup,
    Response = ArmResourceUpdatedResponse<SchemaGroup>,
    Error = ErrorResponse
  >;

  /**
   * Deletes an EventHub schema group.
   */
  delete is ArmResourceDeleteSync<SchemaGroup, Error = ErrorResponse>;

  /**
   * Gets all the Schema Groups in a Namespace.
   */
  listByNamespace is ArmResourceListByParent<
    SchemaGroup,
    Parameters = {
      /**
       * Skip is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skip parameter that specifies a starting point to use for subsequent calls.
       */
      @maxValue(1000)
      @minValue(0)
      @query("$skip")
      $skip?: int32;

      /**
       * May be used to limit the number of results to the most recent N usageDetails.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    },
    Error = ErrorResponse
  >;
}

@@maxLength(SchemaGroup.name, 256);
@@minLength(SchemaGroup.name, 1);
@@doc(SchemaGroup.name, "The Schema Group name ");
@@doc(SchemaGroup.properties, "");
@@doc(SchemaGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to create an Event Hub resource."
);
