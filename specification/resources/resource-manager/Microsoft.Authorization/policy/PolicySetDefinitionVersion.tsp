import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PolicySetDefinition.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Authorization;
/**
 * The policy set definition version.
 */
@subscriptionResource
@parentResource(PolicySetDefinition)
model PolicySetDefinitionVersion
  is Azure.ResourceManager.ProxyResource<PolicySetDefinitionVersionProperties> {
  ...ResourceNameParameter<
    Resource = PolicySetDefinitionVersion,
    KeyName = "policyDefinitionVersion",
    SegmentName = "versions",
    NamePattern = "^\\d+\\.\\d+\\.\\d+$"
  >;
}

alias PolicySetDefinitionVersionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";

    /** The name of the policy set definition. */
    @path
    @segment("policySetDefinitions")
    @key
    @pattern("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$")
    policySetDefinitionName: string;
  },
  {},
  {
    /** The policy set definition version.  The format is x.y.z where x is the major version number, y is the minor version number, and z is the patch number */
    @path
    @segment("versions")
    @key
    @pattern("^\\d+\\.\\d+\\.\\d+$")
    policyDefinitionVersion: string;
  }
>;

alias PolicySetDefinitionVersionTenantOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";

    /** The name of the policy set definition. */
    @path
    @segment("policySetDefinitions")
    @key
    @pattern("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$")
    policySetDefinitionName: string;
  },
  {},
  {
    /** The policy set definition version.  The format is x.y.z where x is the major version number, y is the minor version number, and z is the patch number */
    @path
    @segment("versions")
    @key
    @pattern("^\\d+\\.\\d+\\.\\d+$")
    policyDefinitionVersion: string;
  }
>;

alias PolicySetDefinitionVersionManagementGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    ...Extension.ExtensionProviderNamespace<PolicySetDefinitionVersion>;

    /** The name of the policy set definition. */
    @path
    @segment("policySetDefinitions")
    @key
    @pattern("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$")
    policySetDefinitionName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<PolicySetDefinitionVersion>;

    /** The name of the policy set definition. */
    @path
    @segment("policySetDefinitions")
    @key
    @pattern("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$")
    policySetDefinitionName: string;

    /** The policy set definition version.  The format is x.y.z where x is the major version number, y is the minor version number, and z is the patch number */
    @path
    @segment("versions")
    @key
    @pattern("^\\d+\\.\\d+\\.\\d+$")
    policyDefinitionVersion: string;
  }
>;

@armResourceOperations
interface PolicySetDefinitionVersions {
  /**
   * This operation retrieves the policy set definition version in the given subscription with the given name and version.
   */
  get is PolicySetDefinitionVersionOps.Read<
    PolicySetDefinitionVersion,
    Parameters = {
      /**
       * Comma-separated list of additional properties to be included in the response. Supported values are 'LatestDefinitionVersion, EffectiveDefinitionVersion'.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * This operation creates or updates a policy set definition version in the given subscription with the given name and version.
   */
  createOrUpdate is PolicySetDefinitionVersionOps.CreateOrUpdateSync<PolicySetDefinitionVersion>;

  /**
   * This operation deletes the policy set definition version in the given subscription with the given name and version.
   */
  delete is PolicySetDefinitionVersionOps.DeleteSync<PolicySetDefinitionVersion>;

  /**
   * This operation retrieves a list of all the policy set definition versions for the given policy set definition.
   */
  list is PolicySetDefinitionVersionOps.List<
    PolicySetDefinitionVersion,
    Parameters = {
      /**
       * Comma-separated list of additional properties to be included in the response. Supported values are 'LatestDefinitionVersion, EffectiveDefinitionVersion'.
       */
      @query("$expand")
      $expand?: string;

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
   * This operation retrieves the built-in policy set definition version with the given name and version.
   */
  getBuiltIn is PolicySetDefinitionVersionTenantOps.Read<
    PolicySetDefinitionVersion,
    Parameters = {
      /**
       * Comma-separated list of additional properties to be included in the response. Supported values are 'LatestDefinitionVersion, EffectiveDefinitionVersion'.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * This operation retrieves a list of all the built-in policy set definition versions for the given built-in policy set definition.
   */
  listBuiltIn is PolicySetDefinitionVersionTenantOps.List<
    PolicySetDefinitionVersion,
    Parameters = {
      /**
       * Comma-separated list of additional properties to be included in the response. Supported values are 'LatestDefinitionVersion, EffectiveDefinitionVersion'.
       */
      @query("$expand")
      $expand?: string;

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
   * This operation retrieves the policy set definition version in the given management group with the given name and version.
   */
  getAtManagementGroup is PolicySetDefinitionVersionManagementGroupOps.Read<
    PolicySetDefinitionVersion,
    Parameters = {
      /**
       * Comma-separated list of additional properties to be included in the response. Supported values are 'LatestDefinitionVersion, EffectiveDefinitionVersion'.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * This operation creates or updates a policy set definition version in the given management group with the given name and version.
   */
  createOrUpdateAtManagementGroup is PolicySetDefinitionVersionManagementGroupOps.CreateOrUpdateSync<PolicySetDefinitionVersion>;

  /**
   * This operation deletes the policy set definition version in the given management group with the given name and version.
   */
  deleteAtManagementGroup is PolicySetDefinitionVersionManagementGroupOps.DeleteSync<PolicySetDefinitionVersion>;

  /**
   * This operation retrieves a list of all the policy set definition versions for the given policy set definition in a given management group.
   */
  listByManagementGroup is PolicySetDefinitionVersionManagementGroupOps.List<
    PolicySetDefinitionVersion,
    Parameters = {
      /**
       * Comma-separated list of additional properties to be included in the response. Supported values are 'LatestDefinitionVersion, EffectiveDefinitionVersion'.
       */
      @query("$expand")
      $expand?: string;

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

@@doc(PolicySetDefinitionVersion.name,
  "The policy set definition version.  The format is x.y.z where x is the major version number, y is the minor version number, and z is the patch number"
);
@@doc(PolicySetDefinitionVersion.properties,
  "The policy set definition version properties."
);
@@doc(PolicySetDefinitionVersions.createOrUpdate::parameters.resource,
  "The policy set definition properties."
);
@@doc(PolicySetDefinitionVersions.createOrUpdateAtManagementGroup::parameters.resource,
  "The policy set definition version properties."
);
