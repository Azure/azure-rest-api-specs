import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "Experiment Runner" })
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://experimentrunner.azure.com/.default"],
    }
  ]>
)
@server("https://{endpoint}", "Experiment Runner service", { endpoint: string })
namespace ExperimentRunner;

@doc("Service API versions.")
enum Versions {
  @doc("The 2026-01-01-preview version.")
  v2026_01_01_preview: "2026-01-01-preview",
}

@doc("A configured experiment.")
@resource("experiments")
model Experiment {
  @doc("Name of the experiment. Immutable after creation.")
  @key
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Strategy used to allocate traffic between experiment arms.")
  allocationStrategy: AllocationStrategy;

  @doc("Fraction of eligible traffic entering the experiment, from 0.0 to 1.0.")
  trafficFraction: float32;

  @doc("Experimental field used during the preview to trial per-arm overrides. Subject to removal.")
  armOverrides?: Record<float32>;

  @doc("Time at which the experiment was created, in UTC.")
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;
}

@doc("Strategy used to allocate traffic between experiment arms.")
union AllocationStrategy {
  string,

  @doc("Split traffic evenly across all arms.")
  Even: "Even",

  @doc("Split traffic according to explicitly configured weights.")
  Weighted: "Weighted",

  @doc("Shift traffic towards better-performing arms as results accrue. Under evaluation during the preview.")
  Adaptive: "Adaptive",
}

@doc("Operations on experiments.")
interface Experiments {
  @doc("Gets an experiment.")
  get is StandardResourceOperations.ResourceRead<Experiment>;

  @doc("Creates or replaces an experiment.")
  createOrReplace is StandardResourceOperations.ResourceCreateOrReplace<Experiment>;

  @doc("Lists experiments.")
  list is StandardResourceOperations.ResourceList<Experiment>;
}
