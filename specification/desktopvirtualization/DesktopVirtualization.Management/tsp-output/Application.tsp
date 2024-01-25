import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
/**
 * Schema for Application properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ApplicationGroup)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ApplicationProperties)
model Application extends ProxyResourceBase {
  /**
   * The name of the application within the specified application group
   */
  @maxLength(24)
  @minLength(3)
  @path
  @key("applicationName")
  @segment("applications")
  @visibility("read")
  name: string;

  /**
   * Detailed properties for Application
   */
  @extension("x-ms-client-flatten", true)
  properties: ApplicationProperties;
}

@armResourceOperations
interface Applications {
  /**
   * Get an application.
   */
  get is ArmResourceRead<Application>;

  /**
   * Create or update an application.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Application>;

  /**
   * Update an application.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Application, ApplicationPatch>;

  /**
   * Remove an application.
   */
  delete is ArmResourceDeleteSync<Application>;

  /**
   * List applications.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Applications_List")
  list is ArmResourceListByParent<
    Application,
    {
      ...BaseParameters<Application>;

      /**
       * Number of items per page.
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      @query("initialSkip")
      initialSkip?: int32;
    }
  >;
}

@@projectedName(Applications.createOrUpdate::parameters.resource,
  "json",
  "application"
);
@@extension(Applications.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "application"
);
@@doc(Applications.createOrUpdate::parameters.resource,
  "Object containing Application definitions."
);
@@projectedName(Applications.update::parameters.properties,
  "json",
  "application"
);
@@extension(Applications.update::parameters.properties,
  "x-ms-client-name",
  "application"
);
@@doc(Applications.update::parameters.properties,
  "Object containing Application definitions."
);
