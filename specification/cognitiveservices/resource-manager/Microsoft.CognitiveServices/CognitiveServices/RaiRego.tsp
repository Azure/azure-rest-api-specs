import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

/**
 * An account-scoped reusable Rego artifact.
 */
@added(Versions.v2026_09_15_preview)
@parentResource(Account)
model RaiRego is Azure.ResourceManager.ProxyResource<RaiRegoProperties> {
  ...ResourceNameParameter<
    Resource = RaiRego,
    KeyName = "raiRegoName",
    SegmentName = "raiRegos",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  /** Resource ETag. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Cognitive Services uses the lowercase etag field for nested resources"
  @visibility(Lifecycle.Read)
  etag?: string;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Cognitive Services supports tags on this proxy resource"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<string> preserves the existing Cognitive Services tag shape"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@@minLength(RaiRego.name, 2);
@@maxLength(RaiRego.name, 64);

/** Optional parameters for listing reusable Rego artifacts. */
@added(Versions.v2026_09_15_preview)
model RaiRegoListParameters {
  /**
   * The maximum number of reusable Rego artifacts to return. Defaults to 10.
   */
  @query("$top")
  @minValue(1)
  $top?: int32 = 10;
}

@added(Versions.v2026_09_15_preview)
@armResourceOperations
interface RaiRegos {
  /** Gets one reusable Rego artifact. */
  get is ArmResourceRead<
    RaiRego,
    Response = ArmResponse<RaiRego> & RaiResourceEtagResponseHeader
  >;

  /** Creates or replaces one reusable Rego artifact. */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    RaiRego,
    Parameters = RaiResourcePutConditionalHeaders,
    Response =
      | (ArmResourceUpdatedResponse<RaiRego> & RaiResourceEtagResponseHeader)
      | (ArmResourceCreatedSyncResponse<RaiRego> &
          RaiResourceEtagResponseHeader)
  >;

  /** Deletes one reusable Rego artifact. */
  delete is ArmResourceDeleteSync<
    RaiRego,
    Parameters = RaiResourceDeleteConditionalHeaders
  >;

  /** Lists reusable Rego artifacts on an account. */
  list is ArmResourceListByParent<
    RaiRego,
    Parameters = RaiRegoListParameters,
    Response = RaiRegoListResult
  >;
}

@@doc(RaiRego.name, "The name of the reusable Rego artifact.");
@@encodedName(RaiRego.etag, "application/json", "etag");
@@doc(RaiRego.properties, "Properties of the reusable Rego artifact.");
@@doc(
  RaiRegos.createOrUpdate::parameters.resource,
  "The reusable Rego artifact."
);
