import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

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
    ApplicationResource>;
  //   {
  //     /**
  //      * The ID of the target subscription.
  //      */
  //     @minLength(1)
  //     @path
  //     subscriptionId: string;

  //     /**
  //      * The name of the resource group. The name is case insensitive.
  //      */
  //     @maxLength(90)
  //     @minLength(1)
  //     @path
  //     resourceGroupName: string;

  //     /**
  //      * The number of result items to return.
  //      */
  //     @query("top")
  //     top?: int32;

  //     /**
  //      * The number of result items to skip.
  //      */
  //     @query("skip")
  //     skip?: int32;

  //     /**
  //      * The maximum number of result items per page.
  //      */
  //     @query("maxpagesize")
  //     maxpagesize?: int32;

  //     /**
  //      * Filter the result list using the given expression.
  //      */
  //     @query("filter")
  //     filter?: string;

  //     /**
  //      * Select the specified fields to be included in the response.
  //      */
  //     @query({
  //       name: "select",
  //       format: "multi",
  //     })
  //     select?: string[];

  //     /**
  //      * Expand the indicated resources into the response.
  //      */
  //     @query({
  //       name: "expand",
  //       format: "multi",
  //     })
  //     expand?: string[];

  //     /**
  //      * Expressions that specify the order of returned results.
  //      */
  //     @query({
  //       name: "orderby",
  //       format: "multi",
  //     })
  //     orderby?: string[];

  //     /**
  //      * The name of the space
  //      */
  //     @pattern("[a-zA-Z0-9_.()-]{0,79}$")
  //     @path
  //     spaceName: string;

  //     /**
  //      * The name of the Application
  //      */
  //     @pattern("[a-zA-Z0-9_.()-]{0,79}$")
  //     @path
  //     applicationName: string;
  //   },
  //   ApplicationResourceListResult
  // >;
}
