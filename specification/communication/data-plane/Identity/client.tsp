// client.tsp — SDK client customizations for ACS Communication Identity.
//
// Re-expresses the AutoRest directives and customization-class behavior that previously
// lived in each language repo. Every rename below is baked into an already-shipped public
// API, so dropping one is a customer-visible break.
//
// VERIFICATION STATUS (as of PR head, all four emitters):
//   Java   — compiled with @azure-tools/typespec-java 0.46.2. Clean; public models are the
//            5 expected types. Re-verified after the csharp directive was added.
//   .NET   — compiled with @azure-typespec/http-client-csharp. Clean; generated output
//            byte-identical to the .NET working branch.
//   JS     — compiled with @azure-tools/typespec-ts 0.56.0. Clean; public api.md diff empty.
//            The csharp-scoped directive is correctly absent from JS output.
//   Python — not separately compiled. Python requires no directive in this file; its only
//            requirement is `generation-subdir` in tspconfig.yaml. Confirmed indirectly by
//            CI: SDK Validation - Python succeeds on this PR.
//
// TESTING NOTE: when regenerating against a local spec clone, pass `--local-spec-repo`.
//   `tsp-client update` without it re-syncs the spec directory from the remote and SILENTLY
//   DELETES untracked local files — including this one. Re-check the file still exists after
//   each run before trusting a negative result.

import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

namespace ClientCustomizations;

// ---------------------------------------------------------------------------
// 1. Token scope enum rename — scoped to the SDK languages that ship this name.
//
// Java, Python and .NET all carry this identical rename in their existing
// configuration, so it is applied once rather than duplicated per language.
// Was, in each: x-ms-enum.name / [CodeGenType] = "CommunicationTokenScope".
//
// MUST stay scoped. An unscoped @@clientName also reaches the
// @azure-tools/typespec-autorest emitter and renames the definition in the
// emitted swagger for EVERY api-version, including already-published ones.
// Verified by CI: unscoped produced a diff in both stable/2025-06-30 and
// stable/2026-09-23 CommunicationIdentity.json.
//
// JavaScript is deliberately excluded: its shipped public name is `TokenScope`,
// declared independently in src/models.ts, and the generated type is never
// re-exported. Verified as a no-op there.
//
// Python needs this rename and is included in the scope above.
// ---------------------------------------------------------------------------
@@clientName(
  Azure.Communication.Identity.CommunicationIdentityTokenScope,
  "CommunicationTokenScope",
  "java,python,csharp"
);

// ---------------------------------------------------------------------------
// 2. Teams user exchange request model rename — Java.
// Was: AutoRest directive `rename-model: TeamsUserExchangeTokenRequest ->
// GetTokenForTeamsUserOptions`.
// ---------------------------------------------------------------------------
@@clientName(
  Azure.Communication.Identity.TeamsUserExchangeTokenRequest,
  "GetTokenForTeamsUserOptions",
  "java"
);

// ---------------------------------------------------------------------------
// 3. Property names on the exchange request — Java.
// Was: `x-ms-client-name` on each of token/appId/userId.
// The companion `required: [token, appId, userId]` directive is now redundant:
// all three are already required in models.tsp.
// ---------------------------------------------------------------------------
@@clientName(
  Azure.Communication.Identity.TeamsUserExchangeTokenRequest.token,
  "teamsUserAadToken",
  "java"
);
@@clientName(
  Azure.Communication.Identity.TeamsUserExchangeTokenRequest.appId,
  "clientId",
  "java"
);
@@clientName(
  Azure.Communication.Identity.TeamsUserExchangeTokenRequest.userId,
  "userObjectId",
  "java"
);

// ---------------------------------------------------------------------------
// 4. Impl-only generation — Java.
//
// Replaces the AutoRest options `generate-client-as-impl: true` and
// `disable-client-builder: true`, which have no equivalent under DPG.
//
// The public CommunicationIdentityClient, CommunicationIdentityAsyncClient and
// CommunicationIdentityClientBuilder are hand-written: they translate wire models into
// CommunicationUserIdentifier (azure-communication-common) and
// com.azure.core.credential.AccessToken. Neither shape exists in this spec, so the
// generated layer must stay internal.
//
// Marking the operations internal also routes every wire model into
// `implementation.models` automatically — `custom-types` and `custom-types-subpackage`
// are NOT required alongside this.
// ---------------------------------------------------------------------------
@@access(
  Azure.Communication.Identity.IdentityOperations.create,
  Access.internal,
  "java"
);
@@access(
  Azure.Communication.Identity.IdentityOperations.delete,
  Access.internal,
  "java"
);
@@access(
  Azure.Communication.Identity.IdentityOperations.revokeAccessTokens,
  Access.internal,
  "java"
);
@@access(
  Azure.Communication.Identity.IdentityOperations.issueAccessToken,
  Access.internal,
  "java"
);
@@access(
  Azure.Communication.Identity.TeamsUserOperations.exchangeTeamsUserAccessToken,
  Access.internal,
  "java"
);
@@access(
  Azure.Communication.Identity.TeamsExtensionOperations.exchangeToken,
  Access.internal,
  "java"
);
@@access(
  Azure.Communication.Identity.TeamsExtensionOperations.getAssignment,
  Access.internal,
  "java"
);
@@access(
  Azure.Communication.Identity.TeamsExtensionOperations.upsertAssignment,
  Access.internal,
  "java"
);
@@access(
  Azure.Communication.Identity.TeamsExtensionOperations.deleteAssignment,
  Access.internal,
  "java"
);

// The two renamed types stay on the public Java surface even though every operation
// referencing them is internal. Without these, Access.internal propagates to them.
@@access(
  Azure.Communication.Identity.TeamsUserExchangeTokenRequest,
  Access.public,
  "java"
);
@@access(
  Azure.Communication.Identity.CommunicationIdentityTokenScope,
  Access.public,
  "java"
);

// ---------------------------------------------------------------------------
// 5. Token result model rename — .NET.
//
// VERIFIED 2026-09-08 with @azure-typespec/http-client-csharp: with this directive in
// place the generated files are CommunicationUserIdentifierAndToken.cs / .Serialization.cs,
// the build succeeds, and the API listing diff is empty. It replaces a [CodeGenType]
// attribute in the .NET custom code, which can then be deleted.
//
// The shipped 1.3.1 public surface (read from the release tag) carries
// `CommunicationUserIdentifierAndToken`, so dropping this is a customer-visible break.
// ---------------------------------------------------------------------------
@@clientName(
  Azure.Communication.Identity.CommunicationIdentityAccessTokenResult,
  "CommunicationUserIdentifierAndToken",
  "csharp"
);

// ---------------------------------------------------------------------------
// 6. Python and JavaScript.
//
// Python needs `generation-subdir: "_generated"` in tspconfig.yaml, which is an emitter
// option, not a client.tsp directive — nothing is required here for Python beyond the
// unscoped token-scope rename in (1).
//
// JavaScript has not yet been compiled against this file. If its shipped public name is
// already `CommunicationTokenScope`, directive (1) is a no-op for it, as it is for .NET
// and Java. If it is not, (1) must be scoped "java,python,csharp" instead of unscoped.
// ---------------------------------------------------------------------------
