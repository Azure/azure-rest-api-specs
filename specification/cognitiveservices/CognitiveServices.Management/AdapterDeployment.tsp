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
   * Resource tags used for organization and governance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The account child supports independent tags."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags are extensible key-value pairs."
  tags?: Record<string>;

  /**
   * The concurrency token for this adapter deployment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Cognitive Services uses the lowercase etag envelope property."
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Parameters used to filter adapter deployments.
 */
@added(Versions.v2026_09_15_preview)
model AdapterDeploymentListParameters {
  /**
   * Filters by target deployment, source model version, provisioning state,
   * or a supported conjunction of those predicates.
   */
  @query("$filter")
  filter?: string;
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
  nextLink?: string;
}

/**
 * Standard conditional headers accepted by adapter PUT operations.
 */
alias AdapterDeploymentPutConditions = {
  /**
   * Applies the re-target operation only when the current resource ETag
   * matches.
   */
  @header("If-Match")
  ifMatch?: string;

  /**
   * Use `*` for create-only behavior.
   */
  @header("If-None-Match")
  ifNoneMatch?: string;
};

/**
 * Conditional header required when deleting an existing adapter deployment.
 */
alias AdapterDeploymentDeleteConditions = {
  /**
   * Applies deletion only when the current resource ETag matches.
   */
  @header("If-Match")
  ifMatch: string;
};

alias AdapterDeploymentLroHeaders = ArmAsyncOperationHeader<FinalResult = AdapterDeployment> &
  Azure.Core.Foundations.RetryAfterHeader;

@added(Versions.v2026_09_15_preview)
@armResourceOperations
interface AdapterDeployments {
  /**
   * Gets an adapter deployment by name.
   */
  get is ArmResourceRead<AdapterDeployment>;

  /**
   * Creates an adapter deployment or re-targets it to another compatible
   * managed compute deployment. The source model ID is immutable. Create
   * requests use `If-None-Match: *`; re-target requests use `If-Match`.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AdapterDeployment,
    LroHeaders = AdapterDeploymentLroHeaders,
    Parameters = AdapterDeploymentPutConditions,
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
    Parameters = AdapterDeploymentListParameters,
    Response = ArmResponse<AdapterDeploymentListResult>
  >;

  /**
   * Drains requests and deletes an adapter deployment and its serving snapshot.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    AdapterDeployment,
    Parameters = AdapterDeploymentDeleteConditions,
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
