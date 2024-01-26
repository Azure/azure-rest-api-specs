import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ConnectedVMwarevSphere;
/**
 * Define the datastore.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(DatastoreProperties)
model Datastore extends TrackedResourceBase {
  /**
   * Name of the datastore.
   */
  @path
  @key("datastoreName")
  @segment("datastores")
  @visibility("read")
  name: string;

  /**
   * Gets or sets the extended location.
   */
  extendedLocation?: ExtendedLocation;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type; e.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value.
   */
  kind?: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: DatastoreProperties;
}

@armResourceOperations
interface Datastores {
  /**
   * Implements datastore GET method.
   */
  get is ArmResourceRead<Datastore>;

  /**
   * Create Or Update datastore.
   */
  create is ArmResourceCreateOrReplaceAsync<
    Datastore,
    BaseParameters<Datastore>,
    ArmAsyncOperationHeader
  >;

  /**
   * API to update certain properties of the datastore resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Datastore, ResourcePatch>;

  /**
   * Implements datastore DELETE method.
   */
  delete is ArmResourceDeleteAsync<
    Datastore,
    {
      ...BaseParameters<Datastore>;

      /**
       * Whether force delete was specified.
       */
      @query("force")
      force?: boolean;
    }
  >;

  /**
   * List of datastores in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Datastores_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Datastore>;

  /**
   * List of datastores in a subscription.
   */
  list is ArmListBySubscription<Datastore>;
}

@@projectedName(Datastores.create::parameters.resource, "json", "body");
@@extension(Datastores.create::parameters.resource, "x-ms-client-name", "body");
@@doc(Datastores.create::parameters.resource, "Request payload.");
@@projectedName(Datastores.update::parameters.properties, "json", "body");
@@extension(Datastores.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(Datastores.update::parameters.properties,
  "Resource properties to update."
);
