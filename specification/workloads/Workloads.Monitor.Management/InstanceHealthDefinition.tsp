using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Workloads;

/** The instance health definition resource */
model InstanceHealthDefinition
  is TrackedResource<InstanceHealthDefinitionProperties> {
  ...ResourceNameParameter<
    Resource = InstanceHealthDefinition,
    NamePattern = ResourceNamePattern
  >;
}

/** The instance health definition properties */
model InstanceHealthDefinitionProperties is ResourceCommonProperties {
  /** The health definition version. It changes when there is a change in health definition. */
  @visibility("read")
  version?: string;

  /** The workload kind this health definition applicable for. Ex: SAP */
  @visibility("read", "create")
  workloadKind?: string;

  /** The compatible workload architectures */
  compatibleArchitectures?: string[];

  /** The health definitions for the supported workload components */
  @extension("x-ms-identifiers", ["type", "role"])
  componentHealthDefinitions: ComponentHealthDefinition[];

  /** The common resource signal definitions that are applicable across the components. */
  @extension("x-ms-identifiers", [])
  commonSignalDefinitionMappings?: ResourceSignalDefinitionMapping[];
}

/** The instance health definition operations */
@armResourceOperations
interface InstanceHealthDefinitions {
  /** Get the instance health definition */
  get is ArmResourceRead<InstanceHealthDefinition>;

  /** Create or replace the instance health definition */
  create is ArmResourceCreateOrReplaceAsync<InstanceHealthDefinition>;

  /** Update the instance health definition */
  update is ArmTagsPatchSync<InstanceHealthDefinition>;

  /** Delete the instance health definition */
  delete is ArmResourceDeleteWithoutOkAsync<InstanceHealthDefinition>;

  /** List instance health definitions by resource group */
  listByResourceGroup is ArmResourceListByParent<InstanceHealthDefinition>;

  /** List instance health definitions by subscription */
  listBySubscription is ArmListBySubscription<InstanceHealthDefinition>;
}
