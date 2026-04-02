import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

using ApplicationInsightsCommonTypes;

namespace Components;
/**
 * An Application Insights component definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
model ApplicationInsightsComponent extends ComponentsResource {
  @visibility(Lifecycle.Read)
  @path
  @key("resourceName")
  @segment("components")
  name: string;

  /**
   * The kind of application that this component refers to, used to customize UI. This value is a freeform string, values should typically be one of the following: web, ios, other, store, java, phone.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind: string;

  /**
   * Resource etag
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  /**
   * Properties that define an Application Insights component resource.
   */
  properties?: ApplicationInsightsComponentProperties;
}

@armResourceOperations(#{ omitTags: true })
interface ApplicationInsightsComponents {
  /**
   * Returns an Application Insights component.
   */
  get is ArmResourceRead<
    ApplicationInsightsComponent,
    Error = ErrorResponseComponents
  >;

  /**
   * Creates (or updates) an Application Insights component. Note: You cannot specify a different value for InstrumentationKey nor AppId in the Put operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ApplicationInsightsComponent,
    Response = ArmResourceUpdatedResponse<ApplicationInsightsComponent>,
    Error = ErrorResponseComponents
  >;

  /**
   * Updates an existing component's tags. To update other fields use the CreateOrUpdate method.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    ApplicationInsightsComponent,
    PatchModel = TagsResource,
    Error = ErrorResponseComponents
  >;

  /**
   * Deletes an Application Insights component.
   */
  delete is ArmResourceDeleteSync<
    ApplicationInsightsComponent,
    Error = ErrorResponseComponents
  >;

  /**
   * Gets a list of Application Insights components within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ApplicationInsightsComponent,
    Error = ErrorResponseComponents
  >;

  /**
   * Gets a list of all Application Insights components within a subscription.
   */
  list is ArmListBySubscription<
    ApplicationInsightsComponent,
    Error = ErrorResponseComponents
  >;

  /**
   * Purges data in an Application Insights component by a set of user-defined filters.
   *
   * In order to manage system resources, purge requests are throttled at 50 requests per hour. You should batch the execution of purge requests by sending a single command whose predicate includes all user identities that require purging. Use the in operator to specify multiple identities. You should run the query prior to using for a purge request to verify that the results are expected.
   * Note: this operation is intended for Classic resources, for  workspace-based Application Insights resource please run purge operation (directly on the workspace)(https://docs.microsoft.com/en-us/rest/api/loganalytics/workspace-purge/purge) , scoped to specific resource id.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  purge is ArmResourceActionSync<
    ApplicationInsightsComponent,
    ComponentPurgeBody,
    AcceptedResponse & {
      @bodyRoot
      _: ComponentPurgeResponse;
    },
    Error = ErrorResponseComponents
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ComponentPurgeStatusOperationGroup {
  /**
   * Get status for an ongoing purge operation.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/operations/{purgeId}")
  @get
  getPurgeStatus(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * In a purge status request, this is the Id of the operation the status of which is returned.
     */
    @path
    purgeId: string,
  ): ArmResponse<ComponentPurgeStatusResponse> | ErrorResponseComponents;
}

@@doc(ApplicationInsightsComponent.name,
  "The name of the Application Insights component resource."
);
@@doc(ApplicationInsightsComponent.properties,
  "Properties that define an Application Insights component resource."
);
@@doc(ApplicationInsightsComponents.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create an Application Insights component."
);
@@doc(ApplicationInsightsComponents.updateTags::parameters.properties,
  "Updated tag information to set into the component instance."
);
@@doc(ApplicationInsightsComponents.purge::parameters.body,
  "Describes the body of a request to purge data in a single table of an Application Insights component"
);
