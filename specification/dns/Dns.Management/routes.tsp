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

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface DnsResourceReferenceOperationGroup {
  /**
   * Returns the DNS records specified by the referencing targetResourceIds.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DnsResourceReference_GetByTargetResources")
  @autoRoute
  @action("getDnsResourceReference")
  getByTargetResources is ArmProviderActionSync<
    Request = DnsResourceReferenceRequest,
    Response = DnsResourceReferenceResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
