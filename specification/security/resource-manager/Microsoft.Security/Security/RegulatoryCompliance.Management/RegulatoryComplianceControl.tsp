import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RegulatoryComplianceStandard.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
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

@armResourceOperations
interface RegulatoryComplianceControls {
  /**
   * Selected regulatory compliance control details and state
   */
  get is ArmResourceRead<
    RegulatoryComplianceControl,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * All supported regulatory compliance controls details and state for selected standard
   */
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
    Response = ArmResponse<RegulatoryComplianceControlList>
  >;
}

@@doc(RegulatoryComplianceControl.name,
  "Name of the regulatory compliance control object"
);
@@doc(RegulatoryComplianceControl.properties,
  "Regulatory compliance control data"
);
