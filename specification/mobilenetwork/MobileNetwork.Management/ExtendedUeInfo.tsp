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
 * Extended User Equipment (UE) information.
 */
@singleton("default")
@parentResource(PacketCoreControlPlane)
model ExtendedUeInfo
  is Azure.ResourceManager.ProxyResource<ExtendedUeInfoProperties, false> {
  ...ResourceNameParameter<
    Resource = ExtendedUeInfo,
    KeyName = "extendedInformation",
    SegmentName = "extendedInformation",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ExtendedUeInfos {
  /**
   * Gets extended information about the specified UE from the packet core.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExtendedUeInformation_Get")
  get is ArmResourceRead<ExtendedUeInfo>;
}

@@doc(ExtendedUeInfo.name, "");
@@doc(ExtendedUeInfo.properties, "Extended UE Information Properties.");
