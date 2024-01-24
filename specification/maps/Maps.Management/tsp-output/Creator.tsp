import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MapsAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Maps;
/**
 * An Azure resource which represents Maps Creator product and provides ability to manage private location data.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(MapsAccount)
@Azure.ResourceManager.Private.armResourceInternal(CreatorProperties)
@includeInapplicableMetadataInPayload(false)
model Creator extends TrackedResourceBase {
  /**
   * The name of the Maps Creator instance.
   */
  @path
  @key("creatorName")
  @segment("creators")
  name: string;

  /**
   * The Creator resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: CreatorProperties;
}

@armResourceOperations
interface Creators {
  /**
   * Get a Maps Creator resource.
   */
  get is ArmResourceRead<Creator>;

  /**
   * Create or update a Maps Creator resource. Creator resource will manage Azure resources required to populate a custom set of mapping data. It requires an account to exist before it can be created.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Creator>;

  /**
   * Updates the Maps Creator resource. Only a subset of the parameters may be updated after creation, such as Tags.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Creator, CreatorUpdateParameters>;

  /**
   * Delete a Maps Creator resource.
   */
  delete is ArmResourceDeleteSync<Creator>;

  /**
   * Get all Creator instances for an Azure Maps Account
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Creators_ListByAccount")
  listByAccount is ArmResourceListByParent<Creator>;
}

@@projectedName(Creators.createOrUpdate::parameters.resource,
  "json",
  "CreatorResource"
);
@@extension(Creators.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "CreatorResource"
);
@@doc(Creators.createOrUpdate::parameters.resource,
  "The new or updated parameters for the Creator resource."
);
@@projectedName(Creators.update::parameters.properties,
  "json",
  "CreatorUpdateParameters"
);
@@extension(Creators.update::parameters.properties,
  "x-ms-client-name",
  "CreatorUpdateParameters"
);
@@doc(Creators.update::parameters.properties,
  "The update parameters for Maps Creator."
);
