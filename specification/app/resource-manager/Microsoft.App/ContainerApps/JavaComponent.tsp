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
@parentResource(ManagedEnvironment)
model JavaComponent
  is Azure.ResourceManager.ProxyResource<JavaComponentProperties> {
  ...ResourceNameParameter<
    Resource = JavaComponent,
    KeyName = "name",
    SegmentName = "javaComponents",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

alias JavaComponentOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the managed environment. */
    @path
    @segment("managedEnvironments")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    environmentName: string;
  },
  {
    /** Name of the Java Component. */
    @path
    @segment("javaComponents")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    name: string;
  }
>;

@armResourceOperations
interface JavaComponents {
  /**
   * Get a Java Component.
   */
  @summary("Get a Java Component.")
  get is JavaComponentOps.Read<JavaComponent>;

  /**
   * Creates or updates a Java Component in a Managed Environment.
   */
  @summary("Creates or updates a Java Component.")
  createOrUpdate is JavaComponentOps.CreateOrUpdateAsync<JavaComponent>;

  /**
   * Patches a Java Component using JSON Merge Patch
   */
  @patch(#{ implicitOptionality: false })
  @summary("Update properties of a Java Component")
  update is JavaComponentOps.CustomPatchAsync<
    JavaComponent,
    PatchModel = JavaComponent
  >;

  /**
   * Delete a Java Component.
   */
  @summary("Delete a Java Component.")
  delete is JavaComponentOps.DeleteWithoutOkAsync<JavaComponent>;

  /**
   * Get the Java Components for a managed environment.
   */
  @summary("Get the Java Components for a managed environment.")
  list is JavaComponentOps.List<
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
