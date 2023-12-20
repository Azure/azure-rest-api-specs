import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./RegulatoryComplianceStandard.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("Regulatory compliance control details and state")
@parentResource(RegulatoryComplianceStandard)
model RegulatoryComplianceControl
  is ProxyResource<RegulatoryComplianceControlProperties> {
  @doc("Name of the regulatory compliance control object")
  @path
  @key("regulatoryComplianceControlName")
  @segment("regulatoryComplianceControls")
  name: string;
}

@armResourceOperations
interface RegulatoryComplianceControls {
  @doc("Selected regulatory compliance control details and state")
  get is ArmResourceRead<RegulatoryComplianceControl>;
  @doc("All supported regulatory compliance controls details and state for selected standard")
  list is ArmResourceListByParent<
    RegulatoryComplianceControl,
    {
      ...BaseParameters<RegulatoryComplianceControl>;

      @doc("OData filter. Optional.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
