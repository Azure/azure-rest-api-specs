import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DeviceUpdate;
/**
 * Device Update instance details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Account)
@Azure.ResourceManager.Private.armResourceInternal(InstanceProperties)
@includeInapplicableMetadataInPayload(false)
model Instance extends TrackedResourceBase {
  /**
   * Instance name.
   */
  @maxLength(36)
  @minLength(3)
  @pattern("^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$")
  @path
  @key("instanceName")
  @segment("instances")
  name: string;

  /**
   * Device Update instance properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: InstanceProperties;
}

@armResourceOperations
interface Instances {
  /**
   * Returns instance details for the given instance and account name.
   */
  get is ArmResourceRead<Instance>;

  /**
   * Creates or updates instance.
   */
  create is ArmResourceCreateOrReplaceAsync<
    Instance,
    BaseParameters<Instance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates instance's tags.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Instance, TagUpdate>;

  /**
   * Deletes instance.
   */
  delete is ArmResourceDeleteAsync<
    Instance,
    BaseParameters<Instance>,
    ArmLroLocationHeader
  >;

  /**
   * Returns instances for the given account name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Instances_ListByAccount")
  listByAccount is ArmResourceListByParent<Instance>;
}

@@projectedName(Instances.create::parameters.resource, "json", "Instance");
@@extension(Instances.create::parameters.resource,
  "x-ms-client-name",
  "Instance"
);
@@doc(Instances.create::parameters.resource, "Instance details.");
@@projectedName(Instances.update::parameters.properties,
  "json",
  "tagUpdatePayload"
);
@@extension(Instances.update::parameters.properties,
  "x-ms-client-name",
  "tagUpdatePayload"
);
@@doc(Instances.update::parameters.properties, "Updated tags.");
