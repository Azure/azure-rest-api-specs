import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;
/**
 * Schema for Application properties.
 */
@parentResource(ApplicationGroup)
model Application
  is Azure.ResourceManager.ProxyResource<ApplicationProperties, false> {
  ...ResourceNameParameter<
    Resource = Application,
    KeyName = "applicationName",
    SegmentName = "applications",
    NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
  >;
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Application,
    ApplicationPatch,
    Request = {
      /**
       * The resource properties to be updated
       */
      @bodyRoot application?: ApplicationPatch;
    }
  >;

  /**
   * Remove an application.
   */
  delete is ArmResourceDeleteSync<Application>;

  /**
   * List applications.
   */
  list is ArmResourceListByParent<
    Application,
    Parameters = {
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
    },
    Response = ApplicationList
  >;
}

@@maxLength(Application.name, 24);
@@minLength(Application.name, 3);
@@doc(Application.name,
  "The name of the application within the specified application group"
);
@@doc(Application.properties, "Detailed properties for Application");
@@doc(Applications.createOrUpdate::parameters.resource,
  "Object containing Application definitions."
);
