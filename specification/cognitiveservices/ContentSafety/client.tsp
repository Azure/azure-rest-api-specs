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
  
  @@clientName(analyzeImage::parameters.body, "options", "csharp");
  @@clientName(analyzeImage::parameters.body, "options", "java");
  @@clientName(analyzeImage::parameters.body, "options", "python");

  analyzeText is ContentSafety.TextOperations.analyzeText;

  @@clientName(analyzeText.body, "options", "csharp");
  @@clientName(analyzeText.body, "options", "java");
  @@clientName(analyzeText.body, "options", "python");

  detectTextProtectedMaterial is ContentSafety.TextOperations.detectTextProtectedMaterial;
  
  @@clientName(detectTextProtectedMaterial.body, "options", "csharp");
  @@clientName(detectTextProtectedMaterial.body, "options", "java");
  @@clientName(detectTextProtectedMaterial.body, "options", "python");

  shieldPrompt is ContentSafety.TextOperations.shieldPrompt;
  
  @@clientName(shieldPrompt::parameters.body, "options", "csharp");
  @@clientName(shieldPrompt::parameters.body, "options", "java");
  @@clientName(shieldPrompt::parameters.body, "options", "python");
}

@client({
  name: "BlocklistClient",
  service: ContentSafety,
})
interface BlocklistClient {
  addOrUpdateBlocklistItems is ContentSafety.TextBlocklists.addOrUpdateBlocklistItems;
  createOrUpdateTextBlocklist is ContentSafety.TextBlocklists.createOrUpdateTextBlocklist;
  deleteTextBlocklist is ContentSafety.TextBlocklists.deleteTextBlocklist;
  getTextBlocklist is ContentSafety.TextBlocklists.getTextBlocklist;
  getTextBlocklistItem is ContentSafety.TextBlocklists.getTextBlocklistItem;
  listTextBlocklistItems is ContentSafety.TextBlocklists.listTextBlocklistItems;
  listTextBlocklists is ContentSafety.TextBlocklists.listTextBlocklists;
  removeBlocklistItems is ContentSafety.TextBlocklists.removeBlocklistItems;
}

@@clientName(addOrUpdateBlocklistItems.body, "options", "csharp");
@@clientName(addOrUpdateBlocklistItems.body, "options", "java");
@@clientName(addOrUpdateBlocklistItems.body, "options", "python");

@@clientName(removeBlocklistItems.body, "options", "csharp");
@@clientName(removeBlocklistItems.body, "options", "java");
@@clientName(removeBlocklistItems.body, "options", "python");
