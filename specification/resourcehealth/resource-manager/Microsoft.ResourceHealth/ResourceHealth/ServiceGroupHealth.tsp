import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.ResourceHealth;

/** Parameters for health collections scoped to a service group. */
@added(Versions.v2026_08_01_preview)
model ServiceGroupHealthParameters {
  ...ApiVersionParameter;

  /** The name of the service group. */
  @path
  @segment("providers/Microsoft.Management/serviceGroups")
  @pattern("^[a-zA-Z0-9\\-_().]{1,90}$")
  serviceGroupName: string;

  /** The Resource Health provider namespace. */
  @path
  @segment("providers")
  providerNamespace: "Microsoft.ResourceHealth";

  /**
   * An opaque continuation token supplied by the service. Follow the nextLink
   * URL verbatim rather than constructing or modifying this value.
   */
  @query("$skipToken")
  skipToken?: string;
}

/** Preview health collections for the direct members of a service group. */
@added(Versions.v2026_08_01_preview)
@armResourceOperations
interface ServiceGroupHealth {
  /**
   * Lists current resource availability statuses for the direct subscription,
   * resource group, and resource members of a service group. Subscription and
   * resource group members contribute the resources within their scope. Child
   * service groups are not recursively expanded. This collection is not the
   * availability history of the service group resource.
   *
   * Each status retains its original resource-scoped ID. Access requires both
   * preview tenant enablement and Azure role-based access control authorization.
   * Returns HTTP 403 with the standard error response when the caller is not
   * authorized or the tenant is not enabled for this preview, without disclosing
   * membership or health data.
   * To continue, follow the returned nextLink URL verbatim, including when a
   * page has an empty value array. Continuation values are opaque.
   */
  @get
  @list
  @armResourceList(AvailabilityStatus)
  @segment("availabilityStatuses")
  listAvailabilityStatuses is ArmReadOperation<
    ServiceGroupHealthParameters & {
      /**
       * An opaque query signature supplied by the service with the continuation
       * token. Follow nextLink verbatim; do not construct or modify this value.
       */
      @query
      querySignature?: string;
    },
    ArmResponse<availabilityStatusListResult>,
    Azure.ResourceManager.ErrorResponse
  >;

  /**
   * Lists service health events potentially relevant to the direct subscription,
   * resource group, and resource members of a service group. Child service
   * groups are not recursively expanded. Inclusion indicates potential relevance,
   * not confirmed impact to any resource.
   *
   * This preview collection includes ServiceIssue, PlannedMaintenance, and
   * HealthAdvisory events, including retirement advisories. It excludes
   * SecurityAdvisory and Billing events.
   *
   * Events retain their original subscription-scoped IDs. An event with the
   * same tracking ID in two subscriptions remains two separate records. Access
   * requires both preview tenant enablement and Azure role-based access control
   * authorization. Returns HTTP 403 with the standard error response when the
   * caller is not authorized or the tenant is not enabled for this preview,
   * without disclosing membership or health data.
   * To continue, follow the returned nextLink URL verbatim,
   * including when a page has an empty value array. Continuation values are opaque.
   */
  @get
  @list
  @armResourceList(Event)
  @segment("events")
  listEvents is ArmReadOperation<
    ServiceGroupHealthParameters,
    ArmResponse<Events>,
    Azure.ResourceManager.ErrorResponse
  >;
}
