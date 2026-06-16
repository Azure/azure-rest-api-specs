import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataCollection;
/**
 * Definition of generic ARM proxy resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model DataCollectionRuleAssociationProxyOnlyResource
  is Azure.ResourceManager.ExtensionResource<DataCollectionRuleAssociationProxyOnlyResourceProperties> {
  ...ResourceNameParameter<
    Resource = DataCollectionRuleAssociationProxyOnlyResource,
    KeyName = "associationName",
    SegmentName = "dataCollectionRuleAssociations",
    NamePattern = ""
  >;
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

alias DataCollectionRuleAssociationProxyOnlyResourcesOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;

    /**
     * The identifier of the resource.
     */
    @path(#{ allowReserved: true })
    @minLength(1)
    resourceUri: string;

    ...Azure.ResourceManager.Legacy.Provider;

    /**
     * The name of the association. The name is case insensitive.
     */
    @path
    @segment("dataCollectionRuleAssociations")
    associationName: string;
  },
  {}
>;

@armResourceOperations(#{ omitTags: true })
interface DataCollectionRuleAssociationProxyOnlyResources {
  /**
   * Returns the specified association.
   */
  @tag("DataCollectionRuleAssociations")
  @summary("Returns the specified association.")
  get is Extension.Read<
    Extension.ScopeParameter,
    DataCollectionRuleAssociationProxyOnlyResource,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Creates or updates an association.
   */
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("DataCollectionRuleAssociations")
  @summary("Creates or updates an association.")
  create is DataCollectionRuleAssociationProxyOnlyResourcesOps.CreateOrUpdateSync<
    DataCollectionRuleAssociationProxyOnlyResource,
    OptionalRequestBody = true,
    Response = DataCollectionRuleAssociationProxyOnlyResource | ArmResourceCreatedSyncResponse<DataCollectionRuleAssociationProxyOnlyResource>,
    OverrideErrorType = ErrorResponseCommonV2
  >;

  /**
   * Deletes an association.
   */
  @tag("DataCollectionRuleAssociations")
  @summary("Deletes an association.")
  delete is Extension.DeleteSync<
    Extension.ScopeParameter,
    DataCollectionRuleAssociationProxyOnlyResource,
    Error = ErrorResponseCommonV2
  >;

  /**
   * Lists associations for the specified resource.
   */
  @tag("DataCollectionRuleAssociations")
  @summary("Lists associations for the specified resource.")
  listByResource is Extension.ListByTarget<
    Extension.ScopeParameter,
    DataCollectionRuleAssociationProxyOnlyResource,
    Error = ErrorResponseCommonV2
  >;
}

@@doc(DataCollectionRuleAssociationProxyOnlyResource.name,
  "The name of the association. The name is case insensitive."
);
@@doc(DataCollectionRuleAssociationProxyOnlyResource.properties, "");
@@doc(DataCollectionRuleAssociationProxyOnlyResources.create::parameters.resource,
  "The payload"
);
@@key(Extension.ScopeParameter.scope, "resourceUri");
@@minLength(Extension.ScopeParameter.scope, 1);
