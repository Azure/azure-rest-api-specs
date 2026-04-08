import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * Definition of ARM tracked top level resource.
 */
model DataCollectionRuleResource
  is Azure.ResourceManager.TrackedResource<DataCollectionRuleResourceProperties> {
  ...ResourceNameParameter<
    Resource = DataCollectionRuleResource,
    KeyName = "dataCollectionRuleName",
    SegmentName = "dataCollectionRules",
    NamePattern = ""
  >;

  /**
   * The kind of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: KnownDataCollectionRuleResourceKind;

  /**
   * The SKU of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: DataCollectionRuleResourceSku;

  /**
   * Managed service identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: DataCollectionRuleResourceIdentity;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations(#{ omitTags: true })
interface DataCollectionRuleResources {
  /**
   * Returns the specified data collection rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DataCollectionRules_Get")
  @tag("DataCollectionRules")
  @summary("Returns the specified data collection rule.")
  get is ArmResourceRead<
    DataCollectionRuleResource,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Creates or updates a data collection rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DataCollectionRules_Create")
  @tag("DataCollectionRules")
  @summary("Creates or updates a data collection rule.")
  create is Azure.ResourceManager.Legacy.CreateOrReplaceSync<
    DataCollectionRuleResource,
    OptionalRequestBody = true,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Updates part of a data collection rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DataCollectionRules_Update")
  @patch(#{ implicitOptionality: false })
  @tag("DataCollectionRules")
  @summary("Updates part of a data collection rule.")
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    DataCollectionRuleResource,
    PatchModel = ResourceForUpdate,
    OptionalRequestBody = true,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Deletes a data collection rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DataCollectionRules_Delete")
  @tag("DataCollectionRules")
  @summary("Deletes a data collection rule.")
  delete is ArmResourceDeleteSync<
    DataCollectionRuleResource,
    Parameters = {
      /**
       * If set to 'true' then all associations of this data collection rule will also be deleted
       */
      @query("deleteAssociations")
      deleteAssociations?: boolean = false;
    },
    Error = ErrorResponseCommonV2
  >;

  /**
   * Lists all data collection rules in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DataCollectionRules_ListByResourceGroup")
  @tag("DataCollectionRules")
  @summary("Lists all data collection rules in the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<
    DataCollectionRuleResource,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Lists all data collection rules in the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DataCollectionRules_ListBySubscription")
  @tag("DataCollectionRules")
  @summary("Lists all data collection rules in the specified subscription.")
  listBySubscription is ArmListBySubscription<
    DataCollectionRuleResource,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Lists associations for the specified data collection rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DataCollectionRuleAssociations_ListByRule")
  @list
  @get
  @action("associations")
  @tag("DataCollectionRuleAssociations")
  @summary("Lists associations for the specified data collection rule.")
  listByRule is ArmResourceActionSync<
    DataCollectionRuleResource,
    void,
    ArmResponse<ResourceListResult<DataCollectionRuleAssociationProxyOnlyResource>>,
    Parameters = {
      /**
       * (Optional) The continuation token for paginated responses
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * (Optional) The max number of items to return per page
       */
      @query("$top")
      $top?: int32;
    },
    Error = ErrorResponseCommonV2
  >;
}

@@doc(DataCollectionRuleResource.name,
  "The name of the data collection rule. The name is case insensitive."
);
@@doc(DataCollectionRuleResource.properties, "");
@@doc(DataCollectionRuleResources.create::parameters.resource, "The payload");
@@doc(DataCollectionRuleResources.update::parameters.properties, "The payload");
