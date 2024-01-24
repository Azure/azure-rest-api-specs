import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridCompute;
/**
 * Describes a Extension Metadata
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@locationResource
@Azure.ResourceManager.Private.armResourceInternal(ExtensionValueProperties)
@includeInapplicableMetadataInPayload(false)
model ExtensionValue extends ProxyResourceBase {
  /**
   * The version of the Extension being received.
   */
  @path
  @key("version")
  @segment("versions")
  name: string;

  /**
   * The single extension based on search criteria
   */
  @extension("x-ms-client-flatten", true)
  properties?: ExtensionValueProperties;
}

@armResourceOperations
interface ExtensionValues {
  /**
   * Gets an Extension Metadata based on location, publisher, extensionType and version
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ExtensionMetadata_Get")
  get is ArmResourceRead<ExtensionValue>;

  /**
   * Gets all Extension versions based on location, publisher, extensionType
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ExtensionMetadata_List")
  list is ArmResourceListByParent<ExtensionValue>;
}
