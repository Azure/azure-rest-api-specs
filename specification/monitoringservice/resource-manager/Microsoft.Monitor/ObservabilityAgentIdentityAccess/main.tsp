import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./operations.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

/** Advisory identity role inspection for Azure Monitor observability agents. */
@armProviderNamespace("Microsoft.Monitor")
@service(#{ title: "Azure Monitor Observability Agent Identity Access" })
@versioned(Versions)
@useAuth(azure_auth)
namespace Microsoft.Monitor;

/** Supported identity preflight API versions. */
enum Versions {
  /** The August 2026 preview API. */
  @Azure.Core.previewVersion
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_08_01: "2026-08-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

/** Azure Active Directory OAuth2 Flow. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "This authentication scheme name must remain azure_auth to satisfy ARM SecurityDefinitionsStructure; it is not an SDK payload model."
model azure_auth
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit;
      #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "authorizationUrl is a TypeSpec HTTP OAuth2 configuration field, not an SDK property; renaming it would invalidate authentication metadata."
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";
      scopes: ["https://management.azure.com/.default"];
    }
  ]>;
