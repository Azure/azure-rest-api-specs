import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

/**
 * A builder app resource. A builder app binds a source repository and branch to a managed
 * build-and-host pipeline; one resource represents one app.
 */
@added(Versions.v2026_09_01_preview)
model BuilderApp
  is Azure.ResourceManager.TrackedResource<BuilderAppProperties> {
  ...ResourceNameParameter<
    Resource = BuilderApp,
    KeyName = "name",
    SegmentName = "builderApps",
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]{1,58}[A-Za-z0-9]$"
  >;
}

/**
 * The properties of a builder app.
 */
@added(Versions.v2026_09_01_preview)
model BuilderAppProperties {
  /**
   * The source repository and branch the app is built from. This is the identity of the app and
   * cannot be changed after the resource is created.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  source: BuilderAppSource;

  /**
   * The status of the last operation performed on the resource. This describes the resource
   * operation only and does not reflect the health of the running app.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BuilderAppProvisioningState;

  /**
   * A read-only reflection of the deployment the app is currently serving. The platform
   * re-materializes this on every deployment; it is never supplied by the caller.
   */
  @visibility(Lifecycle.Read)
  runtime?: BuilderAppRuntime;

  /**
   * Configuration variables injected into the app as environment variables. Values are write-only
   * and are never returned. The array is authoritative on write: a variable omitted from the array
   * is removed, and a variable supplied without a value keeps its existing value.
   */
  @identifiers(#["name"])
  variables?: BuilderAppVariable[];
}

/**
 * The source repository and branch a builder app is built from.
 */
@added(Versions.v2026_09_01_preview)
model BuilderAppSource {
  /**
   * The source provider the app gets its code from.
   */
  type: BuilderAppSourceType;

  /**
   * The numeric identifier of the source repository. This is a durable key that survives a
   * repository rename.
   */
  repositoryId: int64;

  /**
   * The fully qualified name of the source repository, in the form 'owner/repository'.
   */
  repositoryFullName: string;

  /**
   * The branch the app is built from.
   */
  branch: string;
}

/**
 * The source provider a builder app gets its code from.
 */
@added(Versions.v2026_09_01_preview)
union BuilderAppSourceType {
  /**
   * The app is built from a GitHub repository.
   */
  GitHub: "github",

  string,
}

/**
 * The provisioning state of a builder app.
 */
@added(Versions.v2026_09_01_preview)
@Azure.Core.lroStatus
union BuilderAppProvisioningState {
  ResourceProvisioningState,

  /**
   * The resource is being created.
   */
  Creating: "Creating",

  /**
   * The resource is being updated.
   */
  Updating: "Updating",

  /**
   * The resource is being deleted.
   */
  Deleting: "Deleting",

  string,
}

/**
 * A read-only reflection of the deployment a builder app is currently serving.
 */
@added(Versions.v2026_09_01_preview)
model BuilderAppRuntime {
  /**
   * The public URL the app is served from.
   */
  @visibility(Lifecycle.Read)
  url?: url;

  /**
   * The identifier of the run the app currently points at. Runs are managed by the platform and
   * are not Azure Resource Manager resources.
   */
  @visibility(Lifecycle.Read)
  activeRunId?: string;

  /**
   * The identifier of the deployment the active run was created from. Deployments are managed by
   * the platform and are not Azure Resource Manager resources.
   */
  @visibility(Lifecycle.Read)
  activeDeploymentId?: string;

  /**
   * The components the active deployment produced. The order of the array determines route
   * precedence, with the longest matching path winning.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  components?: BuilderAppRuntimeComponent[];
}

/**
 * A component of the deployment a builder app is currently serving.
 */
@added(Versions.v2026_09_01_preview)
model BuilderAppRuntimeComponent {
  /**
   * The name of the component.
   */
  @visibility(Lifecycle.Read)
  name: string;

  /**
   * The role the component performs at runtime.
   */
  @visibility(Lifecycle.Read)
  role?: BuilderAppComponentRole;

  /**
   * How the component was built.
   */
  @visibility(Lifecycle.Read)
  source?: BuilderAppComponentSource;

  /**
   * The public path the component is mounted at. This is not set when the component is not
   * publicly served.
   */
  @visibility(Lifecycle.Read)
  path?: string;

  /**
   * Whether the component is reachable only from other components of the same app and is not
   * publicly served.
   */
  @visibility(Lifecycle.Read)
  internal?: boolean;

  /**
   * The build outputs the component produced.
   */
  @visibility(Lifecycle.Read)
  artifacts?: BuilderAppComponentArtifact[];

  /**
   * The commit the component was built from.
   */
  @visibility(Lifecycle.Read)
  commitSha?: string;
}

/**
 * The role a builder app component performs at runtime.
 */
@added(Versions.v2026_09_01_preview)
union BuilderAppComponentRole {
  /**
   * The component is a set of static assets served by the platform and has no process.
   */
  Static: "static",

  /**
   * The component is an HTTP server process.
   */
  Web: "web",

  /**
   * The component is a background process that does not serve HTTP traffic.
   */
  Worker: "worker",

  string,
}

/**
 * How a builder app component was built.
 */
@added(Versions.v2026_09_01_preview)
union BuilderAppComponentSource {
  /**
   * The component was built by a framework the platform detected.
   */
  Framework: "framework",

  string,
}

/**
 * A build output a builder app component produced.
 */
@added(Versions.v2026_09_01_preview)
union BuilderAppComponentArtifact {
  /**
   * Static assets served from managed storage.
   */
  Static: "static",

  /**
   * A compute image that runs as a process.
   */
  Compute: "compute",

  string,
}

/**
 * A configuration variable injected into a builder app as an environment variable.
 */
@added(Versions.v2026_09_01_preview)
model BuilderAppVariable {
  /**
   * The name of the environment variable.
   */
  name: string;

  /**
   * The value of the variable. This property is write-only and is never returned. Omitting it on
   * an update keeps the existing value.
   */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  value?: string;

  /**
   * Where the value of the variable comes from. When not specified the value is supplied inline.
   */
  source?: BuilderAppVariableSource;

  /**
   * The URI of the key vault secret holding the value. This is only set when the source is
   * 'keyVault'.
   */
  keyVaultRef?: url;

  /**
   * The role the variable plays for the app, for example 'connectionString' or 'apiKey'.
   */
  role?: string;
}

/**
 * Where the value of a builder app variable comes from.
 */
@added(Versions.v2026_09_01_preview)
union BuilderAppVariableSource {
  /**
   * The value is supplied inline and is stored encrypted by the platform.
   */
  Inline: "inline",

  /**
   * The value is read from a key vault secret referenced by the variable.
   */
  KeyVault: "keyVault",

  string,
}

/**
 * The operations of builder apps.
 */
@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface BuilderApps {
  get is ArmResourceRead<BuilderApp>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BuilderApp>;
  update is ArmCustomPatchSync<
    BuilderApp,
    PatchModel = Azure.ResourceManager.Foundations.ResourceUpdateModel<
      BuilderApp,
      BuilderAppProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<BuilderApp>;
  listByResourceGroup is ArmResourceListByParent<BuilderApp>;
  listBySubscription is ArmListBySubscription<BuilderApp>;
}
