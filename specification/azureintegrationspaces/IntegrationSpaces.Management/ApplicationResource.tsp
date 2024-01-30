import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.IntegrationSpaces;

/**
 * A resource under application.
 */
@parentResource(Application)
model ApplicationResource is ProxyResource<ApplicationResourceProperties> {
  /**
   * The name of the Application
   */
  @pattern("[a-zA-Z0-9_.()-]{0,79}$")
  @doc("The name of the resource")
  @visibility("read")
  @segment("resources")
  @key("resourceName")
  name: string;
}

@armResourceOperations
interface ApplicationResources {
  /**
   * Get a ApplicationResource
   */
  get is ArmResourceRead<ApplicationResource>;

  /**
   * Create a ApplicationResource
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<ApplicationResource>;
  /**
   * Update a ApplicationResource
   */
  @parameterVisibility("read")
  patch is ArmCustomPatchSync<ApplicationResource, ApplicationResourceUpdate>;

  /**
   * Delete a ApplicationResource
   */
  delete is ArmResourceDeleteSync<ApplicationResource>;

  /**
   * List ApplicationResource resources by Application
   */
  listByApplication is ArmResourceListByParent<
    ApplicationResource,
    {
      ...BaseParameters<ApplicationResource>;

      ...TopQueryParameter;

      ...SkipQueryParameter;

      ...MaxPageSizeQueryParameter;

      ...FilterQueryParameter;

      ...SelectQueryParameter;

      ...ExpandQueryParameter;

      ...OrderByQueryParameter;
    }
  >;
}
