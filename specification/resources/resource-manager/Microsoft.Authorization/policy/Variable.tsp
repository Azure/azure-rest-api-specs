import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Authorization;
/**
 * The variable.
 */
// Preview-only resource type: added in the preview API version.
@added(Versions.v2025_12_01_preview)
@subscriptionResource
model Variable
  is Azure.ResourceManager.ProxyResource<PolicyVariableProperties> {
  ...ResourceNameParameter<
    Resource = Variable,
    KeyName = "variableName",
    SegmentName = "variables",
    NamePattern = "^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$"
  >;
}

alias VariableOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";
  },
  {},
  {
    /** The name of the variable to operate on. */
    @path
    @segment("variables")
    @key
    @pattern("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$")
    variableName: string;
  }
>;

alias VariableManagementGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Management";

    /** The ID of the management group. */
    @path
    @segment("managementGroups")
    @key
    managementGroupId: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<Variable>;
  },
  {
    ...Extension.ExtensionProviderNamespace<Variable>;

    /** The name of the variable to operate on. */
    @path
    @segment("variables")
    @key
    @pattern("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$")
    variableName: string;
  }
>;

@added(Versions.v2025_12_01_preview)
@armResourceOperations
interface Variables {
  /**
   * This operation retrieves a single variable, given its name and the subscription it was created at.
   */
  @summary("Retrieves a variable.")
  get is VariableOps.Read<Variable>;

  /**
   *  This operation creates or updates a variable with the given subscription and name. Policy variables can only be used by a policy definition at the scope they are created or below.
   */
  @summary("Creates or updates a variable.")
  createOrUpdate is VariableOps.CreateOrUpdateSync<Variable>;

  /**
   * This operation deletes a variable, given its name and the subscription it was created in. The scope of a variable is the part of its ID preceding '/providers/Microsoft.Authorization/variables/{variableName}'.
   */
  @summary("Deletes a variable.")
  delete is VariableOps.DeleteSync<Variable>;

  /**
   * This operation retrieves the list of all variables associated with the given subscription.
   */
  @summary("Retrieves all variables that are at this subscription level.")
  list is VariableOps.List<Variable>;

  /**
   * This operation retrieves a single variable, given its name and the  management group it was created at.
   */
  @summary("Retrieves a variable.")
  getAtManagementGroup is VariableManagementGroupOps.Read<Variable>;

  /**
   *  This operation creates or updates a variable with the given  management group and name. Policy variables can only be used by a policy definition at the scope they are created or below.
   */
  @summary("Creates or updates a variable.")
  createOrUpdateAtManagementGroup is VariableManagementGroupOps.CreateOrUpdateSync<Variable>;

  /**
   * This operation deletes a variable, given its name and the management group it was created in. The scope of a variable is the part of its ID preceding '/providers/Microsoft.Authorization/variables/{variableName}'.
   */
  @summary("Deletes a variable.")
  deleteAtManagementGroup is VariableManagementGroupOps.DeleteSync<Variable>;

  /**
   * This operation retrieves the list of all variables applicable to the management group.
   */
  @summary("Retrieves all variables that are at this management group level.")
  listForManagementGroup is VariableManagementGroupOps.List<Variable>;
}

@@doc(Variable.name, "The name of the variable to operate on.");
@@doc(Variable.properties, "Properties for the variable.");
@@doc(Variables.createOrUpdate::parameters.resource,
  "Parameters for the variable."
);
@@doc(Variables.createOrUpdateAtManagementGroup::parameters.resource,
  "Parameters for the variable."
);
