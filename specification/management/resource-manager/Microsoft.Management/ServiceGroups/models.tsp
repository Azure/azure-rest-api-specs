import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Management;

/**
 * The provisioning state of the serviceGroup. For example, Running
 */
union ProvisioningState {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Running
   */
  Running: "Running",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Failed
   */
  Failed: "Failed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * User
   */
  User: "User",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Application
   */
  Application: "Application",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Key
   */
  Key: "Key",
}

/**
 * ServiceGroup creation request body parameters.
 */
model ServiceGroupProperties {
  /**
   * The provisioning state of the serviceGroup. For example, Running
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The display name of the serviceGroup. For example, ServiceGroupTest1
   */
  displayName?: string;

  /**
   * The attributes of the serviceGroup.
   */
  @added(Versions.v2026_08_01)
  attributes?: ServiceGroupAttributes;

  /**
   * The details of the parent serviceGroup.
   */
  parent?: ParentServiceGroupProperties;
}

/**
 * The details of the parent serviceGroup.
 */
model ParentServiceGroupProperties {
  /**
   * The fully qualified ID of the parent serviceGroup.  For example, '/providers/Microsoft.Management/serviceGroups/TestServiceGroup'
   */
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Management/serviceGroups";
    }
  ]>;
}

/**
 * The attributes of the serviceGroup.
 */
@added(Versions.v2026_08_01)
model ServiceGroupAttributes {
  /** The criticality designation of the service group. Valid values range from 0 through 4. */
  @minValue(0)
  @maxValue(4)
  criticality?: int32;
}

/**
 * Response holding an array of service groups and a nextLink that supports pagination
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model ServiceGroupCollectionResponse is Azure.Core.Page<ServiceGroup>;
