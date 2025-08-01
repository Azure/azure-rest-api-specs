import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MongoSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;
/**
 * The MongoInstance resource definition.
 */
@parentResource(MongoSite)
model MongoInstance
  is Azure.ResourceManager.ProxyResource<MongoInstanceProperties, false> {
  ...ResourceNameParameter<
    Resource = MongoInstance,
    KeyName = "instanceName",
    SegmentName = "MongoInstances",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface MongoInstances {
  /**
   * Gets the MongoInstances resource.
   */
  get is ArmResourceRead<MongoInstance>;

  /**
   * Puts the MongoInstances resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<MongoInstance>;

  /**
   * Patch the MongoInstances resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    MongoInstance,
    MongoInstanceResourcePatchProperties
  >;

  /**
   * Deletes the MongoInstances resource.
   */
  delete is ArmResourceDeleteSync<MongoInstance>;

  /**
   * Lists the MongoInstances resource in MongoSites.
   */
  listBySite is ArmResourceListByParent<
    MongoInstance,
    Response = ArmResponse<MongoInstanceList>
  >;
}

@@maxLength(MongoInstance.name, 63);
@@minLength(MongoInstance.name, 3);
@@doc(MongoInstance.name, "The name of Instance");
@@doc(MongoInstance.properties, "Resource properties.");
@@doc(MongoInstances.createOrUpdate::parameters.resource,
  "The machines to add to the assessment"
);
@@doc(MongoInstances.update::parameters.properties, "Clouds patch payload.");
