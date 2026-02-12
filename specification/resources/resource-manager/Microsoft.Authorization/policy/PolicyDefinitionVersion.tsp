import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PolicyDefinition.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Authorization;
/**
 * The ID of the policy definition version.
 */
@subscriptionResource
@parentResource(PolicyDefinition)
model PolicyDefinitionVersion
  is Azure.ResourceManager.ProxyResource<PolicyDefinitionVersionProperties> {
  ...ResourceNameParameter<
    Resource = PolicyDefinitionVersion,
    KeyName = "policyDefinitionVersion",
    SegmentName = "versions",
    NamePattern = "^\\d+\\.\\d+\\.\\d+$"
  >;
}

alias PolicyDefinitionVersionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";

    /** The name of the policy definition. */
    @path
    @segment("policyDefinitions")
    @key
    @pattern("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$")
    policyDefinitionName: string;
  },
  {},
  {
    /** The policy definition version.  The format is x.y.z where x is the major version number, y is the minor version number, and z is the patch number */
    @path
    @segment("versions")
    @key
    @pattern("^\\d+\\.\\d+\\.\\d+$")
    policyDefinitionVersion: string;
  }
>;

alias PolicyDefinitionVersionTenantOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";

    /** The name of the policy definition. */
    @path
    @segment("policyDefinitions")
    @key
    @pattern("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$")
    policyDefinitionName: string;
  },
  {},
  {
    /** The policy definition version.  The format is x.y.z where x is the major version number, y is the minor version number, and z is the patch number */
    @path
    @segment("versions")
    @key
    @pattern("^\\d+\\.\\d+\\.\\d+$")
    policyDefinitionVersion: string;
  }
>;

alias PolicyDefinitionVersionManagementGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Management";

    ...CommonTypes.ManagementGroupNameParameter;
  },
  {
    ...Extension.ExtensionProviderNamespace<PolicyDefinitionVersion>;

    /** The name of the policy definition. */
    @path
    @segment("policyDefinitions")
    @key
    @pattern("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$")
    policyDefinitionName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<PolicyDefinitionVersion>;

    /** The name of the policy definition. */
    @path
    @segment("policyDefinitions")
    @key
    @pattern("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$")
    policyDefinitionName: string;

    /** The policy definition version.  The format is x.y.z where x is the major version number, y is the minor version number, and z is the patch number */
    @path
    @segment("versions")
    @key
    @pattern("^\\d+\\.\\d+\\.\\d+$")
    policyDefinitionVersion: string;
  }
>;

@armResourceOperations
interface PolicyDefinitionVersions {
  /**
   * This operation retrieves the policy definition version in the given subscription with the given name.
   */
  get is PolicyDefinitionVersionOps.Read<PolicyDefinitionVersion>;

  /**
   * This operation creates or updates a policy definition in the given subscription with the given name.
   */
  createOrUpdate is PolicyDefinitionVersionOps.CreateOrUpdateSync<PolicyDefinitionVersion>;

  /**
   * This operation deletes the policy definition version in the given subscription with the given name.
   */
  delete is PolicyDefinitionVersionOps.DeleteSync<PolicyDefinitionVersion>;

  /**
   * This operation retrieves a list of all the policy definition versions for the given policy definition.
   */
  list is PolicyDefinitionVersionOps.List<
    PolicyDefinitionVersion,
    Parameters = {
      /**
       * Maximum number of records to return. When the $top filter is not provided, it will return 500 records.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * This operation retrieves the built-in policy definition version with the given name.
   */
  getBuiltIn is PolicyDefinitionVersionTenantOps.Read<PolicyDefinitionVersion>;

  /**
   * This operation retrieves a list of all the built-in policy definition versions for the given policy definition.
   */
  listBuiltIn is PolicyDefinitionVersionTenantOps.List<
    PolicyDefinitionVersion,
    Parameters = {
      /**
       * Maximum number of records to return. When the $top filter is not provided, it will return 500 records.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * This operation retrieves the policy definition version in the given management group with the given name.
   */
  getAtManagementGroup is PolicyDefinitionVersionManagementGroupOps.Read<PolicyDefinitionVersion>;

  /**
   * This operation creates or updates a policy definition version in the given management group with the given name.
   */
  createOrUpdateAtManagementGroup is PolicyDefinitionVersionManagementGroupOps.CreateOrUpdateSync<PolicyDefinitionVersion>;

  /**
   * This operation deletes the policy definition in the given management group with the given name.
   */
  deleteAtManagementGroup is PolicyDefinitionVersionManagementGroupOps.DeleteSync<PolicyDefinitionVersion>;

  /**
   * This operation retrieves a list of all the policy definition versions for the given policy definition in the given management group.
   */
  listByManagementGroup is PolicyDefinitionVersionManagementGroupOps.List<
    PolicyDefinitionVersion,
    Parameters = {
      /**
       * Maximum number of records to return. When the $top filter is not provided, it will return 500 records.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    }
  >;
}

@@doc(PolicyDefinitionVersion.name,
  "The policy definition version.  The format is x.y.z where x is the major version number, y is the minor version number, and z is the patch number"
);
@@doc(PolicyDefinitionVersion.properties,
  "The policy definition version properties."
);
@@doc(PolicyDefinitionVersions.createOrUpdate::parameters.resource,
  "The policy definition properties."
);
@@doc(PolicyDefinitionVersions.createOrUpdateAtManagementGroup::parameters.resource,
  "The policy definition properties."
);
