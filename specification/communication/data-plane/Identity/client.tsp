// client.tsp — SDK client customizations for ACS Communication Identity.
//
// Re-expresses the AutoRest directives and customization-class behavior that previously
// lived in each language repo. Every rename below is baked into an already-shipped public
// API, so dropping one is a customer-visible break.
//
// VERIFICATION STATUS — all four emitters regenerated against this file as merged.
//   Java   — compiled with @azure-tools/typespec-java 0.46.2. 0 errors, 25/25 unit tests,
//            RevApi reports 0 removals. Public models are the 5 expected types.
//   .NET   — compiled with @azure-typespec/http-client-csharp. Output byte-identical to
//            the .NET working branch. Both csharp-affecting directives were proven to be
//            the mechanism producing the shipped names by deleting the local [CodeGenType]
//            attributes and regenerating: both names survived. ApiCompat reports 0 errors,
//            0 warnings, no suppressions.
//   JS     — compiled with @azure-tools/typespec-ts 0.56.0. Output is byte-identical with
//            and without this file, and the public api.md diff is empty. JavaScript is
//            excluded from every directive here; see section 6.
//   Python — compiled with @azure-tools/typespec-python. 97/97 tests pass. Covered by the
//            token-scope rename in (1); also requires `generation-subdir: "_generated"`
//            in tspconfig.yaml, which is an emitter option rather than a directive.
//
// TESTING NOTE: when regenerating against a local spec clone, pass `--local-spec-repo`.
//   `tsp-client update` without it re-syncs the spec directory from the remote and SILENTLY
//   DELETES untracked local files — including this one. Re-check the file still exists after
//   each run before trusting a negative result.
//
//   Compare file *content*, not size, when checking a local copy against the remote. Line
//   endings alone shift the byte count, so a size mismatch is not evidence of staleness.

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
// option, not a client.tsp directive. Beyond that, Python is covered by the token-scope
// rename in (1), which is scoped "java,python,csharp".
//
// JavaScript is deliberately excluded from every directive in this file. Its shipped
// public name is `TokenScope`, declared independently in src/models.ts, so the raw
// generated name is not part of its public surface and renaming it would serve no
// purpose. Verified by regenerating against this file: the emitted JavaScript output is
// byte-identical with and without it, and the public api.md diff is empty.
// ---------------------------------------------------------------------------
