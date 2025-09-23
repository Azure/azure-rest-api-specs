import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(ContentSafety.Versions.v2024_09_01)
namespace Customizations;

@client({
  name: "ContentSafetyClient",
  service: ContentSafety,
})
interface ContentSafetyClient {
  analyzeImage is ContentSafety.ImageOperations.analyzeImage;
  analyzeText is ContentSafety.TextOperations.analyzeText;
  detectTextProtectedMaterial is ContentSafety.TextOperations.detectTextProtectedMaterial;
  shieldPrompt is ContentSafety.TextOperations.shieldPrompt;
}

@client({
  name: "BlocklistClient",
  service: ContentSafety,
})
interface BlocklistClient {
  addOrUpdateBlocklistItems is ContentSafety.TextBlocklists.addOrUpdateBlocklistItems;
  @convenientAPI(false, "csharp") // csharp is not ready for patch operations, therefore hide the convenience API of this operation
  createOrUpdateTextBlocklist is ContentSafety.TextBlocklists.createOrUpdateTextBlocklist;
  deleteTextBlocklist is ContentSafety.TextBlocklists.deleteTextBlocklist;
  getTextBlocklist is ContentSafety.TextBlocklists.getTextBlocklist;
  getTextBlocklistItem is ContentSafety.TextBlocklists.getTextBlocklistItem;
  listTextBlocklistItems is ContentSafety.TextBlocklists.listTextBlocklistItems;
  listTextBlocklists is ContentSafety.TextBlocklists.listTextBlocklists;
  removeBlocklistItems is ContentSafety.TextBlocklists.removeBlocklistItems;
}
@@clientName(Azure.Core.Foundations.ResourceBody.resource, "options");
