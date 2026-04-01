import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridCompute;
/**
 * Describes an Extension Metadata.
 */
@tenantResource
@parentResource(TenantLocationResource)
model ExtensionValueV2
  is Azure.ResourceManager.ProxyResource<ExtensionValueV2Properties> {
  ...ResourceNameParameter<
    Resource = ExtensionValueV2,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ExtensionValueV2s {
  /**
   * Gets an Extension Metadata based on location, publisher, extensionType and version
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExtensionMetadataV2_Get")
  get is ArmResourceRead<
    ExtensionValueV2,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Gets all Extension versions based on location, publisher, extensionType
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExtensionMetadataV2_List")
  list is ArmResourceListByParent<
    ExtensionValueV2,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<ExtensionValueListResultV2>
  >;
}

@@doc(ExtensionValueV2.name, "The version of the Extension being received.");
@@doc(ExtensionValueV2.properties,
  "The single extension based on search criteria."
);
