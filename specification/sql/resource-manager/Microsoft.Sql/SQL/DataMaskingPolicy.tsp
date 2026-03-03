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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The kind of Data Masking Policy. Metadata, used for Azure portal.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  kind?: string;
}

@armResourceOperations
interface DataMaskingPolicies {
  /**
   * Gets the database data masking policy.
   */
  get is ArmResourceRead<DataMaskingPolicy>;

  /**
   * Creates or updates a database data masking policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataMaskingPolicy>;

  /**
   * Gets a list of database data masking rules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataMaskingRules_ListByDatabase")
  @list
  @get
  @action("rules")
  listByDatabase is ArmResourceActionSync<
    DataMaskingPolicy,
    void,
    ArmResponse<ResourceListResult<DataMaskingRule>>
  >;

  /**
   * Creates or updates a database data masking rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataMaskingRules_CreateOrUpdate")
  @put
  @action("{dataMaskingRuleName}")
  dataMaskingRulesCreateOrUpdate is ArmResourceActionSync<
    DataMaskingPolicy,
    DataMaskingRule,
    ArmResponse<DataMaskingRule> | ArmResourceCreatedSyncResponse<DataMaskingRule>,
    Parameters = {
      /**
       * The name of the data masking rule.
       */
      @path
      dataMaskingRuleName: string;
    }
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
