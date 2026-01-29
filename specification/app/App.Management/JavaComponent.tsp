import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Java Component.
 */
model JavaComponent
  is Azure.ResourceManager.ProxyResource<JavaComponentProperties> {
  ...ResourceNameParameter<
    Resource = JavaComponent,
    KeyName = "name",
    SegmentName = "javaComponents",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

@armResourceOperations
interface JavaComponents {
  /**
   * Get a Java Component.
   */
  get is ArmResourceRead<JavaComponent>;

  /**
   * Creates or updates a Java Component in a Managed Environment.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<JavaComponent>;

  /**
   * Patches a Java Component using JSON Merge Patch
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<JavaComponent, PatchModel = JavaComponent>;

  /**
   * Delete a Java Component.
   */
  delete is ArmResourceDeleteWithoutOkAsync<JavaComponent>;

  /**
   * Get the Java Components for a managed environment.
   */
  list is ArmResourceListByParent<
    JavaComponent,
    Response = ArmResponse<JavaComponentsCollection>
  >;
}

@@doc(JavaComponent.name, "Name of the Java Component.");
@@doc(JavaComponent.properties, "Java Component resource specific properties");
@@doc(JavaComponents.createOrUpdate::parameters.resource,
  "Configuration details of the Java Component."
);
@@doc(JavaComponents.update::parameters.properties,
  "Configuration details of the Java Component."
);
