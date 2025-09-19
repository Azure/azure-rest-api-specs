import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automanage;
/**
 * The Service Principal Id for the subscription.
 */
@singleton("default")
@subscriptionResource
model ServicePrincipal
  is Azure.ResourceManager.ProxyResource<ServicePrincipalProperties> {
  ...ResourceNameParameter<
    Resource = ServicePrincipal,
    KeyName = "servicePrincipal",
    SegmentName = "servicePrincipals",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ServicePrincipals {
  /**
   * Get the Automanage AAD first party Application Service Principal details for the subscription id.
   */
  get is ArmResourceRead<
    ServicePrincipal,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Get the Automanage AAD first party Application Service Principal details for the subscription id.
   */
  listBySubscription is ArmResourceListByParent<
    ServicePrincipal,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<ServicePrincipalListResult>
  >;
}

@@doc(ServicePrincipal.name, "");
@@doc(ServicePrincipal.properties,
  "The Service Principal properties for the subscription"
);
@@summary(ServicePrincipal.properties, "Properties");
