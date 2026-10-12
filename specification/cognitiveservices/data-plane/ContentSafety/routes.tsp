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
  @doc("Synchronously evaluate a canonical Agent Hooks 0.1 context and return a closed canonical Verdict plus a separate enforcement receipt. The hosted API supports two selector profiles. The Foundry-project profile uses targetResourceId for the mandatory project binding and may add one exact admitted developer policy through the all-or-none developerPolicyId/revision/digest tuple. The named-policy profile uses policyId without requiring a Foundry project. Exactly one profile is selected; targetResourceId and policyId cannot be combined. Local Copilot and WorkIQ integrations use in-process Agent Hooks/ACS rather than this hosted protocol. The calling host validates the receipt and owns transform application, final enforcement, approvals, timeouts, audit and the separate host-action attestation. API version establishes wire compatibility only; regional/cohort activation comes from the relevant capability authority. Body identity metadata and customer-settable headers are not authorization. Request and response limits are 1,048,576 decoded UTF-8 JSON bytes and container depth 64 including the root. Over-limit results are errors, not truncated successful responses.")
  @route("/content:unifiedModerate")
  @sharedRoute
  @post
  unifiedModerate is Azure.Core.RpcOperation<
    {
      @query
      @doc("Full Azure resource ID of the governed Foundry project used for binding resolution. This selects the mandatory project policy for the Foundry-project profile. It is not the policy or binding resource ID. The target must be under the authenticated serving account and requires a verified producer. Required when policyId is absent and forbidden when policyId is present.")
      targetResourceId?: string;

      @query
      @doc("Authorized named policy selector for the named-policy gateway profile. It may be a supported policy name or full policy resource ID according to the serving account's existing selector grammar. Required when targetResourceId is absent and forbidden when targetResourceId or developerPolicyId is present.")
      policyId?: string;

      @query
      @doc("Optional full developer policy resource ID evaluated as a separate stricter layer in the Foundry-project profile. When present, developerPolicyRevision and developerPolicySemanticDigest are required. The exact tuple must match the policy admitted for the agent operation; missing, stale, mismatched or deleted revisions fail closed and never follow mutable policy content.")
      developerPolicyId?: string;

      @query
      @doc("Opaque exact developer policy revision admitted for the operation. Current RP/PMS resources use the RP-assigned ETag preserved verbatim. Required exactly when developerPolicyId is present.")
      developerPolicyRevision?: string;

      @query
      @doc("SHA-256 digest of the admitted developer policy semantic closure. Required exactly when developerPolicyId is present and verified with developerPolicyRevision before evaluation.")
      @pattern("^sha256:[0-9a-f]{64}$")
      developerPolicySemanticDigest?: string;

      @bodyRoot
      @doc("Canonical Agent Hooks context with native JSON point payloads. Azure AI Content Safety (AACS) classifier role metadata, when needed by a non-Hooks caller, belongs in extensions.aacs.role.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AgentContext;
    },
    AgentEvaluationResult,
    {},
    AgentEvaluationError | Azure.Core.Foundations.ErrorResponse
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
@doc("Content Provenance Detection operations that inspect media for Microsoft-issued C2PA and imperceptible watermark signals indicating the content was created or modified using AI.")
interface ContentProvenanceOperations {
  @summary("Get Content Provenance Detection Status")
  @doc("Gets the status, result, or error of an asynchronous Content Provenance Detection operation.")
  getOperationStatus is ProvenanceResourceOps.ResourceRead<ProvenanceDetectOperation>;

  @summary("Start Content Provenance Detection")
  @doc("Starts an asynchronous Content Provenance Detection operation that inspects the supplied media for Microsoft-issued C2PA and imperceptible watermark signals indicating the content was created or modified using AI.")
  @route(":detect")
  @pollingOperation(ContentProvenanceOperations.getOperationStatus)
  detect is Azure.Core.LongRunningRpcOperation<
    {
      @doc("Options describing the media to inspect using Content Provenance Detection.")
      @bodyRoot
      options: DetectProvenanceOptions;
    },
    ProvenanceDetectOperation,
    DetectProvenanceResult,
    Azure.Core.Foundations.Error,
    ProvenanceServiceTraits
  >;
}
