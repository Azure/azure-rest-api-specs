import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.EdgeOperator;

// ---------------------------------------------------------------------------
// Properties
// ---------------------------------------------------------------------------

/**
 * Observability configuration properties returned by Azure Local Disconnected Operations (ALDO).
 */
model ObservabilityConfigurationProperties {
  /** The resource group that owns the observability configuration. */
  @visibility(Lifecycle.Read)
  resourceGroup?: string;

  /** The Microsoft Entra tenant ID associated with the observability configuration. */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /** The Azure region where the observability configuration applies. */
  @visibility(Lifecycle.Read)
  location?: string;

  /** The customer Azure subscription ID associated with observability onboarding. This is distinct from the operator subscription ID in the request URI path. */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /** The Microsoft Entra application ID used for observability authentication. */
  @visibility(Lifecycle.Read)
  servicePrincipalId?: string;

  /** The cloud environment name. Defaults to `AzureCloud` when omitted by the service. */
  @visibility(Lifecycle.Read)
  cloud?: string;

  /** The original Azure region when the service remapped the requested location. */
  @visibility(Lifecycle.Read)
  originalLocation?: string;

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

// ---------------------------------------------------------------------------
// Resources
// ---------------------------------------------------------------------------

/**
 * The active observability configuration for a subscription.
 * This is a singleton resource; the only accepted resource name is `default`.
 */
@subscriptionResource
@singleton("default")
model ObservabilityConfiguration
  is ProxyResource<ObservabilityConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = ObservabilityConfiguration,
    SegmentName = "observabilityConfiguration"
  >;
}

// ---------------------------------------------------------------------------
// Interfaces
// ---------------------------------------------------------------------------

/**
 * Operations on the active observability configuration for a subscription.
 * The observability configuration is set on day 0 as part of onboarding, outside
 * of this ARM API. For now, only GET is exposed through this ARM API so
 * customers can read the configuration; the resource is a singleton and cannot
 * be deleted. The create-or-update (PUT) operation is temporarily removed
 * pending a security review of the credential fields it accepts; it will be
 * reintroduced once that review completes.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "ObservabilityConfiguration is a singleton proxy resource that intentionally does not support DELETE. The resource can only be retrieved via GET."
@armResourceOperations
@tag("ObservabilityConfiguration")
interface ObservabilityConfigurationOperations {
  /** Gets the active observability configuration for the subscription. */
  get is ArmResourceRead<ObservabilityConfiguration>;
}
