import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AdminRuleCollection.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
// FIXME: BaseAdminRule has no properties property
/**
 * Network base admin rule.
 */
@parentResource(AdminRuleCollection)
model BaseAdminRule is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = BaseAdminRule,
    KeyName = "ruleName",
    SegmentName = "rules",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;

  /**
   * Whether the rule is custom or default.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: AdminRuleKind;
}

@armResourceOperations
interface BaseAdminRules {
  /**
   * Gets a network manager security configuration admin rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AdminRules_Get")
  get is ArmResourceRead<BaseAdminRule, Error = CommonErrorResponse>;

  /**
   * Creates or updates an admin rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AdminRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    BaseAdminRule,
    Error = CommonErrorResponse
  >;

  /**
   * Deletes an admin rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("AdminRules_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    BaseAdminRule,
    Parameters = {
      /**
       * Deletes the resource even if it is part of a deployed configuration. If the configuration has been deployed, the service will do a cleanup deployment in the background, prior to the delete.
       */
      @query("force")
      force?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CommonErrorResponse
  >;

  /**
   * List all network manager security configuration admin rules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AdminRules_List")
  list is ArmResourceListByParent<
    BaseAdminRule,
    Parameters = {
      /**
       * An optional query parameter which specifies the maximum number of records to be returned by the server.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = AdminRuleListResult,
    Error = CommonErrorResponse
  >;
}

@@doc(BaseAdminRule.name, "The name of the rule.");
@@doc(BaseAdminRules.createOrUpdate::parameters.resource,
  "The admin rule to create or update"
);
