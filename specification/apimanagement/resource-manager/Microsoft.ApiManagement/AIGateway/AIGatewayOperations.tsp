import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.ApiManagement;

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface AiGatewayResources {
  get is ArmResourceRead<AiGatewayResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AiGatewayResource>;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AiGatewayResource,
    PatchModel = AiGatewayUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayResource,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  listByResourceGroup is ArmResourceListByParent<AiGatewayResource>;
  listBySubscription is ArmListBySubscription<AiGatewayResource>;
}
