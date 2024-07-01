import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(ContentSafety.Versions.v2023_10_01)
namespace Customizations;

@client({
  name: "ContentSafetyClient",
  service: ContentSafety,
})
interface ContentSafetyClient {
  analyzeText is ContentSafety.TextOperations.analyzeText;
  analyzeImage is ContentSafety.ImageOperations.analyzeImage;
  detectTextJailbreak is ContentSafety.TextOperations.detectTextJailbreak;
  detectTextProtectedMaterial is ContentSafety.TextOperations.detectTextProtectedMaterial;
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

@@clientName(ContentSafety.ImageData, "ContentSafetyImageData", "csharp");
@@clientName(ContentSafety.ImageData, "ContentSafetyImageData", "java");
@@clientName(ContentSafety.ImageData.blobUrl, "BlobUri", "csharp");

@@clientName(ContentSafety.TextBlocklist.blocklistName, "Name", "csharp");
@@clientName(ContentSafety.TextBlocklist.blocklistName, "name", "java");

@@clientName(Azure.Core.Foundations.ResourceBody.resource, "options");
