import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./RegulatoryComplianceControl.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("Regulatory compliance assessment details and state")
@parentResource(RegulatoryComplianceControl)
model RegulatoryComplianceAssessment
  is ProxyResource<RegulatoryComplianceAssessmentProperties> {
  @doc("Name of the regulatory compliance assessment object")
  @key("regulatoryComplianceAssessmentName")
  @segment("regulatoryComplianceAssessments")
  name: string;
}

@armResourceOperations
interface RegulatoryComplianceAssessments {
  @doc("Supported regulatory compliance details and state for selected assessment")
  get is ArmResourceRead<RegulatoryComplianceAssessment>;
  @doc("Details and state of assessments mapped to selected regulatory compliance control")
  list is ArmResourceListByParent<
    RegulatoryComplianceAssessment,
    {
      ...BaseParameters<RegulatoryComplianceAssessment>;

      @doc("OData filter. Optional.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
