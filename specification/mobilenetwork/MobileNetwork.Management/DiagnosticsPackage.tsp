import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PacketCoreControlPlane.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * Diagnostics package resource.
 */
@parentResource(PacketCoreControlPlane)
model DiagnosticsPackage
  is Azure.ResourceManager.ProxyResource<
    DiagnosticsPackagePropertiesFormat,
    false
  > {
  ...ResourceNameParameter<
    Resource = DiagnosticsPackage,
    KeyName = "diagnosticsPackageName",
    SegmentName = "diagnosticsPackages",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]*$"
  >;
}

@armResourceOperations
interface DiagnosticsPackages {
  /**
   * Gets information about the specified diagnostics package.
   */
  get is ArmResourceRead<DiagnosticsPackage>;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Creates or updates a diagnostics package.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DiagnosticsPackage>;

  /**
   * Deletes the specified diagnostics package.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    DiagnosticsPackage,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the diagnostics packages under a packet core control plane.
   */
  listByPacketCoreControlPlane is ArmResourceListByParent<DiagnosticsPackage>;
}

@@maxLength(DiagnosticsPackage.name, 64);
@@doc(DiagnosticsPackage.name, "The name of the diagnostics package.");
@@doc(DiagnosticsPackage.properties,
  "Diagnostics package properties. A diagnostics package file derived from the name of this resource will be uploaded to the Storage Account Container URL in the packet core control plane properties"
);
