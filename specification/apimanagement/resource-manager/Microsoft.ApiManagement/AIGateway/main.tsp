import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./AIGatewayResource.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "AIGatewayClient" })
@versioned(Versions)
namespace Microsoft.ApiManagement;

/** The available API versions. */
enum Versions {
  /** The 2026-09-01-preview API version. */
  @previewVersion
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_09_01_preview: "2026-09-01-preview",
}

@armResourceOperations(#{ omitTags: true })
interface Operations
  extends Azure.ResourceManager.Legacy.Operations<
      ArmResponse<OperationListResult>,
      ErrorResponse
    > {}

@@doc(
  Operations.list,
  "Lists all of the available REST API operations of the Microsoft.ApiManagement provider."
);
@@tag(Operations.list, "AIGatewayOperations");
