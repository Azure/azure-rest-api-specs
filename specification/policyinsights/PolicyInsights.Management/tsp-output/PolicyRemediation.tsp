import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PolicyInsights;
@doc("The remediation definition.")
model PolicyRemediation is ExtensionResource<RemediationProperties> {
  @doc("The name of the remediation.")
  @path
  @key("remediationName")
  @segment("remediations")
  name: string;
}

@armResourceOperations
interface PolicyRemediations {
  @doc("Gets an existing remediation at resource scope.")
  getAtResource is ArmResourceRead<PolicyRemediation>;
  @doc("Creates or updates a remediation at resource scope.")
  createOrUpdateAtResource is ArmResourceCreateOrReplaceSync<PolicyRemediation>;
  @doc("Deletes an existing remediation at individual resource scope.")
  deleteAtResource is ArmResourceDeleteSync<PolicyRemediation>;
  @doc("Gets all remediations for a resource.")
  listForResource is ArmResourceListByParent<
    PolicyRemediation,
    {
      ...BaseParameters<PolicyRemediation>;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;
    }
  >;
  @doc("Gets all deployments for a remediation at resource scope.")
  listDeploymentsAtResource is ArmResourceActionSync<
    PolicyRemediation,
    void,
    RemediationDeploymentsListResult,
    {
      ...BaseParameters<PolicyRemediation>;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;
    }
  >;
  @doc("Cancel a remediation at resource scope.")
  cancelAtResource is ArmResourceActionSync<
    PolicyRemediation,
    void,
    PolicyRemediation
  >;
}
