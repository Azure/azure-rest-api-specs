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
/**
 * Web app configuration ARM resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("web")
@parentResource(Site)
@includeInapplicableMetadataInPayload(false)
model SiteConfig extends ProxyOnlyResource {
  @key("config")
  @segment("config")
  @visibility("read")
  name: string;

  /**
   * Core resource properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: SiteConfigProperties;
}

@armResourceOperations
interface SiteConfigs {
  /**
   * Description for Gets the configuration of an app, such as platform version and bitness, default documents, virtual applications, Always On, etc.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetConfiguration")
  getConfiguration is ArmResourceRead<SiteConfig>;

  /**
   * Description for Updates the configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateConfiguration")
  createOrUpdateConfiguration is ArmResourceCreateOrReplaceSync<SiteConfig>;

  /**
   * Description for Updates the configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("WebApps_UpdateConfiguration")
  updateConfiguration is ArmCustomPatchSync<SiteConfig, SiteConfig>;

  /**
   * Description for List the configurations of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListConfigurations")
  listConfigurations is ArmResourceListByParent<SiteConfig>;

  /**
   * Description for Gets a list of web app configuration snapshots identifiers. Each element of the list contains a timestamp and the ID of the snapshot.
   */
  // FIXME: WebApps_ListConfigurationSnapshotInfo could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListConfigurationSnapshotInfo")
  @summary("Gets a list of web app configuration snapshots identifiers. Each element of the list contains a timestamp and the ID of the snapshot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/web/snapshots")
  @get
  listConfigurationSnapshotInfo is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
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
