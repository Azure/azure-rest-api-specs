import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./GalleryImages.tsp";
import "./LogicalNetworks.tsp";
import "./MarketplaceGalleryImages.tsp";
import "./NetworkInterfaces.tsp";
import "./NetworkSecurityGroups.tsp";
import "./SecurityRules.tsp";
import "./StorageContainers.tsp";
import "./VirtualHardDisks.tsp";
import "./VirtualMachineInstance.tsp";
import "./HybridIdentityMetadata.tsp";
import "./AttestationStatus.tsp";
import "./GuestAgent.tsp";
import "../Operations.Management/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Azure Stack HCI management service
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "HCI itself is a short form."
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "Microsoft.AzureStackHCI",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AzureStackHCI;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-02-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_02_01_preview: "2024-02-01-preview",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "AADToken is the correct case."
#suppress "@azure-tools/typespec-azure-core/x-ms-enum extension" "type is correct"
@doc("The Azure Active Directory OAuth2 Flow")
model AADToken
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.authorizationCode;
      authorizationUrl: "https://api.example.com/oauth2/authorize";
      tokenUrl: "https://api.example.com/oauth2/token";
      scopes: [
        "https://management.azure.com/read",
        "https://management.azure.com/write"
      ];
    }
  ]>;
