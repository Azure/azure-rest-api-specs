import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Solutions;
/**
 * Information about managed application definition.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
model ApplicationDefinition extends GenericResource {
  @visibility(Lifecycle.Read)
  @path
  @key("applicationDefinitionName")
  @minLength(2)
  @maxLength(10)
  @segment("applicationDefinitions")
  name: string;

  /**
   * The managed application definition properties that can be updated.
   */
  properties: ApplicationDefinitionProperties;
}

alias ApplicationDefinitionOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
  },
  {
    /** The name of the managed application definition. */
    @path
    @key
    @minLength(3)
    @maxLength(64)
    @segment("applicationDefinitions")
    applicationDefinitionName: string;
  },
  ResourceRoute = #{ useStaticRoute: true }
>;

@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Solutions/applicationDefinitions/{applicationDefinitionName}")
@armResourceOperations(#{ allowStaticRoutes: true })
interface ApplicationDefinitions {
  /**
   * Gets the managed application definition.
   */
  @sharedRoute
  get is ApplicationDefinitionOps.Read<
    ApplicationDefinition,
    Response = ArmResponse<ApplicationDefinition> | NotFoundResponse
  >;

  /**
   * Creates or updates a managed application definition.
   */
  @sharedRoute
  createOrUpdate is ApplicationDefinitionOps.CreateOrUpdateSync<ApplicationDefinition>;

  /**
   * Updates the managed application definition.
   */
  @sharedRoute
  @patch(#{ implicitOptionality: false })
  update is ApplicationDefinitionOps.CustomPatchSync<
    ApplicationDefinition,
    PatchModel = ApplicationDefinitionPatchable
  >;

  /**
   * Deletes the managed application definition.
   */
  @sharedRoute
  delete is ApplicationDefinitionOps.DeleteSync<ApplicationDefinition>;
}

@tag("ApplicationDefinitions")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Solutions/applicationDefinitions/{applicationDefinitionName}?disambiguation_dummy")
@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface ApplicationDefinitionOpsById {
  /**
   * Gets the managed application definition.
   */
  @sharedRoute
  getById is ApplicationDefinitionOps.Read<
    ApplicationDefinition,
    Response = ArmResponse<ApplicationDefinition> | NotFoundResponse
  >;

  /**
   * Creates or updates a managed application definition.
   */
  @sharedRoute
  createOrUpdateById is ApplicationDefinitionOps.CreateOrUpdateSync<ApplicationDefinition>;

  /**
   * Updates the managed application definition.
   */
  @sharedRoute
  @patch(#{ implicitOptionality: false })
  updateById is ApplicationDefinitionOps.CustomPatchSync<
    ApplicationDefinition,
    PatchModel = ApplicationDefinitionPatchable
  >;

  /**
   * Deletes the managed application definition.
   */
  @sharedRoute
  deleteById is ApplicationDefinitionOps.DeleteSync<ApplicationDefinition>;
}

@armResourceOperations(#{ omitTags: true })
@tag("ApplicationDefinitions")
interface ApplicationDefinitionListOperationGroup {
  /**
   * Lists the managed application definitions in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<ApplicationDefinition>;

  /**
   * Lists all the application definitions within a subscription.
   */
  listBySubscription is ArmListBySubscription<ApplicationDefinition>;
}

@@maxLength(ApplicationDefinition.name, 64);
@@minLength(ApplicationDefinition.name, 3);
@@doc(
  ApplicationDefinition.name,
  "The name of the managed application definition."
);
@@doc(
  ApplicationDefinition.properties,
  "The managed application definition properties."
);
@@doc(
  ApplicationDefinitions.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update an managed application definition."
);
@@doc(
  ApplicationDefinitions.update::parameters.properties,
  "Parameters supplied to the update a managed application definition."
);
