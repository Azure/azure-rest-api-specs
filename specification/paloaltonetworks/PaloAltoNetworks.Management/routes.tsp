// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PaloAltoNetworksCloudngfwOperationsOperationGroup {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PaloAltoNetworksCloudngfwOperations_createProductSerialNumber")
  @autoRoute
  createProductSerialNumber is ArmProviderActionSync<
    Response = ProductSerialNumberRequestStatus,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PaloAltoNetworksCloudngfwOperations_listCloudManagerTenants")
  @autoRoute
  listCloudManagerTenants is ArmProviderActionSync<
    Response = CloudManagerTenantList,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PaloAltoNetworksCloudngfwOperations_listProductSerialNumberStatus")
  @autoRoute
  listProductSerialNumberStatus is ArmProviderActionSync<
    Response = ProductSerialNumberStatus | NotFoundResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PaloAltoNetworksCloudngfwOperations_listSupportInfo")
  @autoRoute
  listSupportInfo is ArmProviderActionSync<
    Response = SupportInfoModel,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
