import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./actions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.AzureCoreExperiencesAssistant Resource Provider management API */
@armProviderNamespace("Microsoft.AzureCoreExperiencesAssistant")
@service({
  title: "Microsoft.AzureCoreExperiencesAssistant",
})
@versioned(Versions)
namespace Microsoft.AzureCoreExperiencesAssistant;
