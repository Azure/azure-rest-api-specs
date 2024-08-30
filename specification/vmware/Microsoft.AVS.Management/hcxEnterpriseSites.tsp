namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface HcxEnterpriseSites {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("HcxEnterpriseSites_List")
  list is ArmResourceListByParent<
    HcxEnterpriseSite,
    Response = ArmResponse<ResourceList<HcxEnterpriseSite>>
  >;

  get is ArmResourceRead<HcxEnterpriseSite>;

  createOrUpdate is ArmResourceCreateOrReplaceSync<HcxEnterpriseSite>;

  delete is ArmResourceDeleteSync<HcxEnterpriseSite>;
}

@@encodedName(HcxEnterpriseSites.createOrUpdate::parameters.resource,
  "application/json",
  "hcxEnterpriseSite"
);
@@clientName(HcxEnterpriseSites.createOrUpdate::parameters.resource,
  "hcxEnterpriseSite"
);
@@OpenAPI.extension(HcxEnterpriseSites.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "hcxEnterpriseSite"
);

@armResourceOperations
interface Authorizations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("Authorizations_List")
  list is ArmResourceListByParent<
    ExpressRouteAuthorization,
    Response = ArmResponse<ResourceList<ExpressRouteAuthorization>>
  >;

  get is ArmResourceRead<ExpressRouteAuthorization>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST REMOVE AT NEXT API VERSION UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ExpressRouteAuthorization,
    BaseParameters<PrivateCloud>,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<ExpressRouteAuthorization>;
}

@@encodedName(Authorizations.createOrUpdate::parameters.resource,
  "application/json",
  "authorization"
);
@@clientName(Authorizations.createOrUpdate::parameters.resource,
  "authorization"
);
@@OpenAPI.extension(Authorizations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "authorization"
);
