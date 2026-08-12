import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * Represents a Sql pool data masking rule.
 */
@parentResource(SqlPool)
model DataMaskingRule
  is Azure.ResourceManager.ProxyResource<DataMaskingRuleProperties> {
  ...ResourceNameParameter<
    Resource = DataMaskingRule,
    KeyName = "dataMaskingRuleName",
    SegmentName = "rules",
    NamePattern = ""
  >;

  /**
   * The location of the data masking rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The kind of Data Masking Rule. Metadata, used for Azure portal.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  kind?: string;
}

@armResourceOperations
interface DataMaskingRules {
  /**
   * Gets the specific Sql pool data masking rule.
   */
  get is ArmResourceRead<DataMaskingRule>;

  /**
   * Creates or updates a Sql pool data masking rule.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataMaskingRule>;

  /**
   * Gets a list of Sql pool data masking rules.
   */
  listBySqlPool is ArmResourceListByParent<
    DataMaskingRule,
    Response = ArmResponse<DataMaskingRuleListResult>
  >;
}

@@doc(DataMaskingRule.name, "The name of the data masking rule.");
@@doc(DataMaskingRule.properties, "The properties of the resource.");
@@doc(
  DataMaskingRules.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating a data masking rule."
);
