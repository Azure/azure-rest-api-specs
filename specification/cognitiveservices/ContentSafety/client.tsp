import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(ContentSafety.Versions.v2023_10_01)
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

@@clientName(ContentSafetyClient.analyzeImage::parameters.text, "options", "csharp");
@@clientName(ContentSafetyClient.analyzeImage.body, "options", "java");
@@clientName(ContentSafetyClient.analyzeImage.body, "options", "python");

@@clientName(ContentSafetyClient.analyzeText::body, "options", "csharp");
@@clientName(ContentSafetyClient.analyzeText::body, "options", "java");
@@clientName(ContentSafetyClient.analyzeText::body, "options", "python");

@@clientName(ContentSafetyClient.detectTextProtectedMaterial::parameters.body, "options", "csharp");
@@clientName(ContentSafetyClient.detectTextProtectedMaterial::parameters.body, "options", "java");
@@clientName(ContentSafetyClient.detectTextProtectedMaterial::parameters.body, "options", "python");

@@clientName(ContentSafetyClient.shieldPrompt::parameters.body, "options", "csharp");
@@clientName(ContentSafetyClient.shieldPrompt::parameters.body, "options", "java");
@@clientName(ContentSafetyClient.shieldPrompt::parameters.body, "options", "python");

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

@@clientName(BlocklistClient.addOrUpdateBlocklistItems::parameters.body, "options", "csharp");
@@clientName(BlocklistClient.addOrUpdateBlocklistItems::parameters.body, "options", "java");
@@clientName(BlocklistClient.addOrUpdateBlocklistItems::parameters.body, "options", "python");

@@clientName(BlocklistClient.removeBlocklistItems::parameters.body, "options", "csharp");
@@clientName(BlocklistClient.removeBlocklistItems::parameters.body, "options", "java");
@@clientName(BlocklistClient.removeBlocklistItems::parameters.body, "options", "python");
