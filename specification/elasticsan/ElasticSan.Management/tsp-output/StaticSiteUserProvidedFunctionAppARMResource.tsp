import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StaticSiteBuildARMResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
@doc("Static Site User Provided Function App ARM resource.")
@parentResource(StaticSiteBuildARMResource)
model StaticSiteUserProvidedFunctionAppARMResource
  is ProxyResource<StaticSiteUserProvidedFunctionAppARMResourceProperties> {
  @doc("Name of the function app registered with the static site build.")
  @path
  @key("functionAppName")
  @segment("userProvidedFunctionApps")
  name: string;
}

@armResourceOperations
interface StaticSiteUserProvidedFunctionAppARMResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets the details of the user provided function app registered with a static site build")
  @operationId("StaticSites_GetUserProvidedFunctionAppForStaticSiteBuild")
  getUserProvidedFunctionAppForStaticSiteBuild is ArmResourceRead<StaticSiteUserProvidedFunctionAppARMResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Register a user provided function app with a static site build")
  @operationId("StaticSites_RegisterUserProvidedFunctionAppWithStaticSiteBuild")
  registerUserProvidedFunctionAppWithStaticSiteBuild is ArmResourceCreateOrUpdateAsync<
    StaticSiteUserProvidedFunctionAppARMResource,
    {
      ...BaseParameters<StaticSiteUserProvidedFunctionAppARMResource>;

      @doc("Specify <code>true</code> to force the update of the auth configuration on the function app even if an AzureStaticWebApps provider is already configured on the function app. The default is <code>false</code>.")
      @query("isForced")
      isForced?: boolean;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Detach the user provided function app from the static site build")
  @operationId("StaticSites_DetachUserProvidedFunctionAppFromStaticSiteBuild")
  detachUserProvidedFunctionAppFromStaticSiteBuild is ArmResourceDeleteSync<StaticSiteUserProvidedFunctionAppARMResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets the details of the user provided function apps registered with a static site build")
  @operationId("StaticSites_GetUserProvidedFunctionAppsForStaticSiteBuild")
  getUserProvidedFunctionAppsForStaticSiteBuild is ArmResourceListByParent<StaticSiteUserProvidedFunctionAppARMResource>;
}

@@projectedName(StaticSiteUserProvidedFunctionAppARMResources.registerUserProvidedFunctionAppWithStaticSiteBuild::parameters.resource,
  "json",
  "staticSiteUserProvidedFunctionEnvelope"
);
@@extension(StaticSiteUserProvidedFunctionAppARMResources.registerUserProvidedFunctionAppWithStaticSiteBuild::parameters.resource,
  "x-ms-client-name",
  "staticSiteUserProvidedFunctionEnvelope"
);
@@doc(StaticSiteUserProvidedFunctionAppARMResources.registerUserProvidedFunctionAppWithStaticSiteBuild::parameters.resource,
  "A JSON representation of the user provided function app properties. See example."
);
