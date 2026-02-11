import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(Account)
model CapabilityHost
  is Azure.ResourceManager.ProxyResource<CapabilityHostProperties, false> {
  ...ResourceNameParameter<
    Resource = CapabilityHost,
    KeyName = "capabilityHostName",
    SegmentName = "capabilityHosts",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$"
  >;
}

@armResourceOperations
interface CapabilityHosts {
  /**
   * Get account capabilityHost.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccountCapabilityHosts_Get")
  get is ArmResourceRead<CapabilityHost>;

  /**
   * Create or update account capabilityHost.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccountCapabilityHosts_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CapabilityHost>;

  /**
   * Delete account capabilityHost.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccountCapabilityHosts_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<CapabilityHost>;

  /**
   * List capabilityHost.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccountCapabilityHosts_List")
  list is ArmResourceListByParent<
    CapabilityHost,
    Response = ArmResponse<CapabilityHostResourceArmPaginatedResult>
  >;
}

@@doc(CapabilityHost.name,
  "The name of the capability host associated with the Cognitive Services Resource"
);
@@doc(CapabilityHost.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(CapabilityHosts.createOrUpdate::parameters.resource,
  "CapabilityHost definition."
);
