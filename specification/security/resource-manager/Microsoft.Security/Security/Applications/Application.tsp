import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace ApplicationsAPI;
/**
 * Security Application over a given scope
 */
@subscriptionResource
model Application
  is Azure.ResourceManager.ProxyResource<ApplicationProperties> {
  ...ResourceNameParameter<
    Resource = Application,
    KeyName = "applicationId",
    SegmentName = "applications",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Applications {
  /**
   * Get a specific application for the requested scope by applicationId
   */
  get is Azure.ResourceManager.Extension.Read<
    Azure.ResourceManager.Extension.Subscription,
    Application,
    Error = CloudError
  >;

  /**
   * Creates or update a security application on the given subscription.
   */
  createOrUpdate is Azure.ResourceManager.Extension.CreateOrReplaceSync<
    Azure.ResourceManager.Extension.Subscription,
    Application,
    Error = CloudError
  >;

  /**
   * Delete an Application over a given scope
   */
  delete is Azure.ResourceManager.Extension.DeleteSync<
    Azure.ResourceManager.Extension.Subscription,
    Application,
    Error = CloudError
  >;

  /**
   * Get a list of all relevant applications over a subscription level scope
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    Azure.ResourceManager.Extension.Subscription,
    Application,
    Response = ArmResponse<ApplicationsList>,
    Error = CloudError
  >;
}
alias SecurityConnectorApplicationOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";

    /** The security connector name. */
    @path
    @segment("securityConnectors")
    @key
    securityConnectorName: string;
  },
  {
    ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<Application>;
  },
  {
    ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<Application>;

    /** The security Application key - unique key for the standard application */
    @path
    @segment("applications")
    @key
    applicationId: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface SecurityConnectorApplication {
  /**
   * Get a specific application for the requested scope by applicationId
   */
  @tag("Applications")
  get is SecurityConnectorApplicationOps.Read<
    Application,
    ErrorType = CloudError
  >;

  /**
   * Creates or update a security Application on the given security connector.
   */
  @tag("Applications")
  createOrUpdate is SecurityConnectorApplicationOps.CreateOrUpdateSync<
    Application,
    ErrorType = CloudError
  >;

  /**
   * Delete an Application over a given scope
   */
  @tag("Applications")
  delete is SecurityConnectorApplicationOps.DeleteSync<
    Application,
    ErrorType = CloudError
  >;

  /**
   * Get a list of all relevant applications over a security connector level scope
   */
  @tag("Applications")
  list is SecurityConnectorApplicationOps.List<
    Application,
    Response = ArmResponse<ApplicationsList>,
    ErrorType = CloudError
  >;
}

@@doc(Application.name,
  "The security Application key - unique key for the standard application"
);
@@doc(Application.properties, "Properties of a security application");
@@doc(Applications.createOrUpdate::parameters.resource,
  "Application over a subscription scope"
);
@@doc(SecurityConnectorApplication.createOrUpdate::parameters.resource,
  "Application over a subscription scope"
);



