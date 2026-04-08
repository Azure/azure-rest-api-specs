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

alias ExtensionValueV2Ops = Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /**
     * The provider namespace. Always "Microsoft.HybridCompute".
     */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.HybridCompute";

    @path
    @segment("locations")
    @key("location")
    @minLength(1)
    location: string;

    @path
    @segment("publishers")
    @key
    publisher: string;

    @path
    @segment("extensionTypes")
    @key
    extensionType: string;
  },
  {},
  {
    @path
    @segment("versions")
    @key
    version: string;
  }
>;
@armResourceOperations(#{ omitTags: true })
interface ExtensionValueV2s {
  /**
   * Gets an Extension Metadata based on location, publisher, extensionType and version
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExtensionMetadataV2_Get")
  @tag("extensions")
  get is ExtensionValueV2Ops.Read<ExtensionValueV2>;

  /**
   * Gets all Extension versions based on location, publisher, extensionType
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExtensionMetadataV2_List")
  @tag("extensions")
  list is ExtensionValueV2Ops.List<
    ExtensionValueV2,
    Response = ArmResponse<ExtensionValueListResultV2>
  >;
}

@@doc(ExtensionValueV2.name, "The version of the Extension being received.");
@@doc(ExtensionValueV2.properties,
  "The single extension based on search criteria."
);
