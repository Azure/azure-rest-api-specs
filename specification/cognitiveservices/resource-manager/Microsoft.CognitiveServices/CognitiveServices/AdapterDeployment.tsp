import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Account.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

/**
 * An independently managed LoRA adapter attached to a managed compute deployment.
 */
@added(Versions.v2026_09_15_preview)
@parentResource(Account)
model AdapterDeployment
  is Azure.ResourceManager.ProxyResource<AdapterDeploymentProperties> {
  ...ResourceNameParameter<
    Resource = AdapterDeployment,
    KeyName = "adapterDeploymentName",
    SegmentName = "adapterDeployments",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9._-]{0,63}$"
  >;

  /**
   * The concurrency token for this adapter deployment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Cognitive Services uses the lowercase etag envelope property."
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * A paginated collection of adapter deployments.
 */
@added(Versions.v2026_09_15_preview)
model AdapterDeploymentListResult {
  /**
   * Adapter deployments in this page.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value: AdapterDeployment[];

  /**
   * URL used to retrieve the next page, when one exists.
   */
  @nextLink
  nextLink?: url;
}

alias AdapterDeploymentIfMatchHeader = {
  /** Proceed only when the current adapter deployment ETag matches this value. */
  @header("If-Match")
  ifMatch?: string;
};

alias AdapterDeploymentPutConditionalHeaders = {
  ...AdapterDeploymentIfMatchHeader;

  /** Proceed only when no current adapter deployment ETag matches this value. */
  @header("If-None-Match")
  ifNoneMatch?: string;
};

alias AdapterDeploymentEtagResponseHeader = {
  /** The concurrency token for the adapter deployment. */
  @header("ETag")
  etag?: string;
};

alias AdapterDeploymentLroHeaders = {
  ...ArmCombinedLroHeaders<FinalResult = AdapterDeployment>;
  ...Azure.Core.Foundations.RetryAfterHeader;
  ...AdapterDeploymentEtagResponseHeader;
};

@added(Versions.v2026_09_15_preview)
@armResourceOperations
interface AdapterDeployments {
  /**
   * Gets an adapter deployment by name.
   */
  get is ArmResourceRead<
    AdapterDeployment,
    Response = ArmResponse<AdapterDeployment> &
      AdapterDeploymentEtagResponseHeader
  >;

  /**
   * Creates an adapter deployment or re-targets it to another compatible
   * managed compute deployment. The source model ID is immutable.
   * Returns 201 for a new adapter or 200 for an existing adapter, including retries.
   * Either response may require polling while provisioning is in progress.
   * After polling completes, retrieve the final resource from the original resource URL.
   * Omit conditional headers to allow either creation or update.
   * To create only when absent, send If-None-Match: *.
   * To update only a matching version, send If-Match with the ETag returned by GET.
   * Conditional requests, including retries, return 412 if the precondition is not met.
   */
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AdapterDeployment,
    Parameters = AdapterDeploymentPutConditionalHeaders,
    Response =
      | (ArmResourceUpdatedResponse<AdapterDeployment> &
          AdapterDeploymentLroHeaders)
      | ArmResourceCreatedResponse<
          AdapterDeployment,
          AdapterDeploymentLroHeaders
        >
  >;

  /**
   * Lists adapter deployments associated with the Cognitive Services account.
   */
  list is ArmResourceListByParent<
    AdapterDeployment,
    Response = ArmResponse<AdapterDeploymentListResult>
  >;

  /**
   * Drains requests and deletes an adapter deployment and its serving snapshot.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    AdapterDeployment,
    Parameters = AdapterDeploymentIfMatchHeader,
    LroHeaders = ArmCombinedLroHeaders<ArmOperationStatus, void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(
  AdapterDeployment.name,
  "The account-unique adapter deployment name and inference identity."
);
@@doc(
  AdapterDeployment.properties,
  "Properties of the Cognitive Services adapter deployment."
);
@@encodedName(AdapterDeployment.etag, "application/json", "etag");
@@doc(
  AdapterDeployments.createOrUpdate::parameters.resource,
  "The complete adapter deployment resource to create or re-target."
);
