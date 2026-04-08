import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Management;

/**
 * The provisioning state of the serviceGroup. For example, Running
 */
union ProvisioningState {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

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

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

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
 * Response holding an array of service groups and a nextLink that supports pagination
 */
model ServiceGroupCollectionResponse is Azure.Core.Page<ServiceGroup>;
