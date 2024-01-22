import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./PartnerResponse.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * This API describe ACE Provisioning ManagementPartner
 */
@armProviderNamespace
@service({
  title: "ACE Provisioning ManagementPartner API",
})
@versioned(Versions)
namespace Microsoft.ManagementPartner;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2018-02-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2018_02_01: "2018-02-01",
}
