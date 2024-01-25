import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MediaService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * An Account Filter.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(MediaService)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(MediaFilterProperties)
model AccountFilter extends ProxyResourceBase {
  /**
   * The Account Filter name
   */
  @path
  @key("filterName")
  @segment("accountFilters")
  @visibility("read")
  name: string;

  /**
   * The Media Filter properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MediaFilterProperties;
}

@armResourceOperations
interface AccountFilters {
  /**
   * Get the details of an Account Filter in the Media Services account.
   */
  get is ArmResourceRead<AccountFilter>;

  /**
   * Creates or updates an Account Filter in the Media Services account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<AccountFilter>;

  /**
   * Updates an existing Account Filter in the Media Services account.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<AccountFilter, AccountFilter>;

  /**
   * Deletes an Account Filter in the Media Services account.
   */
  delete is ArmResourceDeleteSync<AccountFilter>;

  /**
   * List Account Filters in the Media Services account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AccountFilters_List")
  list is ArmResourceListByParent<AccountFilter>;
}

@@projectedName(AccountFilters.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(AccountFilters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(AccountFilters.createOrUpdate::parameters.resource,
  "The request parameters"
);
@@projectedName(AccountFilters.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(AccountFilters.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(AccountFilters.update::parameters.properties, "The request parameters");
