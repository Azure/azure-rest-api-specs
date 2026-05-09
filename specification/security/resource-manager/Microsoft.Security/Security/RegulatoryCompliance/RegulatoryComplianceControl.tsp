import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RegulatoryComplianceStandard.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace RegulatoryComplianceAPI;
/**
 * Regulatory compliance control details and state
 */
@subscriptionResource
@parentResource(RegulatoryComplianceStandard)
model RegulatoryComplianceControl
  is Azure.ResourceManager.ProxyResource<RegulatoryComplianceControlProperties> {
  ...ResourceNameParameter<
    Resource = RegulatoryComplianceControl,
    KeyName = "regulatoryComplianceControlName",
    SegmentName = "regulatoryComplianceControls",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface RegulatoryComplianceControls {
  /**
   * Selected regulatory compliance control details and state
   */
  @tag("RegulatoryCompliance")
  get is ArmResourceRead<
    RegulatoryComplianceControl,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * All supported regulatory compliance controls details and state for selected standard
   */
  @tag("RegulatoryCompliance")
  list is ArmResourceListByParent<
    RegulatoryComplianceControl,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * OData filter. Optional.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<RegulatoryComplianceControlList>,
    Error = CloudError
  >;
}

@@doc(RegulatoryComplianceControl.name,
  "Name of the regulatory compliance control object"
);
@@doc(RegulatoryComplianceControl.properties,
  "Regulatory compliance control data"
);
