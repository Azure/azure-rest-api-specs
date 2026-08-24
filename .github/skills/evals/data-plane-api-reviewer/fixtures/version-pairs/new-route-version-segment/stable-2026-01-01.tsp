import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@service(#{ title: "Feature Flags" })
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://featureflags.azure.com/.default"],
    }
  ]>
)
@server(
  "{endpoint}",
  "Feature Flags service",
  {
    endpoint: url,
  }
)
namespace FeatureFlags;

@doc("Service API versions.")
enum Versions {
  @doc("The 2025-01-01 stable version.")
  v2025_01_01: "2025-01-01",

  @doc("The 2026-01-01 stable version.")
  v2026_01_01: "2026-01-01",
}

@doc("A feature flag and its current rollout state.")
@resource("flags")
model FeatureFlag {
  @doc("Name of the flag. Unique within the calling account and immutable after creation.")
  @key("flagName")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Whether the flag is currently enabled for evaluation.")
  enabled: boolean;

  @doc("Percentage of eligible requests the flag applies to, from 0 to 100.")
  @minValue(0)
  @maxValue(100)
  rolloutPercentage: int32;

  @doc("Time at which the flag was last changed, in UTC.")
  @visibility(Lifecycle.Read)
  updatedAt: utcDateTime;
}

@doc("The result of evaluating a flag for a caller-supplied context.")
@added(Versions.v2026_01_01)
model EvaluationResult {
  @doc("Name of the flag that was evaluated.")
  flagName: string;

  @doc("Whether the flag resolved to enabled for the supplied context.")
  enabled: boolean;

  @doc("Identifier of the rollout bucket the context fell into.")
  bucket: int32;
}

@doc("Context supplied by the caller when evaluating a flag.")
@added(Versions.v2026_01_01)
model EvaluationContext {
  @doc("Name of the flag to evaluate.")
  flagName: string;

  @doc("Stable identifier of the subject the flag is evaluated for, such as a user or tenant ID.")
  subjectId: string;
}

@doc("Operations on feature flags.")
interface Flags {
  @doc("Gets a feature flag by name.")
  get is StandardResourceOperations.ResourceRead<FeatureFlag>;

  @doc("Creates a feature flag, or replaces an existing flag with the same name.")
  createOrReplace is StandardResourceOperations.ResourceCreateOrReplace<FeatureFlag>;

  @doc("Deletes a feature flag. Deleting a flag that does not exist succeeds.")
  delete is StandardResourceOperations.ResourceDelete<FeatureFlag>;

  @doc("Lists the feature flags in the calling account.")
  list is StandardResourceOperations.ResourceList<
    FeatureFlag,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("""
    Evaluates a flag against a caller-supplied context and returns the resolved
    state. The evaluation engine is versioned independently of the service so
    that scoring changes can ship without waiting on an api-version, and callers
    pin the engine they were tested against.
    """)
  @added(Versions.v2026_01_01)
  @route("/v2/flags:evaluate")
  evaluate is Azure.Core.RpcOperation<EvaluationContext, EvaluationResult>;
}
