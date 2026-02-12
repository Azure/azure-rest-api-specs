import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StaticSiteBuildARMResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Static Site User Provided Function App ARM resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(StaticSiteBuildARMResource)
model StaticSiteUserProvidedFunctionAppARMResource
  is Azure.ResourceManager.ProxyResource<StaticSiteUserProvidedFunctionAppARMResourceProperties> {
  ...ResourceNameParameter<
    Resource = StaticSiteUserProvidedFunctionAppARMResource,
    KeyName = "functionAppName",
    SegmentName = "userProvidedFunctionApps",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface StaticSiteUserProvidedFunctionAppARMResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the static site. */
        @path
        @segment("staticSites")
        @key
        name: string,

        /** The stage site identifier. */
        @path
        @segment("builds")
        @key
        environmentName: string,
      },
      {
        /** Name of the function app registered with the static site build. */
        @path
        @segment("userProvidedFunctionApps")
        @key
        functionAppName: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface StaticSiteUserProvidedFunctionAppARMResources {
  /**
   * Description for Gets the details of the user provided function app registered with a static site build
   */
  @summary("Gets the details of the user provided function app registered with a static site build")
  getUserProvidedFunctionAppForStaticSiteBuild is StaticSiteUserProvidedFunctionAppARMResourceOps.Read<
    StaticSiteUserProvidedFunctionAppARMResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Register a user provided function app with a static site build
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Register a user provided function app with a static site build")
  registerUserProvidedFunctionAppWithStaticSiteBuild is StaticSiteUserProvidedFunctionAppARMResourceOps.CreateOrUpdateAsync<
    StaticSiteUserProvidedFunctionAppARMResource,
    Parameters = {
      /**
       * Specify <code>true</code> to force the update of the auth configuration on the function app even if an AzureStaticWebApps provider is already configured on the function app. The default is <code>false</code>.
       */
      @query("isForced")
      isForced?: boolean;
    },
    Response = ArmResourceUpdatedResponse<StaticSiteUserProvidedFunctionAppARMResource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = StaticSiteUserProvidedFunctionAppARMResource>> & {
      @bodyRoot
      _: StaticSiteUserProvidedFunctionAppARMResource;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Detach the user provided function app from the static site build
   */
  @summary("Detach the user provided function app from the static site build")
  detachUserProvidedFunctionAppFromStaticSiteBuild is StaticSiteUserProvidedFunctionAppARMResourceOps.DeleteSync<
    StaticSiteUserProvidedFunctionAppARMResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the details of the user provided function apps registered with a static site build
   */
  @summary("Gets the details of the user provided function apps registered with a static site build")
  getUserProvidedFunctionAppsForStaticSiteBuild is StaticSiteUserProvidedFunctionAppARMResourceOps.List<
    StaticSiteUserProvidedFunctionAppARMResource,
    Response = ArmResponse<StaticSiteUserProvidedFunctionAppsCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface StaticSiteUserProvidedFunctionAppARMResourceOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the static site. */
        @path
        @segment("staticSites")
        @key
        name: string,
      },
      {
        /** Name of the function app registered with the static site. */
        @path
        @segment("userProvidedFunctionApps")
        @key
        functionAppName: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface StaticSiteUserProvidedFunctionAppARMResourceOperationGroup {
  /**
   * Description for Gets the details of the user provided function app registered with a static site
   */
  @summary("Gets the details of the user provided function app registered with a static site")
  getUserProvidedFunctionAppForStaticSite is StaticSiteUserProvidedFunctionAppARMResourceOperationGroupOps.Read<
    StaticSiteUserProvidedFunctionAppARMResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Register a user provided function app with a static site
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Register a user provided function app with a static site")
  registerUserProvidedFunctionAppWithStaticSite is StaticSiteUserProvidedFunctionAppARMResourceOperationGroupOps.CreateOrUpdateAsync<
    StaticSiteUserProvidedFunctionAppARMResource,
    Parameters = {
      /**
       * Specify <code>true</code> to force the update of the auth configuration on the function app even if an AzureStaticWebApps provider is already configured on the function app. The default is <code>false</code>.
       */
      @query("isForced")
      isForced?: boolean;
    },
    Response = ArmResourceUpdatedResponse<StaticSiteUserProvidedFunctionAppARMResource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = StaticSiteUserProvidedFunctionAppARMResource>> & {
      @bodyRoot
      _: StaticSiteUserProvidedFunctionAppARMResource;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Detach the user provided function app from the static site
   */
  @summary("Detach the user provided function app from the static site")
  detachUserProvidedFunctionAppFromStaticSite is StaticSiteUserProvidedFunctionAppARMResourceOperationGroupOps.DeleteSync<
    StaticSiteUserProvidedFunctionAppARMResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the details of the user provided function apps registered with a static site
   */
  @summary("Gets the details of the user provided function apps registered with a static site")
  getUserProvidedFunctionAppsForStaticSite is StaticSiteUserProvidedFunctionAppARMResourceOperationGroupOps.List<
    StaticSiteUserProvidedFunctionAppARMResource,
    Response = ArmResponse<StaticSiteUserProvidedFunctionAppsCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(StaticSiteUserProvidedFunctionAppARMResource.name,
  "Name of the function app registered with the static site build."
);
@@doc(StaticSiteUserProvidedFunctionAppARMResource.properties,
  "StaticSiteUserProvidedFunctionAppARMResource resource specific properties"
);
@@doc(StaticSiteUserProvidedFunctionAppARMResources.registerUserProvidedFunctionAppWithStaticSiteBuild::parameters.resource,
  "A JSON representation of the user provided function app properties. See example."
);
@@doc(StaticSiteUserProvidedFunctionAppARMResourceOperationGroup.registerUserProvidedFunctionAppWithStaticSite::parameters.resource,
  "A JSON representation of the user provided function app properties. See example."
);
