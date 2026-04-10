import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Sql;
/**
 * A database data masking policy.
 */
@parentResource(Database)
model DataMaskingPolicy
  is Azure.ResourceManager.ProxyResource<DataMaskingPolicyProperties> {
  ...ResourceNameParameter<
    Resource = DataMaskingPolicy,
    KeyName = "dataMaskingPolicyName",
    SegmentName = "dataMaskingPolicies",
    NamePattern = "",
    Type = DataMaskingPolicyName
  >;

  /**
   * The location of the data masking policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The kind of Data Masking Policy. Metadata, used for Azure portal.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  kind?: string;
}

alias DataMaskingPoliciesParentParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /**
   * The name of the server.
   */
  @path
  @segment("servers")
  @key
  serverName: string;

  /**
   * The name of the database.
   */
  @path
  @segment("databases")
  @key
  databaseName: string;

  /**
   *  The name of the database for which the data masking policy applies.
   */
  @path
  @segment("dataMaskingPolicies")
  @key
  dataMaskingPolicyName: DataMaskingPolicyName;
};

alias DataMaskingPoliciesParameters = {
  /**
   * The name of the data masking rule.
   */
  @path
  @key
  @segment("rules")
  dataMaskingRuleName: string;
};

alias DataMaskingPoliciesOps = Azure.ResourceManager.Legacy.RoutedOperations<
  DataMaskingPoliciesParentParameters,
  DataMaskingPoliciesParameters,
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}/rules/{dataMaskingRuleName}",
  }
>;

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface DataMaskingPolicies {
  /**
   * Gets the database data masking policy.
   */
  @tag("DataMaskingPolicies")
  get is ArmResourceRead<DataMaskingPolicy>;

  /**
   * Creates or updates a database data masking policy.
   */
  @tag("DataMaskingPolicies")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataMaskingPolicy>;

  /**
   * Gets a list of database data masking rules.
   */
  @tag("DataMaskingRules")
  @list
  @get
  @action("rules")
  listByDatabase is ArmResourceActionSync<
    DataMaskingPolicy,
    void,
    ArmResponse<ResourceListResult<DataMaskingRule>>,
    Parameters = {
      /**
       * The number of elements in the collection to skip.
       */
      @added(Versions.v2025_02_01_preview)
      @query("$skip")
      $skip?: int64;
    }
  >;

  /**
   * Creates or updates a database data masking rule.
   */
  @tag("DataMaskingRules")
  @put
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}/rules/{dataMaskingRuleName}")
  dataMaskingRulesCreateOrUpdate is DataMaskingPoliciesOps.ActionSync<
    DataMaskingPolicy,
    DataMaskingRule,
    Response = ArmResponse<DataMaskingRule> | ArmResourceCreatedSyncResponse<DataMaskingRule>
  >;
}

@@doc(DataMaskingPolicy.name,
  "The name of the database for which the data masking policy applies."
);
@@doc(DataMaskingPolicy.properties, "Resource properties.");
@@doc(DataMaskingPolicies.createOrUpdate::parameters.resource,
  "Parameters for creating or updating a data masking policy."
);
@@doc(DataMaskingPolicies.dataMaskingRulesCreateOrUpdate::parameters.body,
  "The required parameters for creating or updating a data masking rule."
);
