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
 * An account-scoped binding from an Azure resource to an ACS policy.
 */
@added(Versions.v2026_09_15_preview)
@parentResource(Account)
model RaiBinding is Azure.ResourceManager.ProxyResource<RaiBindingProperties> {
  ...ResourceNameParameter<
    Resource = RaiBinding,
    KeyName = "raiBindingName",
    SegmentName = "raiBindings",
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

@@minLength(RaiBinding.name, 2);
@@maxLength(RaiBinding.name, 64);

/** Optional parameters for listing RAI bindings. */
@added(Versions.v2026_09_15_preview)
model RaiBindingListParameters {
  /**
   * The maximum number of RAI bindings to return. Defaults to 50.
   */
  @query("$top")
  @minValue(1)
  $top?: int32 = 50;
}

@added(Versions.v2026_09_15_preview)
@armResourceOperations
interface RaiBindings {
  /** Gets one RAI binding. */
  get is ArmResourceRead<
    RaiBinding,
    Response = ArmResponse<RaiBinding> & RaiResourceEtagResponseHeader
  >;

  /** Creates or replaces one RAI binding. */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    RaiBinding,
    Parameters = RaiResourcePutConditionalHeaders,
    Response =
      | (ArmResourceUpdatedResponse<RaiBinding> & RaiResourceEtagResponseHeader)
      | (ArmResourceCreatedSyncResponse<RaiBinding> &
          RaiResourceEtagResponseHeader)
  >;

  /** Deletes one RAI binding. */
  delete is ArmResourceDeleteSync<
    RaiBinding,
    Parameters = RaiResourceDeleteConditionalHeaders
  >;

  /** Lists RAI bindings on an account. */
  list is ArmResourceListByParent<
    RaiBinding,
    Parameters = RaiBindingListParameters,
    Response = RaiBindingListResult
  >;
}

@@doc(RaiBinding.name, "The name of the RAI binding.");
@@encodedName(RaiBinding.etag, "application/json", "etag");
@@doc(RaiBinding.properties, "Properties of the RAI binding.");
@@doc(RaiBindings.createOrUpdate::parameters.resource, "The RAI binding.");
