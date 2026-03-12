import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * The resource of the configuration or data needed to onboard the machine to MDE
 */
@singleton("default")
@subscriptionResource
model MdeOnboardingData
  is Azure.ResourceManager.ProxyResource<MdeOnboardingDataProperties> {
  ...ResourceNameParameter<
    Resource = MdeOnboardingData,
    KeyName = "mdeOnboarding",
    SegmentName = "mdeOnboardings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface MdeOnboardings {
  /**
   * The default configuration or data needed to onboard the machine to MDE
   */
  get is ArmResourceRead<
    MdeOnboardingData,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * The configuration or data needed to onboard the machine to MDE
   */
  list is ArmResourceListByParent<
    MdeOnboardingData,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<MdeOnboardingDataList>
  >;
}

@@doc(MdeOnboardingData.name, "");
@@doc(MdeOnboardingData.properties,
  "Properties of the MDE configuration or data parameter needed to onboard the machine to MDE"
);
