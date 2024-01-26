import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PacketCoreControlPlane.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * Diagnostics package resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(PacketCoreControlPlane)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  DiagnosticsPackagePropertiesFormat
)
model DiagnosticsPackage extends ProxyResourceBase {
  /**
   * The name of the diagnostics package.
   */
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("diagnosticsPackageName")
  @segment("diagnosticsPackages")
  @visibility("read")
  name: string;

  /**
   * Diagnostics package properties. A diagnostics package file derived from the name of this resource will be uploaded to the Storage Account Container URL in the packet core control plane properties
   */
  @extension("x-ms-client-flatten", true)
  properties: DiagnosticsPackagePropertiesFormat;
}

@armResourceOperations
interface DiagnosticsPackages {
  /**
   * Gets information about the specified diagnostics package.
   */
  get is ArmResourceRead<DiagnosticsPackage>;

  /**
   * Creates or updates a diagnostics package.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DiagnosticsPackage,
    BaseParameters<DiagnosticsPackage>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes the specified diagnostics package.
   */
  delete is ArmResourceDeleteAsync<
    DiagnosticsPackage,
    BaseParameters<DiagnosticsPackage>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all the diagnostics packages under a packet core control plane.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DiagnosticsPackages_ListByPacketCoreControlPlane")
  listByPacketCoreControlPlane is ArmResourceListByParent<DiagnosticsPackage>;
}
