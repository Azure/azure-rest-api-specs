// Service declaration for the standalone Fine-Tuning Sessions SDK package.
//
// This file serves two purposes:
//  1. Declares Azure.AI.Projects with @versioned (but NOT @service) so that
//     versioning decorators (@removed, @added) in servicepatterns.tsp compile
//     correctly without causing the emitter to generate an unwanted ProjectsClient.
//  2. Declares Azure.AI.FineTuning.Sessions as the one-and-only @service for
//     this TypeSpec project, causing emitters to generate FineTuningSessionClient
//     and not ProjectsClient.

import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Versioning;

// ── Foundry versioning stub ────────────────────────────────────────────────────
// Provides the Versions enum required by @removed / @added decorators in
// servicepatterns.tsp, without registering Azure.AI.Projects as a service.
@versioned(Azure.AI.Projects.Versions)
namespace Azure.AI.Projects {
  /** Foundry API versions. */
  enum Versions {
    /** Virtual public-preview version for backwards-compat. */
    PuPr: "virtual-public-preview",

    @doc("Microsoft Foundry API version v1.")
    v1: "v1",
  }
}

// ── Fine-Tuning Sessions service ───────────────────────────────────────────────
// Registers Azure.AI.FineTuning.Sessions as the service so that language
// emitters generate FineTuningSessionClient with the fine-tuning session routes.
#suppress "@azure-tools/typespec-autorest/unsupported-http-auth-scheme" "OAuth2 implicit flow is required for Foundry"
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://ai.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Azure AI Fine-Tuning Sessions" })
@server(
  "{endpoint}",
  "Azure AI Fine-Tuning Sessions",
  {
    @doc("""
      Foundry Project endpoint in the form
      "https://{ai-services-account-name}.services.ai.azure.com/api/projects/{project-name}".
      If you only have one Project in your Foundry Hub, or to target the default Project
      in your Hub, use the form
      "https://{ai-services-account-name}.services.ai.azure.com/api/projects/_project"
      """)
    endpoint: url,
  }
)
namespace Azure.AI.FineTuning.Sessions {
  // Service declaration only — all types and operations are declared in session-finetuning/routes.tsp.
}
