// client.tsp — SDK client customizations for ACS Communication Identity.
//
// Re-expresses the AutoRest directives and customization-class behaviour that previously
// lived in each language repo. Every rename below is baked into an already-shipped public
// API, so dropping one is a customer-visible break.
//
// VERIFICATION STATUS:
//   Java   — compiled with @azure-tools/typespec-java 0.46.2 against merged spec a1c68a5,
//            output inspected. Clean.
//   .NET   — compiled with @azure-typespec/http-client-csharp against a1c68a5 (2026-09-08).
//            Compiles clean; generated output byte-identical to the .NET working branch.
//   Python — NOT compiled. Python needs no directive here beyond the unscoped rename in (1);
//            its requirement is `generation-subdir` in tspconfig.yaml.
//   JS     — NOT compiled. Verification requested.
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
// 1. Token scope enum rename — UNSCOPED (applies to every language).
//
// Java and Python both carry this identical rename in their existing AutoRest
// configuration, so it is applied unscoped rather than duplicated per language.
// Was, in both languages: x-ms-enum.name = "CommunicationTokenScope".
// ---------------------------------------------------------------------------
@@clientName(Azure.Communication.Identity.CommunicationIdentityTokenScope,
  "CommunicationTokenScope"
);

// ---------------------------------------------------------------------------
// 2. Teams user exchange request model rename — Java.
// Was: AutoRest directive `rename-model: TeamsUserExchangeTokenRequest ->
// GetTokenForTeamsUserOptions`.
// ---------------------------------------------------------------------------
@@clientName(Azure.Communication.Identity.TeamsUserExchangeTokenRequest,
  "GetTokenForTeamsUserOptions",
  "java"
);

// ---------------------------------------------------------------------------
// 3. Property names on the exchange request — Java.
// Was: `x-ms-client-name` on each of token/appId/userId.
// The companion `required: [token, appId, userId]` directive is now redundant:
// all three are already required in models.tsp.
// ---------------------------------------------------------------------------
@@clientName(Azure.Communication.Identity.TeamsUserExchangeTokenRequest.token,
  "teamsUserAadToken",
  "java"
);
@@clientName(Azure.Communication.Identity.TeamsUserExchangeTokenRequest.appId,
  "clientId",
  "java"
);
@@clientName(Azure.Communication.Identity.TeamsUserExchangeTokenRequest.userId,
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
@@access(Azure.Communication.Identity.IdentityOperations.create, Access.internal, "java");
@@access(Azure.Communication.Identity.IdentityOperations.delete, Access.internal, "java");
@@access(Azure.Communication.Identity.IdentityOperations.revokeAccessTokens,
  Access.internal,
  "java"
);
@@access(Azure.Communication.Identity.IdentityOperations.issueAccessToken,
  Access.internal,
  "java"
);
@@access(Azure.Communication.Identity.TeamsUserOperations.exchangeTeamsUserAccessToken,
  Access.internal,
  "java"
);
@@access(Azure.Communication.Identity.TeamsExtensionOperations.exchangeToken,
  Access.internal,
  "java"
);
@@access(Azure.Communication.Identity.TeamsExtensionOperations.getAssignment,
  Access.internal,
  "java"
);
@@access(Azure.Communication.Identity.TeamsExtensionOperations.upsertAssignment,
  Access.internal,
  "java"
);
@@access(Azure.Communication.Identity.TeamsExtensionOperations.deleteAssignment,
  Access.internal,
  "java"
);

// The two renamed types stay on the public Java surface even though every operation
// referencing them is internal. Without these, Access.internal propagates to them.
@@access(Azure.Communication.Identity.TeamsUserExchangeTokenRequest, Access.public, "java");
@@access(Azure.Communication.Identity.CommunicationIdentityTokenScope, Access.public, "java");

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
@@clientName(Azure.Communication.Identity.CommunicationIdentityAccessTokenResult,
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
