import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A managed instance key.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ManagedInstance)
@includeInapplicableMetadataInPayload(false)
model ManagedInstanceKey extends ProxyResource {
  /**
   * The name of the managed instance key to be retrieved.
   */
  @path
  @key("keyName")
  @segment("keys")
  @visibility("read")
  name: string;

  /**
   * Kind of encryption protector. This is metadata used for the Azure portal experience.
   */
  @visibility("read")
  kind?: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ManagedInstanceKeyProperties;
}

@armResourceOperations
interface ManagedInstanceKeys {
  /**
   * Gets a managed instance key.
   */
  get is ArmResourceRead<ManagedInstanceKey>;

  /**
   * Creates or updates a managed instance key.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedInstanceKey>;

  /**
   * Deletes the managed instance key with the given name.
   */
  delete is ArmResourceDeleteAsync<ManagedInstanceKey>;

  /**
   * Gets a list of managed instance keys.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstanceKeys_ListByInstance")
  listByInstance is ArmResourceListByParent<
    ManagedInstanceKey,
    {
      ...BaseParameters<ManagedInstanceKey>;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@projectedName(ManagedInstanceKeys.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedInstanceKeys.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedInstanceKeys.createOrUpdate::parameters.resource,
  "The requested managed instance key resource state."
);
