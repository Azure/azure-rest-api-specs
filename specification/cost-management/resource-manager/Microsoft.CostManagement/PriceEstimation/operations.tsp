import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.CostManagement;

/** Long-running, stateless price estimation for proposed pricing configurations. */
@added(Versions.v2026_10_01_preview)
@armResourceOperations
interface PriceEstimation {
  /**
   * Estimates recurring monthly prices and separate upfront charges using prices
   * applicable to the authorized subscription and its billing currency. Nothing
   * is deployed or purchased. Upfront amounts are never amortized into monthly
   * amounts. Commitment periods and payment options are validated against the
   * selected profile, independently of supplied running hours.
   *
   * This is a long-running operation. The request is validated synchronously:
   * invalid input fails the POST itself with HTTP 400 and is never priced. A valid
   * request returns HTTP 202 with Location and Retry-After headers; polling the
   * Location returns 202 while pricing runs, then the estimate (HTTP 200) or an
   * ARM error. Only the caller that started the operation can read its result,
   * which is retained for 30 minutes.
   *
   * Supported resource types and typed input metadata are discovered separately
   * through anonymous pricing-metadata GETs outside ARM. Discovery metadata is
   * subscription-independent and contains no customer prices or entitlements.
   * It must correspond to this estimation API version. Cached metadata is
   * guidance, never authorization or a substitute for server validation.
   * Resource types are matched case-insensitively; resource API versions and
   * input names must match supported values.
   *
   * Each entry supplies two named object inputs: resource, an allowlisted subset of
   * the native ARM resource with exact ARM property names, and usage, consumption
   * and purchase assumptions such as hours, GB, operations and purchaseOption.
   * Templates, expressions, references, scripts, customer resource names, deployed
   * resource IDs, tags, credentials and secrets are prohibited. Omitted inputs with
   * an applicable advertised default are completed by the server; explicit values,
   * including zero and false, always win.
   *
   * Each billable configuration must be represented once. Identical entries are
   * independently charged, not deduplicated.
   *
   * Every invalid entry is reported in one error response (MultipleInputErrors
   * with details when there is more than one). Error targets identify a request
   * position without echoing its value; an additionalInfo entry of type InputField
   * names the affected input and, where applicable, its allowed values or a choice
   * lookup path. Each request is limited to 512 KiB, 100 resource entries, 10000
   * typed values and eight nested object/array levels.
   *
   * A completed estimate can contain incomplete prices when individual components
   * cannot be priced; every missing or ambiguous price is reported as an issue,
   * not a zero. Result order matches input order. Each result reports the effective
   * configuration, the configuration defaults applied and any usage quantities the
   * server assumed because they were omitted.
   */
  @action("estimatePrices")
  estimatePrices is ArmProviderActionAsync<
    Request = EstimateContent,
    Response = EstimateResult,
    Scope = SubscriptionActionScope,
    Error = Azure.ResourceManager.ErrorResponse
  >;
}
