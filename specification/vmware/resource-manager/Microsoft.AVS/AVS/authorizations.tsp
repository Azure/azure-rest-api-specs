namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

@armResourceOperations
interface Authorizations {
  list is ArmResourceListByParent<
    ExpressRouteAuthorization,
    Response = ArmResponse<ResourceList<ExpressRouteAuthorization>>
  >;

  get is ArmResourceRead<ExpressRouteAuthorization>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST REMOVE AT NEXT API VERSION UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ExpressRouteAuthorization,
    Foundations.BaseParameters<PrivateCloud>,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<ExpressRouteAuthorization>;
}

@@clientName(Authorizations.createOrUpdate::parameters.resource,
  "authorization"
);

@doc("Express Route Circuit Authorization provisioning state")
union ExpressRouteAuthorizationProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is updating")
  Updating: "Updating",
}

@doc("ExpressRoute Circuit Authorization")
@parentResource(PrivateCloud)
model ExpressRouteAuthorization
  is ProxyResource<ExpressRouteAuthorizationProperties> {
  @doc("Name of the ExpressRoute Circuit Authorization")
  @pattern("^[-\\w\\._]+$")
  @key("authorizationName")
  @path
  @segment("authorizations")
  name: string;
}

@doc("The properties of an ExpressRoute Circuit Authorization resource")
model ExpressRouteAuthorizationProperties {
  @doc("The state of the ExpressRoute Circuit Authorization provisioning")
  @visibility(Lifecycle.Read)
  provisioningState?: ExpressRouteAuthorizationProvisioningState;

  @doc("The ID of the ExpressRoute Circuit Authorization")
  @visibility(Lifecycle.Read)
  expressRouteAuthorizationId?: string;

  @doc("The key of the ExpressRoute Circuit Authorization")
  @visibility(Lifecycle.Read)
  expressRouteAuthorizationKey?: string;

  @doc("The ID of the ExpressRoute Circuit")
  expressRouteId?: string;
}
