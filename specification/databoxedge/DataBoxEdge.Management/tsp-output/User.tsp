import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * Represents a user who has access to one or more shares on the Data Box Edge/Gateway device.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DataBoxEdgeDevice)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(UserProperties)
model User extends ProxyResourceBase {
  /**
   * The user name.
   */
  @path
  @key("name")
  @segment("users")
  @visibility("read")
  name: string;

  /**
   * The storage account credential properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: UserProperties;
}

@armResourceOperations
interface Users {
  /**
   * Gets the properties of the specified user.
   */
  get is ArmResourceRead<User>;

  /**
   * Creates a new user or updates an existing user's information on a Data Box Edge/Data Box Gateway device.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<User>;

  /**
   * Deletes the user on a databox edge/gateway device.
   */
  delete is ArmResourceDeleteAsync<User>;

  /**
   * Gets all the users registered on a Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Users_ListByDataBoxEdgeDevice")
  listByDataBoxEdgeDevice is ArmResourceListByParent<
    User,
    {
      ...BaseParameters<User>;

      /**
       * Specify $filter='Type eq <type>' to filter on user type property
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@projectedName(Users.createOrUpdate::parameters.resource, "json", "user");
@@extension(Users.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "user"
);
@@doc(Users.createOrUpdate::parameters.resource, "The user details.");
