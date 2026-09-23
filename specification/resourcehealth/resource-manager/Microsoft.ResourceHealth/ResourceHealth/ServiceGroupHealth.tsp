import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Microsoft.ResourceHealth;

/** Resource Health collections for service groups. */
@armProviderNamespace("Microsoft.ResourceHealth")
@service(#{ title: "Resource Health Service Groups" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.ResourceHealthServiceGroups;

/** The API versions for service group health collections. */
enum Versions {
  /** The 2026-08-01-preview API version. */
  @Azure.Core.previewVersion
  @useDependency(Microsoft.ResourceHealth.Versions.v2025_05_01)
  v2026_08_01_preview: "2026-08-01-preview",
}

/** Lists the operations available for the Resource Health provider. */
@added(Versions.v2026_08_01_preview)
interface Operations
  extends Azure.ResourceManager.Legacy.Operations<
      ArmResponse<ServiceGroupOperationListResult>,
      Microsoft.ResourceHealth.ErrorResponse
    > {}

/** Lists provider operations using the existing Resource Health response contract. */
model ServiceGroupOperationListResult
  is Microsoft.ResourceHealth.operationListResult;

@@pageItems(ServiceGroupOperationListResult.value);

/** Service health event properties, including optional planned maintenance information when available. */
model ServiceGroupEventProperties is EventProperties {
  /** Unique identifier for planned maintenance event. */
  maintenanceId?: string;

  /** The type of planned maintenance event. */
  maintenanceType?: string;

  /** Azure Resource Graph query to fetch the affected resources from their existing Azure Resource Graph locations. */
  argQuery?: string;
}

/** A service health event that retains its original subscription-scoped identity and resource metadata. */
model ServiceGroupEvent {
  ...OmitProperties<Azure.ResourceManager.CommonTypes.Resource, "type">;

  /** The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts" */
  @visibility(Lifecycle.Read)
  type?: string;

  /** Properties of the event. Optional maintenance information is returned only when available. */
  properties?: ServiceGroupEventProperties;
}

/** A page of service health events potentially relevant to the service group. */
model ServiceGroupEvents is Azure.Core.Page<ServiceGroupEvent>;

/** Current resource availability with optional resource creation and modification metadata. */
model ServiceGroupAvailabilityStatus {
  ...OmitProperties<AvailabilityStatus, "location">;

  /** Azure Resource Manager geo location of the resource. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /** Azure Resource Manager metadata containing createdBy and modifiedBy information, when available. */
  @visibility(Lifecycle.Read)
  systemData?: Azure.ResourceManager.CommonTypes.SystemData;
}

/** A page of current resource availability statuses for direct service group members. */
model ServiceGroupAvailabilityStatusListResult {
  ...OmitProperties<availabilityStatusListResult, "value">;

  /** The current resource availability statuses. */
  @pageItems
  value: ServiceGroupAvailabilityStatus[];
}

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
    ArmResponse<ServiceGroupAvailabilityStatusListResult>,
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
    ArmResponse<ServiceGroupEvents>,
    Azure.ResourceManager.ErrorResponse
  >;
}
