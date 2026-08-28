import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.EdgeOperator;

// ---------------------------------------------------------------------------
// Properties
// ---------------------------------------------------------------------------

/**
 * The readiness state of the Azure Local Disconnected Operations (ALDO) system.
 * All fields are computed by the resource provider and are read-only.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "SystemReadiness is a read-only, provider-computed singleton exposed via GET only. It has no write or long-running operations, so it has no provisioning lifecycle and intentionally does not carry a provisioningState property."
model SystemReadinessProperties {
  /** Indicates whether the system is ready. `true` when every readiness category has reported 100 percent. */
  @visibility(Lifecycle.Read)
  systemReady: boolean;

  /** The readiness percentage reported for each readiness category. */
  @visibility(Lifecycle.Read)
  @identifiers(#["categoryName"])
  readinessStatusDetails: ReadinessStatusDetail[];

  /** The error messages reported for each readiness category. A category presents messages when it is not ready and a specific error is available. */
  @visibility(Lifecycle.Read)
  @identifiers(#["categoryName"])
  errorMessages: ErrorMessageDetail[];
}

/** The readiness percentage reported for a single readiness category. */
model ReadinessStatusDetail {
  /** The provider-defined name of the readiness category (for example, `services`, `diagnostics`, `identity`, `networking`). Categories may be added, renamed, or removed without an API-version change and must be treated as an open string. */
  categoryName: string;

  /** The readiness percentage reported by the category, from 0 (not ready) to 100 (fully ready). */
  @minValue(0)
  @maxValue(100)
  readinessPercentage: int32;
}

/** The error messages reported for a single readiness category. Messages are present when the category is not ready and a specific error is available. */
model ErrorMessageDetail {
  /** The provider-defined name of the readiness category (for example, `services`, `diagnostics`, `identity`, `networking`). Categories may be added, renamed, or removed without an API-version change and must be treated as an open string. */
  categoryName: string;

  /** The list of error messages reported for the category. Present when the category is not ready and a specific error is available; otherwise empty. */
  errorMessageDetails: string[];
}

// ---------------------------------------------------------------------------
// Resources
// ---------------------------------------------------------------------------

/**
 * The system readiness status for Azure Local Disconnected Operations (ALDO).
 * Reports whether the ALDO system is ready. This is a read-only singleton resource — the only
 * accepted resource name is `default`.
 *
 * The subscription in the request path must be the Operator subscription. This subscription is used
 * only for the access check: the resource provider verifies it on every request, and only operators
 * have access to the Operator subscription and can therefore invoke the Microsoft.EdgeOperator APIs.
 * Requests scoped to any other subscription are rejected.
 */
@subscriptionResource
@singleton("default")
model SystemReadiness is ProxyResource<SystemReadinessProperties> {
  ...ResourceNameParameter<
    Resource = SystemReadiness,
    SegmentName = "systemReadiness"
  >;
}

// ---------------------------------------------------------------------------
// Interfaces
// ---------------------------------------------------------------------------

/**
 * Operations on the Azure Local Disconnected Operations (ALDO) system readiness status.
 * Only GET is supported. The resource is computed by the resource provider and cannot be
 * created, updated, or deleted by callers.
 *
 * The subscription in the request path must be the Operator subscription. This subscription is used
 * only for the access check: the resource provider verifies it on every request, and only operators
 * have access to the Operator subscription and can therefore invoke this operation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "SystemReadiness is a read-only, provider-computed singleton and intentionally does not support DELETE."
@armResourceOperations
interface SystemReadinessOperations {
  /** Gets the Azure Local Disconnected Operations (ALDO) system readiness status. */
  get is ArmResourceRead<SystemReadiness>;
}
