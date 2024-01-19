import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.PolicyInsights;
@doc("The remediation definition.")
model Remediation is ExtensionResource<RemediationProperties> {
  @doc("The name of the remediation.")
  @path
  @key("remediationName")
  @segment("remediations")
  name: string;
}

@armResourceOperations
interface Remediations {
  @doc("Gets an existing remediation at resource scope.")
  getAtResource is ArmResourceRead<Remediation>;

  @doc("Creates or updates a remediation at resource scope.")
  createOrUpdateAtResource is ArmResourceCreateOrReplaceSync<Remediation>;

  @doc("Deletes an existing remediation at individual resource scope.")
  deleteAtResource is ArmResourceDeleteSync<Remediation>;

  @doc("Gets all remediations for a resource.")
  listForResource is ArmResourceListByParent<
    Remediation,
    {
      ...BaseParameters<Remediation>;

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
    Remediation,
    void,
    RemediationDeploymentsListResult,
    {
      ...BaseParameters<Remediation>;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;
    }
  >;

  @doc("Cancel a remediation at resource scope.")
  cancelAtResource is ArmResourceActionSync<Remediation, void, Remediation>;
}

@@projectedName(Remediations.createOrUpdateAtResource::parameters.resource,
  "json",
  "parameters"
);
@@extension(Remediations.createOrUpdateAtResource::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Remediations.createOrUpdateAtResource::parameters.resource,
  "The remediation parameters."
);
