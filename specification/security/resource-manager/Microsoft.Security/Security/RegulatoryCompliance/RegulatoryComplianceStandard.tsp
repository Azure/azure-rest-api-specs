import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace Microsoft.Security;
/**
 * Regulatory compliance standard details and state
 */
@subscriptionResource
model RegulatoryComplianceStandard
  is Azure.ResourceManager.ProxyResource<RegulatoryComplianceStandardProperties> {
  ...ResourceNameParameter<
    Resource = RegulatoryComplianceStandard,
    KeyName = "regulatoryComplianceStandardName",
    SegmentName = "regulatoryComplianceStandards",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface RegulatoryComplianceStandards {
  /**
   * Supported regulatory compliance details state for selected standard
   */
  @tag("RegulatoryCompliance")
  get is ArmResourceRead<
    RegulatoryComplianceStandard,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * Supported regulatory compliance standards details and state
   */
  @tag("RegulatoryCompliance")
  list is ArmResourceListByParent<
    RegulatoryComplianceStandard,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * OData filter. Optional.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<RegulatoryComplianceStandardList>,
    Error = CloudError
  >;
}

@@doc(RegulatoryComplianceStandard.name,
  "Name of the regulatory compliance standard object"
);
@@doc(RegulatoryComplianceStandard.properties,
  "Regulatory compliance standard data"
);


