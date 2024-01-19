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
@doc("Regulatory compliance standard details and state")
@subscriptionResource
model RegulatoryComplianceStandard
  is ProxyResource<RegulatoryComplianceStandardProperties> {
  @doc("Name of the regulatory compliance standard object")
  @path
  @key("regulatoryComplianceStandardName")
  @segment("regulatoryComplianceStandards")
  name: string;
}

@armResourceOperations
interface RegulatoryComplianceStandards {
  @doc("Supported regulatory compliance details state for selected standard")
  get is ArmResourceRead<RegulatoryComplianceStandard>;

  @doc("Supported regulatory compliance standards details and state")
  list is ArmResourceListByParent<
    RegulatoryComplianceStandard,
    {
      ...BaseParameters<RegulatoryComplianceStandard>;

      @doc("OData filter. Optional.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
