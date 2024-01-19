import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
@doc("Web app configuration ARM resource.")
@singleton("web")
@parentResource(Site)
model SiteConfig is ProxyResource<SiteConfigProperties> {
  @key("config")
  @segment("config")
  name: string;
}

@armResourceOperations
interface SiteConfigs {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets the configuration of an app, such as platform version and bitness, default documents, virtual applications, Always On, etc.")
  @operationId("WebApps_GetConfiguration")
  getConfiguration is ArmResourceRead<SiteConfig>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Updates the configuration of an app.")
  @operationId("WebApps_CreateOrUpdateConfiguration")
  createOrUpdateConfiguration is ArmResourceCreateOrReplaceSync<SiteConfig>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Updates the configuration of an app.")
  @operationId("WebApps_UpdateConfiguration")
  updateConfiguration is ArmCustomPatchSync<SiteConfig, SiteConfig>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for List the configurations of an app")
  @operationId("WebApps_ListConfigurations")
  listConfigurations is ArmResourceListByParent<SiteConfig>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListConfigurationSnapshotInfo")
  @summary("Gets a list of web app configuration snapshots identifiers. Each element of the list contains a timestamp and the ID of the snapshot.")
  @doc("Description for Gets a list of web app configuration snapshots identifiers. Each element of the list contains a timestamp and the ID of the snapshot.")
  // FIXME: WebApps_ListConfigurationSnapshotInfo could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/web/snapshots")
  @get
  listConfigurationSnapshotInfo is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SiteConfigurationSnapshotInfoCollection
  >;
}

@@projectedName(SiteConfigs.createOrUpdateConfiguration::parameters.resource,
  "json",
  "siteConfig"
);
@@extension(SiteConfigs.createOrUpdateConfiguration::parameters.resource,
  "x-ms-client-name",
  "siteConfig"
);
@@doc(SiteConfigs.createOrUpdateConfiguration::parameters.resource,
  "JSON representation of a SiteConfig object. See example."
);
@@projectedName(SiteConfigs.updateConfiguration::parameters.properties,
  "json",
  "siteConfig"
);
@@extension(SiteConfigs.updateConfiguration::parameters.properties,
  "x-ms-client-name",
  "siteConfig"
);
@@doc(SiteConfigs.updateConfiguration::parameters.properties,
  "JSON representation of a SiteConfig object. See example."
);
