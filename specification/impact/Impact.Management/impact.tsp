import "@typespec/rest";

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.Impact" })
@versioned(Versions)
@armCommonTypesVersion(CommonTypes.Versions.v5)
namespace Microsoft.Impact;

@doc("API Versions")
enum Versions {
  @doc("January 01, 2025 Preview API Version")
  v2025_01_01_preview: "2025-01-01-preview",

  @doc("January 01, 2026 Preview API Version")
  v2026_01_01_preview: "2026-01-01-preview",
}

@doc("A successful response from getUploadToken will contain an 'uploadUrl' field. This uploadUrl field's value should follow the format: https://[storage-account-name].blob.core.windows.net/[container-name]/[your-blob.extension]?[SAS-token]")
@added(Versions.v2025_01_01_preview)
model UploadTokenResult {
  @doc("The SAS token URL for uploading")
  @secret
  uploadUrl: url;
}

@added(Versions.v2025_01_01_preview)
@armResourceOperations
interface UploadService {
  @doc("Only for select HPC customers at this time, who can use this POST endpoint to trigger an action, where the UserRP/AzImpactRP service creates and returns a user-delegate SAS token for the storage account/container unique to the customer (identified by subscription ID).")
  getUploadToken is ArmProviderActionSync<
    void,
    ArmResponse<UploadTokenResult>,
    SubscriptionActionScope
  >;
}
