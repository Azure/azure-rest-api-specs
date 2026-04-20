import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Represents a database data masking policy.
 */
@singleton("Default")
@parentResource(Database)
model DataMaskingPolicy is ProxyResource<DataMaskingPolicyProperties> {
  @key("dataMaskingPolicy")
  @segment("dataMaskingPolicies")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataMaskingPolicies {
  /**
   * Gets a database data masking policy.
   */
  get is ArmResourceRead<DataMaskingPolicy>;

  /**
   * Creates or updates a database data masking policy
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataMaskingPolicy>;

  /**
   * Gets a list of database data masking rules.
   */
  // FIXME: DataMaskingRules_List could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataMaskingRules_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}/rules")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the database.
       */
      @path
      databaseName: string;

      /**
       * The name of the database for which the data masking rule applies.
       */
      @path
      dataMaskingPolicyName: "Default";
    },
    DataMaskingRuleListResult
  >;
}

@@projectedName(DataMaskingPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DataMaskingPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DataMaskingPolicies.createOrUpdate::parameters.resource,
  "Parameters for creating or updating a data masking policy."
);
