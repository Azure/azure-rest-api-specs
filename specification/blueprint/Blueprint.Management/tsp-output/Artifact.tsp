import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Blueprint.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Blueprint;
// FIXME: Artifact has no properties property
/**
 * Represents a blueprint artifact.
 */
@parentResource(Blueprint)
model Artifact is ProxyResource<{}> {
  /**
   * Name of the blueprint artifact.
   */
  @path
  @key("artifactName")
  @segment("artifacts")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Artifacts {
  /**
   * Get a blueprint artifact.
   */
  get is ArmResourceRead<Artifact>;

  /**
   * Create or update blueprint artifact.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Artifact>;

  /**
   * Delete a blueprint artifact.
   */
  delete is ArmResourceDeleteSync<Artifact>;

  /**
   * List artifacts for a given blueprint definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Artifacts_List")
  list is ArmResourceListByParent<Artifact>;
}

@@projectedName(Artifacts.createOrUpdate::parameters.resource,
  "json",
  "artifact"
);
@@extension(Artifacts.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "artifact"
);
@@doc(Artifacts.createOrUpdate::parameters.resource,
  "Blueprint artifact to create or update."
);
