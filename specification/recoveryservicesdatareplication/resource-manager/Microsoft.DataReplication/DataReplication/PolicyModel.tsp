import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
/**
 * Policy model.
 */
@parentResource(VaultModel)
model PolicyModel
  is Azure.ResourceManager.ProxyResource<PolicyModelProperties> {
  ...ResourceNameParameter<
    Resource = PolicyModel,
    KeyName = "policyName",
    SegmentName = "replicationPolicies",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi"
@@OpenAPI.extension(Policy.create::parameters.resource,
  "x-ms-client-name",
  "body"
);

@armResourceOperations
interface Policy {
  /**
   * Gets the details of the policy.
   */
  get is ArmResourceRead<PolicyModel>;

  /**
   * Creates the policy.
   */
  create is ArmResourceCreateOrReplaceAsync<PolicyModel>;

  /**
   * Removes the policy.
   */
  delete is ArmResourceDeleteWithoutOkAsync<PolicyModel>;

  /**
   * Gets the list of policies in the given vault.
   */
  list is ArmResourceListByParent<PolicyModel>;
}

@@doc(PolicyModel.name, "The policy name.");
@@doc(Policy.create::parameters.resource, "Policy model.");
