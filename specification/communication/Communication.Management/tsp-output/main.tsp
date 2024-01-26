import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./CommunicationServiceResource.tsp";
import "./DomainResource.tsp";
import "./EmailServiceResource.tsp";
import "./SenderUsernameResource.tsp";
import "./SuppressionListResource.tsp";
import "./SuppressionListAddressResource.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * REST API for Azure Communication Services
 */
@armProviderNamespace
@service({
  title: "communication",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Communication;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-06-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_06_01_preview: "2023-06-01-preview",
}
