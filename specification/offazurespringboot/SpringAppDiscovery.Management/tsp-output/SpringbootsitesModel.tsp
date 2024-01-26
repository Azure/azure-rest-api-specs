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

namespace Microsoft.OffAzureSpringBoot;
/**
 * The springbootsites envelope resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SpringbootsitesProperties)
model SpringbootsitesModel extends TrackedResourceBase {
  /**
   * The springbootsites name.
   */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-z][a-z0-9-]*$")
  @path
  @key("springbootsitesName")
  @segment("springbootsites")
  @visibility("read")
  name: string;

  /**
   * The extended location definition.
   */
  extendedLocation?: SpringbootsitesModelExtendedLocation;

  /**
   * The springbootsites resource definition.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SpringbootsitesProperties;
}

@armResourceOperations
interface SpringbootsitesModels {
  /**
   * Get a springbootsites resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("springbootsites_Get")
  get is ArmResourceRead<SpringbootsitesModel>;

  /**
   * Create a springbootsites resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("springbootsites_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SpringbootsitesModel>;

  /**
   * Update a springbootsites resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("springbootsites_Update")
  update is ArmCustomPatchAsync<
    SpringbootsitesModel,
    SpringbootsitesPatch,
    BaseParameters<SpringbootsitesModel>,
    ArmLroLocationHeader
  >;

  /**
   * Delete a springbootsites resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("springbootsites_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    SpringbootsitesModel,
    BaseParameters<SpringbootsitesModel>,
    ArmLroLocationHeader
  >;

  /**
   * List springbootsites resource by resourceGroup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("springbootsites_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<SpringbootsitesModel>;

  /**
   * List springbootsites resource by subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("springbootsites_ListBySubscription")
  listBySubscription is ArmListBySubscription<SpringbootsitesModel>;

  /**
   * Trigger refresh springbootsites action
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("springbootsites_TriggerRefreshSite")
  triggerRefreshSite is ArmResourceActionNoResponseContentAsync<
    SpringbootsitesModel,
    void,
    BaseParameters<SpringbootsitesModel>,
    ArmLroLocationHeader
  >;
}

@@projectedName(SpringbootsitesModels.createOrUpdate::parameters.resource,
  "json",
  "springbootsites"
);
@@extension(SpringbootsitesModels.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "springbootsites"
);
@@doc(SpringbootsitesModels.createOrUpdate::parameters.resource,
  "Create a springbootsites payload."
);
@@projectedName(SpringbootsitesModels.update::parameters.properties,
  "json",
  "springbootsites"
);
@@extension(SpringbootsitesModels.update::parameters.properties,
  "x-ms-client-name",
  "springbootsites"
);
@@doc(SpringbootsitesModels.update::parameters.properties,
  "Update a springbootsites payload."
);
