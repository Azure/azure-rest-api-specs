import "@typespec/versioning";
import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Monitor {
  /**
   * Operations for a trace association at a supported Azure scope.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This generic interface supplies operations to the concrete resource-group and subscription operation groups."
  interface TraceAssociationScopeOperations<Scope extends Azure.ResourceManager.Foundations.SimpleResource> {
    /**
     * Gets the trace association at the scope.
     */
    get is Extension.Read<Scope, TraceAssociationResource>;

    /**
     * Creates or replaces the trace association at the scope.
     */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The deployed trace association PUT contract returns 200 for both create and update."
    createOrUpdate is Extension.CreateOrReplaceSync<
      Scope,
      TraceAssociationResource,
      Response = ArmResourceUpdatedResponse<TraceAssociationResource>
    >;

    /**
     * Deletes the trace association at the scope.
     */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "The deployed trace association DELETE contract returns 204 when deletion succeeds."
    delete is Extension.DeleteSync<
      Scope,
      TraceAssociationResource,
      Response = ArmDeletedNoContentResponse
    >;

    /**
     * Lists the trace associations that apply to the scope.
     */
    list is Extension.ListByTarget<Scope, TraceAssociationResource>;
  }

  /**
   * Operations for trace associations at resource-group scope.
   */
  @added(Versions.v2026_09_03_preview)
  @armResourceOperations
  interface TraceAssociationsAtResourceGroup
    extends TraceAssociationScopeOperations<Extension.ResourceGroup> {}

  /**
   * Operations for trace associations at subscription scope.
   */
  @added(Versions.v2026_09_03_preview)
  @armResourceOperations
  interface TraceAssociationsAtSubscription
    extends TraceAssociationScopeOperations<Extension.Subscription> {}

  alias TraceAssociationResourceTargetParameters = {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /**
     * The provider namespace of the target resource.
     */
    @path
    @segment("providers")
    @key
    @pattern("^[a-zA-Z0-9.-]+$")
    providerName: string;

    /**
     * The resource type of the target resource.
     */
    @path
    @key
    providerType: string;

    /**
     * The name of the target resource.
     */
    @path
    @key
    @pattern("^[^/]+$")
    resourceName: string;
  };

  alias TraceAssociationResourceParentParameters = {
    ...Extension.ExtensionProviderNamespace<TraceAssociationResource>;
    ...ParentKeysOf<TraceAssociationResource>;
  };

  alias TraceAssociationResourceInstanceParameters = {
    ...Extension.ExtensionProviderNamespace<TraceAssociationResource>;
    ...KeysOf<TraceAssociationResource>;
  };

  alias TraceAssociationResourceOperations = Azure.ResourceManager.Legacy.ExtensionOperations<
    TraceAssociationResourceTargetParameters,
    TraceAssociationResourceParentParameters,
    TraceAssociationResourceInstanceParameters,
    "TraceAssociation"
  >;

  /**
   * Operations for trace associations at an Azure resource scope.
   */
  @added(Versions.v2026_09_03_preview)
  @armResourceOperations
  interface TraceAssociations {
    /**
     * Gets the trace association at the resource scope.
     */
    get is TraceAssociationResourceOperations.Read<TraceAssociationResource>;

    /**
     * Creates or replaces the trace association at the resource scope.
     */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The deployed trace association PUT contract returns 200 for both create and update."
    createOrUpdate is TraceAssociationResourceOperations.CreateOrUpdateSync<
      TraceAssociationResource,
      Response = ArmResourceUpdatedResponse<TraceAssociationResource>
    >;

    /**
     * Deletes the trace association at the resource scope.
     */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "The deployed trace association DELETE contract returns 204 when deletion succeeds."
    delete is TraceAssociationResourceOperations.DeleteSync<
      TraceAssociationResource,
      Response = ArmDeletedNoContentResponse
    >;

    /**
     * Lists the trace associations that apply to the resource scope.
     */
    list is TraceAssociationResourceOperations.List<TraceAssociationResource>;
  }
}
