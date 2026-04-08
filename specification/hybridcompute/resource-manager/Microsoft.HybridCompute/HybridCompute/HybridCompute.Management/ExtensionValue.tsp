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
 * Describes a Extension Metadata
 */
@subscriptionResource
model ExtensionValue
  is Azure.ResourceManager.ProxyResource<ExtensionValueProperties> {
  ...ResourceNameParameter<
    Resource = ExtensionValue,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

alias ExtensionValueOps = Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Legacy.Provider;

    @path
    @segment("locations")
    @key("location")
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
interface ExtensionValues {
  /**
   * Gets an Extension Metadata based on location, publisher, extensionType and version
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExtensionMetadata_Get")
  @tag("extensions")
  get is ExtensionValueOps.Read<ExtensionValue>;

  /**
   * Gets all Extension versions based on location, publisher, extensionType
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExtensionMetadata_List")
  @tag("extensions")
  list is ExtensionValueOps.List<
    ExtensionValue,
    Response = ArmResponse<ExtensionValueListResult>
  >;
}

@@doc(ExtensionValue.name, "The version of the Extension being received.");
@@doc(ExtensionValue.properties,
  "The single extension based on search criteria"
);
