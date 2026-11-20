import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";
import "./agent-hooks.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

namespace ContentSafety;

interface TextOperations {
  @summary("Analyze Text")
  @doc("A synchronous API for the analysis of potentially harmful text content. Currently, it supports four categories: Hate, SelfHarm, Sexual, and Violence.")
  @route("/text:analyze")
  @post
  analyzeText is Azure.Core.RpcOperation<
    {
      @bodyRoot
      @doc("The text analysis request.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AnalyzeTextOptions;
    },
    AnalyzeTextResult
  >;

  @added(ContentSafety.Versions.v2024_09_01)
  @summary("Shield Prompt")
  @doc("A synchronous API for shielding prompt from direct and indirect injection attacks.")
  @route("/text:shieldPrompt")
  @post
  shieldPrompt is Azure.Core.RpcOperation<
    {
      @bodyRoot
      @doc("The request body to be detected, which may contain direct or indirect injection attacks.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: ShieldPromptOptions;
    },
    ShieldPromptResult
  >;

  @added(ContentSafety.Versions.v2024_09_01)
  @summary("Detect Protected Material for Text")
  @doc("A synchronous API for detecting protected material in the given text.")
  @route("/text:detectProtectedMaterial")
  @post
  detectTextProtectedMaterial is Azure.Core.RpcOperation<
    {
      @bodyRoot
      @doc("The request body to be detected, which may contain protected material.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: DetectTextProtectedMaterialOptions;
    },
    DetectTextProtectedMaterialResult
  >;
}

interface ImageOperations {
  @summary("Analyze Image")
  @doc("A synchronous API for the analysis of potentially harmful image content. Currently, it supports four categories: Hate, SelfHarm, Sexual, and Violence.")
  @route("/image:analyze")
  @post
  analyzeImage is Azure.Core.RpcOperation<
    {
      @doc("The image analysis request.")
      @bodyRoot
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AnalyzeImageOptions;
    },
    AnalyzeImageResult
  >;
}

@added(ContentSafety.Versions.v2026_09_01_preview)
interface UnifiedOperations {
  @removed(ContentSafety.Versions.v2026_10_15_preview)
  @renamedFrom(ContentSafety.Versions.v2026_10_15_preview, "unifiedModerate")
  @summary("Unified Moderate")
  @doc("A synchronous API that evaluates input, output, a proposed tool call, or a completed tool result against an applicable Agent Control Specification policy and returns the enforced content and policy verdict.")
  @route("/content:unifiedModerate")
  @sharedRoute
  @post
  unifiedModerateLegacy is Azure.Core.RpcOperation<
    {
      @bodyRoot
      @doc("The unified moderation request.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: UnifiedModerateOptions;
    },
    UnifiedModerateResult
  >;

  @added(ContentSafety.Versions.v2026_10_15_preview)
  @summary("Unified Moderate")
  @doc("""
    Evaluate one Agent Hooks 0.1 context. Supply either policyId or a project target and the exact selected Guardrail tuple, never both.
    Project evaluation includes any administrator policies bound to the target or its ancestors; an administrator binding is not required.
    HTTP 200 means evaluation completed, not that the action is allowed. The host validates the envelope and the request binding in extensions.aacs.receipt before enforcing verdict.
    Only the host can apply a transform, obtain approval, or release an action. Identity fields in the context do not grant access.
    Each request and response is limited to 1,048,576 bytes of decoded UTF-8 JSON and a container depth of 64 including the root. Duplicate object members and over-limit messages are invalid.
    """)
  @route("/content:unifiedModerate")
  @sharedRoute
  @post
  unifiedModerate is Azure.Core.RpcOperation<
    {
      @query
      @doc("Resource ID of the governed Foundry project under the authenticated serving account. Supply it with selectedPolicyId, selectedPolicyRevision and selectedPolicySemanticDigest; omit it when using policyId.")
      @minLength(1)
      targetResourceId?: string;

      @query
      @doc("Policy name or full policy resource ID for evaluation against the serving account. Supply it alone, without any project selectors.")
      @minLength(1)
      policyId?: string;

      @query
      @doc("Full resource ID of the Guardrail selected by the Foundry agent version. Required with targetResourceId for the Foundry-project profile. selectedPolicyRevision and selectedPolicySemanticDigest are required. The exact tuple must match the policy admitted for the agent operation; missing, stale, mismatched or deleted revisions fail closed and never follow mutable policy content.")
      @minLength(1)
      selectedPolicyId?: string;

      @query
      @doc("Exact revision of the selected Guardrail. Preserve the revision verbatim, including quoting when it is an ETag. Required with selectedPolicyId.")
      @minLength(1)
      selectedPolicyRevision?: string;

      @query
      @doc("SHA-256 digest of the admitted selected Guardrail semantic closure. Required exactly when selectedPolicyId is present and verified with selectedPolicyRevision before evaluation.")
      @pattern("^sha256:[0-9a-f]{64}$")
      selectedPolicySemanticDigest?: string;

      @bodyRoot
      @doc("Canonical Agent Hooks context with native JSON point payloads. Azure AI Content Safety (AACS) classifier role metadata, when needed by a non-Hooks caller, belongs in extensions.aacs.role.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AgentContext;
    },
    AgentEvaluationResult,
    {},
    AgentEvaluationError
  >;
}

interface BlockOps
  extends Azure.Core.ResourceOperations<NoRepeatableRequests &
      NoConditionalRequests &
      NoClientRequestId> {}

interface TextBlocklists {
  @summary("Get Text Blocklist By blocklistName")
  @doc("Returns text blocklist details.")
  getTextBlocklist is BlockOps.ResourceRead<TextBlocklist>;

  @summary("Create Or Update Text Blocklist")
  @doc("Updates a text blocklist. If the blocklistName does not exist, a new blocklist will be created.")
  createOrUpdateTextBlocklist is BlockOps.ResourceCreateOrUpdate<TextBlocklist>;

  @summary("Delete Text Blocklist By blocklistName")
  @doc("Deletes a text blocklist.")
  deleteTextBlocklist is BlockOps.ResourceDelete<TextBlocklist>;

  @summary("Get All Text Blocklists")
  @doc("Get all text blocklists details.")
  listTextBlocklists is BlockOps.ResourceList<TextBlocklist>;

  @summary("Add or update BlocklistItems To Text Blocklist")
  @doc("Add or update blocklistItems to a text blocklist. You can add or update at most 100 blocklistItems in one request.")
  addOrUpdateBlocklistItems is BlockOps.ResourceAction<
    TextBlocklist,
    {
      @doc("Options for adding or updating blocklist items.")
      @bodyRoot
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AddOrUpdateTextBlocklistItemsOptions;
    },
    AddOrUpdateTextBlocklistItemsResult
  >;

  @summary("Remove BlocklistItems From Text Blocklist")
  @doc("Remove blocklistItems from a text blocklist. You can remove at most 100 BlocklistItems in one request.")
  removeBlocklistItems is BlockOps.ResourceAction<
    TextBlocklist,
    {
      @doc("Options for removing blocklist items.")
      @bodyRoot
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: RemoveTextBlocklistItemsOptions;
    },
    NoContentResponse
  >;

  @summary("Get BlocklistItem By blocklistName And blocklistItemId")
  @doc("Get blocklistItem by blocklistName and blocklistItemId from a text blocklist.")
  getTextBlocklistItem is BlockOps.ResourceRead<TextBlocklistItem>;

  @summary("Get All BlocklistItems By blocklistName")
  @doc("Get all blocklistItems in a text blocklist.")
  listTextBlocklistItems is BlockOps.ResourceList<
    TextBlocklistItem,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}

@added(ContentSafety.Versions.v2026_09_01_preview)
@route("/provenance")
@doc("Content Provenance Detection operations that inspect image, audio, video, and text content for signals indicating the content was created or modified using AI: Microsoft-issued C2PA credentials, imperceptible watermarks in media, and AI declarations in metadata.")
interface ContentProvenanceOperations {
  @summary("Get Content Provenance Detection Status")
  @doc("Gets the status, result, or error of an asynchronous Content Provenance Detection operation.")
  getOperationStatus is ProvenanceResourceOps.ResourceRead<ProvenanceDetectOperation>;

  @summary("Start Content Provenance Detection")
  @doc("Starts an asynchronous Content Provenance Detection operation that inspects the supplied image, audio, video, or text content for signals indicating the content was created or modified using AI: Microsoft-issued C2PA credentials, imperceptible watermarks in media, and AI declarations in metadata.")
  @route(":detect")
  @pollingOperation(ContentProvenanceOperations.getOperationStatus)
  detect is Azure.Core.LongRunningRpcOperation<
    {
      @doc("Options describing the content to inspect using Content Provenance Detection.")
      @bodyRoot
      options: DetectProvenanceOptions;
    },
    ProvenanceDetectOperation,
    DetectProvenanceResult,
    Azure.Core.Foundations.Error,
    ProvenanceServiceTraits
  >;
}
