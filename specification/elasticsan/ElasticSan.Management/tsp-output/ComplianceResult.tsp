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

namespace Microsoft.Security;
@doc("a compliance result")
model ComplianceResult is ExtensionResource<ComplianceResultProperties> {
  @doc("name of the desired assessment compliance result")
  @path
  @key("complianceResultName")
  @segment("complianceResults")
  name: string;
}

@armResourceOperations
interface ComplianceResults {
  @doc("Security Compliance Result")
  get is ArmResourceRead<ComplianceResult>;

  @doc("Security compliance results in the subscription")
  list is ArmResourceListByParent<
    ComplianceResult,
    {
      ...BaseParameters<ComplianceResult>;

      @doc("Scope of the query, can be subscription (/subscriptions/0b06d9ea-afe6-4779-bd59-30e5c2d9d13f) or management group (/providers/Microsoft.Management/managementGroups/mgName).")
      @path
      scope: string;
    }
  >;
}
