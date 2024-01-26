import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SpringbootsitesModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzureSpringBoot;
/**
 * The springbootservers envelope resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(SpringbootsitesModel)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SpringbootserversProperties)
model SpringbootserversModel extends ProxyResourceBase {
  /**
   * The springbootservers name.
   */
  @maxLength(64)
  @minLength(3)
  @pattern("^[A-Za-z0-9][A-Za-z0-9-]*$")
  @path
  @key("springbootserversName")
  @segment("springbootservers")
  @visibility("read")
  name: string;

  /**
   * The springbootservers resource definition.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SpringbootserversProperties;
}

@armResourceOperations
interface SpringbootserversModels {
  /**
   * List springbootservers resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("springbootservers_Get")
  get is ArmResourceRead<SpringbootserversModel>;

  /**
   * Create springbootservers resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("springbootservers_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SpringbootserversModel>;

  /**
   * Update springbootservers resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("springbootservers_Update")
  update is ArmCustomPatchAsync<
    SpringbootserversModel,
    SpringbootserversPatch,
    BaseParameters<SpringbootserversModel>,
    ArmLroLocationHeader
  >;

  /**
   * Delete springbootservers resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("springbootservers_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    SpringbootserversModel,
    BaseParameters<SpringbootserversModel>,
    ArmLroLocationHeader
  >;

  /**
   * List springbootservers resource by resourceGroup
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("springbootservers_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<SpringbootserversModel>;

  /**
   * List springbootservers resource by subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("springbootservers_ListBySubscription")
  listBySubscription is ArmListBySubscription<SpringbootserversModel>;
}

@@projectedName(SpringbootserversModels.createOrUpdate::parameters.resource,
  "json",
  "springbootservers"
);
@@extension(SpringbootserversModels.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "springbootservers"
);
@@doc(SpringbootserversModels.createOrUpdate::parameters.resource,
  "Create a springbootservers payload."
);
@@projectedName(SpringbootserversModels.update::parameters.properties,
  "json",
  "springbootservers"
);
@@extension(SpringbootserversModels.update::parameters.properties,
  "x-ms-client-name",
  "springbootservers"
);
@@doc(SpringbootserversModels.update::parameters.properties,
  "Update a springbootservers payload."
);
