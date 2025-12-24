import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace ContentSafety;

@added(ContentSafety.Versions.v2024_09_01)
@doc("The request of analyzing potential direct or indirect injection attacks.")
model ShieldPromptOptions {
  @doc("The user prompt to be analyzed, which may contain direct injection attacks.")
  userPrompt?: string;

  @doc("The documents to be analyzed, which may contain direct or indirect injection attacks.")
  documents?: string[];
}

@added(ContentSafety.Versions.v2024_09_01)
@doc("The combined analysis results of potential direct or indirect injection attacks.")
model ShieldPromptResult {
  @doc("Direct injection attacks analysis result for the given user prompt.")
  userPromptAnalysis?: UserPromptInjectionAnalysisResult;

  @doc("Direct and indirect injection attacks analysis result for the given documents.")
  documentsAnalysis?: DocumentInjectionAnalysisResult[];
}

@added(ContentSafety.Versions.v2024_09_01)
@doc("The individual analysis result of potential injection attacks in the given user prompt.")
model UserPromptInjectionAnalysisResult {
  @doc("Whether a potential injection attack is detected or not.")
  attackDetected: boolean;
}

@added(ContentSafety.Versions.v2024_09_01)
@doc("The individual analysis result of potential injection attacks in the given documents.")
model DocumentInjectionAnalysisResult {
  @doc("Whether a potential injection attack is detected or not.")
  attackDetected: boolean;
}

@added(ContentSafety.Versions.v2024_09_01)
@doc("The request of detecting potential protected material present in the given text.")
model DetectTextProtectedMaterialOptions {
  @doc("The text to be analyzed, which may contain protected material. The characters will be counted in Unicode code points.")
  text: string;
}

@added(ContentSafety.Versions.v2024_09_01)
@doc("The combined detection results of potential protected material.")
model DetectTextProtectedMaterialResult {
  @doc("Analysis result for the given text.")
  protectedMaterialAnalysis: TextProtectedMaterialAnalysisResult;
}

@added(ContentSafety.Versions.v2024_09_01)
@doc("The individual detection result of potential protected material.")
model TextProtectedMaterialAnalysisResult {
  @doc("Whether potential protected material is detected or not.")
  detected: boolean;
}
