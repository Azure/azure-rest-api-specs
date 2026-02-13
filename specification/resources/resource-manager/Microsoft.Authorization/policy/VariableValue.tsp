import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Variable.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Authorization;
/**
 * The variable value.
 */
@added(Versions.v2025_12_01_preview)
@subscriptionResource
@parentResource(Variable)
model VariableValue
  is Azure.ResourceManager.ProxyResource<PolicyVariableValueProperties> {
  ...ResourceNameParameter<
    Resource = VariableValue,
    KeyName = "variableValueName",
    SegmentName = "values",
    NamePattern = "^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$"
  >;
}

alias VariableValueOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";

    /** The name of the variable to operate on. */
    @path
    @segment("variables")
    @key
    variableName: string;
  },
  {},
  {
    /** The name of the variable value to operate on. */
    @path
    @segment("values")
    @key
    variableValueName: string;
  }
>;

alias VariableValueManagementGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    ...Extension.ExtensionProviderNamespace<VariableValue>;

    /** The name of the variable to operate on. */
    @path
    @segment("variables")
    @key
    variableName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<VariableValue>;

    /** The name of the variable to operate on. */
    @path
    @segment("variables")
    @key
    variableName: string;

    /** The name of the variable value to operate on. */
    @path
    @segment("values")
    @key
    variableValueName: string;
  }
>;

@added(Versions.v2025_12_01_preview)
@armResourceOperations
interface VariableValues {
  /**
   * This operation retrieves a single variable value; given its name, subscription it was created at and the variable it's created for.
   */
  get is VariableValueOps.Read<VariableValue>;

  /**
   *  This operation creates or updates a variable value with the given subscription and name for a given variable. Variable values are scoped to the variable for which they are created for.
   */
  createOrUpdate is VariableValueOps.CreateOrUpdateSync<VariableValue>;

  /**
   * This operation deletes a variable value, given its name, the subscription it was created in, and the variable it belongs to. The scope of a variable value is the part of its ID preceding '/providers/Microsoft.Authorization/variables/{variableName}'.
   */
  delete is VariableValueOps.DeleteSync<VariableValue>;

  /**
   * This operation retrieves the list of all variable values associated with the given variable that is at a subscription level.
   */
  list is VariableValueOps.List<VariableValue>;

  /**
   * This operation retrieves a single variable value; given its name,  management group it was created at and the variable it's created for.
   */
  getAtManagementGroup is VariableValueManagementGroupOps.Read<
    Extension.ManagementGroup,
    VariableValue
  >;

  /**
   *  This operation creates or updates a variable value with the given management group and name for a given variable. Variable values are scoped to the variable for which they are created for.
   */
  createOrUpdateAtManagementGroup is VariableValueManagementGroupOps.CreateOrUpdateSync<
    VariableValue
  >;

  /**
   * This operation deletes a variable value, given its name, the management group it was created in, and the variable it belongs to. The scope of a variable value is the part of its ID preceding '/providers/Microsoft.Authorization/variables/{variableName}'.
   */
  deleteAtManagementGroup is VariableValueManagementGroupOps.DeleteSync<
    Extension.ManagementGroup,
    VariableValue
  >;

  /**
   * This operation retrieves the list of all variable values applicable the variable indicated at the management group scope.
   */
  listForManagementGroup is VariableValueManagementGroupOps.List<
    Extension.ManagementGroup,
    VariableValue
  >;
}

@@doc(VariableValue.name, "The name of the variable value to operate on.");
@@doc(VariableValue.properties, "Properties for the variable value.");
@@doc(VariableValues.createOrUpdate::parameters.resource,
  "Parameters for the variable value."
);
@@doc(VariableValues.createOrUpdateAtManagementGroup::parameters.resource,
  "Parameters for the variable value."
);
