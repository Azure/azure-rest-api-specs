import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

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

// Python-specific customizations to address APIView feedback

// Line 348: rename remove_blocklist_items to remove_items
@@clientName(ContentSafety.TextBlocklists.removeBlocklistItems, "removeItems", "python");

// Line 309: make delete_text_blocklist private/internal
@@access(ContentSafety.TextBlocklists.deleteTextBlocklist, Access.internal, "python");

// Line 511: rename FOUR_SEVERITY_LEVELS to FOUR_SEVERITY in AnalyzeImageOutputType
@@clientName(ContentSafety.AnalyzeImageOutputType.FourSeverityLevels, "FourSeverity", "python");

// Lines 580, 684: change severity type from int32 to float32
@@alternateType(ContentSafety.ImageCategoriesAnalysis.severity, float32, "python");
@@alternateType(ContentSafety.TextCategoriesAnalysis.severity, float32, "python");
