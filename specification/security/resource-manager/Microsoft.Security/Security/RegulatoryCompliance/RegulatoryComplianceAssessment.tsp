import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RegulatoryComplianceControl.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace RegulatoryComplianceAPI;
/**
 * Regulatory compliance assessment details and state
 */
@subscriptionResource
@parentResource(RegulatoryComplianceControl)
model RegulatoryComplianceAssessment
  is Azure.ResourceManager.ProxyResource<RegulatoryComplianceAssessmentProperties> {
  ...ResourceNameParameter<
    Resource = RegulatoryComplianceAssessment,
    KeyName = "regulatoryComplianceAssessmentName",
    SegmentName = "regulatoryComplianceAssessments",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface RegulatoryComplianceAssessments {
  /**
   * Supported regulatory compliance details and state for selected assessment
   */
  @tag("RegulatoryCompliance")
  get is ArmResourceRead<
    RegulatoryComplianceAssessment,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * Details and state of assessments mapped to selected regulatory compliance control
   */
  @tag("RegulatoryCompliance")
  list is ArmResourceListByParent<
    RegulatoryComplianceAssessment,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * OData filter. Optional.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<RegulatoryComplianceAssessmentList>,
    Error = CloudError
  >;
}

@@doc(RegulatoryComplianceAssessment.name,
  "Name of the regulatory compliance assessment object"
);
@@doc(RegulatoryComplianceAssessment.properties,
  "Regulatory compliance assessment data"
);



