import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
/**
 * Policy model.
 */
@parentResource(VaultModel)
model PolicyModel is ProxyResource<PolicyModelProperties> {
  /**
   * The policy name.
   */
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("policyName")
  @segment("replicationPolicies")
  name: string;
}

@armResourceOperations
interface PolicyModels {
  /**
   * Gets the details of the policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Policy_Get")
  get is ArmResourceRead<PolicyModel>;

  /**
   * Creates the policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Policy_Create")
  create is ArmResourceCreateOrReplaceAsync<
    PolicyModel,
    BaseParameters<PolicyModel>,
    ArmLroLocationHeader
  >;

  /**
   * Removes the policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Policy_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    PolicyModel,
    BaseParameters<PolicyModel>,
    ArmLroLocationHeader
  >;

  /**
   * Gets the list of policies in the given vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Policy_List")
  list is ArmResourceListByParent<PolicyModel>;
}

@@projectedName(PolicyModels.create::parameters.resource, "json", "body");
@@extension(PolicyModels.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(PolicyModels.create::parameters.resource, "Policy model.");
