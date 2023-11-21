import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace HybridNetworkManagementClient;

interface ConfigurationGroupSchemasOperations {
  @doc("Gets information of the configuration group schemas under a publisher.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/configurationGroupSchemas")
  @get
  ListByPublisher is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    ConfigurationGroupSchemaListResult
  >;

  @doc("Deletes a specified configuration group schema.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/configurationGroupSchemas/{configurationGroupSchemaName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the configuration group schema.")
      @path
      configurationGroupSchemaName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Creates or updates a configuration group schema.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/configurationGroupSchemas/{configurationGroupSchemaName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the configuration group schema.")
      @path
      configurationGroupSchemaName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the create or update configuration group schema resource.")
      @body
      parameters: ConfigurationGroupSchema;
    },
    ConfigurationGroupSchema
  >;

  @doc("Gets information about the specified configuration group schema.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/configurationGroupSchemas/{configurationGroupSchemaName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the configuration group schema.")
      @path
      configurationGroupSchemaName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    ConfigurationGroupSchema
  >;

  @doc("Updates a configuration group schema resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/configurationGroupSchemas/{configurationGroupSchemaName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the configuration group schema.")
      @path
      configurationGroupSchemaName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("""
Parameters supplied to the create or update network service design version
operation.
""")
      @body
      parameters: TagsObject;
    },
    ConfigurationGroupSchema
  >;

  @doc("Update configuration group schema state.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/configurationGroupSchemas/{configurationGroupSchemaName}/updateState")
  @post
  updateState is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the configuration group schema.")
      @path
      configurationGroupSchemaName: string;

      @doc("Parameters supplied to update the state of configuration group schema.")
      @body
      parameters: ConfigurationGroupSchemaVersionUpdateState;
    },
    ConfigurationGroupSchemaVersionUpdateState | void
  >;
}

interface ConfigurationGroupValuesOperations {
  @doc("Deletes the specified hybrid configuration group value.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/configurationGroupValues/{configurationGroupValueName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the configuration group value.")
      @path
      configurationGroupValueName: string;
    },
    void
  >;

  @doc("Gets information about the specified hybrid configuration group values.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/configurationGroupValues/{configurationGroupValueName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the configuration group value.")
      @path
      configurationGroupValueName: string;
    },
    ConfigurationGroupValue
  >;

  @doc("Creates or updates a hybrid configuration group value.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/configurationGroupValues/{configurationGroupValueName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the configuration group value.")
      @path
      configurationGroupValueName: string;

      @doc("Parameters supplied to the create or update configuration group value resource.")
      @body
      parameters: ConfigurationGroupValue;
    },
    ConfigurationGroupValue
  >;

  @doc("Updates a hybrid configuration group tags.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/configurationGroupValues/{configurationGroupValueName}")
  @patch
  UpdateTags is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the configuration group value.")
      @path
      configurationGroupValueName: string;

      @doc("Parameters supplied to update configuration group values tags.")
      @body
      parameters: TagsObject;
    },
    ConfigurationGroupValue
  >;

  @doc("Lists all sites in the configuration group value in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HybridNetwork/configurationGroupValues")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    ConfigurationGroupValueListResult
  >;

  @doc("Lists all the hybrid network configurationGroupValues in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/configurationGroupValues")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    ConfigurationGroupValueListResult
  >;
}

interface NetworkFunctionsOperations {
  @doc("Deletes the specified network function resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/networkFunctions/{networkFunctionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the network function.")
      @path
      networkFunctionName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets information about the specified network function resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/networkFunctions/{networkFunctionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the network function resource.")
      @path
      networkFunctionName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    NetworkFunction
  >;

  @doc("Creates or updates a network function resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/networkFunctions/{networkFunctionName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Resource name for the network function resource.")
      @path
      networkFunctionName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("""
Parameters supplied in the body to the create or update network function
operation.
""")
      @body
      parameters: NetworkFunction;
    },
    NetworkFunction
  >;

  @doc("Updates the tags for the network function resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/networkFunctions/{networkFunctionName}")
  @patch
  UpdateTags is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Resource name for the network function resource.")
      @path
      networkFunctionName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the update network function tags operation.")
      @body
      parameters: TagsObject;
    },
    NetworkFunction
  >;

  @doc("Lists all the network functions in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HybridNetwork/networkFunctions")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    NetworkFunctionListResult
  >;

  @doc("Lists all the network function resources in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/networkFunctions")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    NetworkFunctionListResult
  >;

  @doc("Execute a request to services on a containerized network function.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/networkFunctions/{networkFunctionName}/executeRequest")
  @post
  ExecuteRequest is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the network function.")
      @path
      networkFunctionName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Payload for execute request post call.")
      @body
      parameters: ExecuteRequestParameters;
    },
    void
  >;
}

interface ComponentsOperations {
  @doc("Gets information about the specified application instance resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/networkFunctions/{networkFunctionName}/components/{componentName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the network function.")
      @path
      networkFunctionName: string;

      @doc("The name of the component.")
      @path
      componentName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    Component
  >;

  @doc("Lists all the component resources in a network function.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/networkFunctions/{networkFunctionName}/components")
  @get
  ListByNetworkFunction is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the network function.")
      @path
      networkFunctionName: string;
    },
    ComponentListResult
  >;
}

interface NetworkFunctionDefinitionGroupsOperations {
  @doc("Gets information of the network function definition groups under a publisher.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkFunctionDefinitionGroups")
  @get
  ListByPublisher is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    NetworkFunctionDefinitionGroupListResult
  >;

  @doc("Deletes a specified network function definition group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkFunctionDefinitionGroups/{networkFunctionDefinitionGroupName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network function definition group.")
      @path
      networkFunctionDefinitionGroupName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Creates or updates a network function definition group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkFunctionDefinitionGroups/{networkFunctionDefinitionGroupName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network function definition group.")
      @path
      networkFunctionDefinitionGroupName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("""
Parameters supplied to the create or update publisher network function
definition group operation.
""")
      @body
      parameters: NetworkFunctionDefinitionGroup;
    },
    NetworkFunctionDefinitionGroup
  >;

  @doc("Gets information about the specified networkFunctionDefinition group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkFunctionDefinitionGroups/{networkFunctionDefinitionGroupName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network function definition group.")
      @path
      networkFunctionDefinitionGroupName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    NetworkFunctionDefinitionGroup
  >;

  @doc("Updates a network function definition group resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkFunctionDefinitionGroups/{networkFunctionDefinitionGroupName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network function definition group.")
      @path
      networkFunctionDefinitionGroupName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("""
Parameters supplied to the create or update publisher network function
definition group operation.
""")
      @body
      parameters: TagsObject;
    },
    NetworkFunctionDefinitionGroup
  >;
}

interface NetworkFunctionDefinitionVersionsOperations {
  @doc("Deletes the specified network function definition version.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkFunctionDefinitionGroups/{networkFunctionDefinitionGroupName}/networkFunctionDefinitionVersions/{networkFunctionDefinitionVersionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network function definition group.")
      @path
      networkFunctionDefinitionGroupName: string;

      @doc("""
The name of the network function definition version. The name should conform to
the SemVer 2.0.0 specification: https://semver.org/spec/v2.0.0.html.
""")
      @path
      networkFunctionDefinitionVersionName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Creates or updates a network function definition version.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkFunctionDefinitionGroups/{networkFunctionDefinitionGroupName}/networkFunctionDefinitionVersions/{networkFunctionDefinitionVersionName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network function definition group.")
      @path
      networkFunctionDefinitionGroupName: string;

      @doc("""
The name of the network function definition version. The name should conform to
the SemVer 2.0.0 specification: https://semver.org/spec/v2.0.0.html.
""")
      @path
      networkFunctionDefinitionVersionName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("""
Parameters supplied to the create or update network function definition version
operation.
""")
      @body
      parameters: NetworkFunctionDefinitionVersion;
    },
    NetworkFunctionDefinitionVersion
  >;

  @doc("Gets information about a network function definition version.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkFunctionDefinitionGroups/{networkFunctionDefinitionGroupName}/networkFunctionDefinitionVersions/{networkFunctionDefinitionVersionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network function definition group.")
      @path
      networkFunctionDefinitionGroupName: string;

      @doc("""
The name of the network function definition version. The name should conform to
the SemVer 2.0.0 specification: https://semver.org/spec/v2.0.0.html.
""")
      @path
      networkFunctionDefinitionVersionName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    NetworkFunctionDefinitionVersion
  >;

  @doc("Updates a network function definition version resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkFunctionDefinitionGroups/{networkFunctionDefinitionGroupName}/networkFunctionDefinitionVersions/{networkFunctionDefinitionVersionName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network function definition group.")
      @path
      networkFunctionDefinitionGroupName: string;

      @doc("""
The name of the network function definition version. The name should conform to
the SemVer 2.0.0 specification: https://semver.org/spec/v2.0.0.html.
""")
      @path
      networkFunctionDefinitionVersionName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("""
Parameters supplied to the create or update network function definition version
operation.
""")
      @body
      parameters: TagsObject;
    },
    NetworkFunctionDefinitionVersion
  >;

  @doc("""
Gets information about a list of network function definition versions under a
network function definition group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkFunctionDefinitionGroups/{networkFunctionDefinitionGroupName}/networkFunctionDefinitionVersions")
  @get
  ListByNetworkFunctionDefinitionGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network function definition group.")
      @path
      networkFunctionDefinitionGroupName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    NetworkFunctionDefinitionVersionListResult
  >;

  @doc("Update network function definition version state.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkFunctionDefinitionGroups/{networkFunctionDefinitionGroupName}/networkFunctionDefinitionVersions/{networkFunctionDefinitionVersionName}/updateState")
  @post
  updateState is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network function definition group.")
      @path
      networkFunctionDefinitionGroupName: string;

      @doc("""
The name of the network function definition version. The name should conform to
the SemVer 2.0.0 specification: https://semver.org/spec/v2.0.0.html.
""")
      @path
      networkFunctionDefinitionVersionName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to update the state of network function definition version.")
      @body
      parameters: NetworkFunctionDefinitionVersionUpdateState;
    },
    NetworkFunctionDefinitionVersionUpdateState | void
  >;
}

interface NetworkServiceDesignGroupsOperations {
  @doc("Gets information of the network service design groups under a publisher.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkServiceDesignGroups")
  @get
  ListByPublisher is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;
    },
    NetworkServiceDesignGroupListResult
  >;

  @doc("Deletes a specified network service design group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkServiceDesignGroups/{networkServiceDesignGroupName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network service design group.")
      @path
      networkServiceDesignGroupName: string;
    },
    void
  >;

  @doc("Creates or updates a network service design group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkServiceDesignGroups/{networkServiceDesignGroupName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network service design group.")
      @path
      networkServiceDesignGroupName: string;

      @doc("""
Parameters supplied to the create or update publisher network service design
group operation.
""")
      @body
      parameters: NetworkServiceDesignGroup;
    },
    NetworkServiceDesignGroup
  >;

  @doc("Gets information about the specified networkServiceDesign group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkServiceDesignGroups/{networkServiceDesignGroupName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network service design group.")
      @path
      networkServiceDesignGroupName: string;
    },
    NetworkServiceDesignGroup
  >;

  @doc("Updates a network service design groups resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkServiceDesignGroups/{networkServiceDesignGroupName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network service design group.")
      @path
      networkServiceDesignGroupName: string;

      @doc("""
Parameters supplied to the create or update publisher network service design
group operation.
""")
      @body
      parameters: TagsObject;
    },
    NetworkServiceDesignGroup
  >;
}

interface NetworkServiceDesignVersionsOperations {
  @doc("Deletes the specified network service design version.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkServiceDesignGroups/{networkServiceDesignGroupName}/networkServiceDesignVersions/{networkServiceDesignVersionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network service design group.")
      @path
      networkServiceDesignGroupName: string;

      @doc("""
The name of the network service design version. The name should conform to the
SemVer 2.0.0 specification: https://semver.org/spec/v2.0.0.html.
""")
      @path
      networkServiceDesignVersionName: string;
    },
    void
  >;

  @doc("Creates or updates a network service design version.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkServiceDesignGroups/{networkServiceDesignGroupName}/networkServiceDesignVersions/{networkServiceDesignVersionName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network service design group.")
      @path
      networkServiceDesignGroupName: string;

      @doc("""
The name of the network service design version. The name should conform to the
SemVer 2.0.0 specification: https://semver.org/spec/v2.0.0.html.
""")
      @path
      networkServiceDesignVersionName: string;

      @doc("""
Parameters supplied to the create or update network service design version
operation.
""")
      @body
      parameters: NetworkServiceDesignVersion;
    },
    NetworkServiceDesignVersion
  >;

  @doc("Gets information about a network service design version.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkServiceDesignGroups/{networkServiceDesignGroupName}/networkServiceDesignVersions/{networkServiceDesignVersionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network service design group.")
      @path
      networkServiceDesignGroupName: string;

      @doc("""
The name of the network service design version. The name should conform to the
SemVer 2.0.0 specification: https://semver.org/spec/v2.0.0.html.
""")
      @path
      networkServiceDesignVersionName: string;
    },
    NetworkServiceDesignVersion
  >;

  @doc("Updates a network service design version resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkServiceDesignGroups/{networkServiceDesignGroupName}/networkServiceDesignVersions/{networkServiceDesignVersionName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network service design group.")
      @path
      networkServiceDesignGroupName: string;

      @doc("""
The name of the network service design version. The name should conform to the
SemVer 2.0.0 specification: https://semver.org/spec/v2.0.0.html.
""")
      @path
      networkServiceDesignVersionName: string;

      @doc("""
Parameters supplied to the create or update network service design version
operation.
""")
      @body
      parameters: TagsObject;
    },
    NetworkServiceDesignVersion
  >;

  @doc("""
Gets information about a list of network service design versions under a
network service design group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkServiceDesignGroups/{networkServiceDesignGroupName}/networkServiceDesignVersions")
  @get
  ListByNetworkServiceDesignGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network service design group.")
      @path
      networkServiceDesignGroupName: string;
    },
    NetworkServiceDesignVersionListResult
  >;

  @doc("Update network service design version state.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/networkServiceDesignGroups/{networkServiceDesignGroupName}/networkServiceDesignVersions/{networkServiceDesignVersionName}/updateState")
  @post
  updateState is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the network service design group.")
      @path
      networkServiceDesignGroupName: string;

      @doc("""
The name of the network service design version. The name should conform to the
SemVer 2.0.0 specification: https://semver.org/spec/v2.0.0.html.
""")
      @path
      networkServiceDesignVersionName: string;

      @doc("Parameters supplied to update the state of network service design version.")
      @body
      parameters: NetworkServiceDesignVersionUpdateState;
    },
    NetworkServiceDesignVersionUpdateState | void
  >;
}

interface OperationsOperations {
  @doc("Gets a list of the operations.")
  @route("/providers/Microsoft.HybridNetwork/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface PublishersOperations {
  @doc("Lists all the publishers in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HybridNetwork/publishers")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    PublisherListResult
  >;

  @doc("Lists all the publishers in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    PublisherListResult
  >;

  @doc("Deletes the specified publisher.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets information about the specified publisher.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    Publisher
  >;

  @doc("Creates or updates a publisher.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the create publisher operation.")
      @body
      parameters: Publisher;
    },
    Publisher
  >;

  @doc("Update a publisher resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the create publisher operation.")
      @body
      parameters: TagsObject;
    },
    Publisher
  >;
}

interface ArtifactStoresOperations {
  @doc("Gets information of the ArtifactStores under publisher.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores")
  @get
  ListByPublisher is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    ArtifactStoreListResult
  >;

  @doc("Deletes the specified artifact store.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the artifact store.")
      @path
      artifactStoreName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Creates or updates a artifact store.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the artifact store.")
      @path
      artifactStoreName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the create or update application group operation.")
      @body
      parameters: ArtifactStore;
    },
    ArtifactStore
  >;

  @doc("Gets information about the specified artifact store.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the artifact store.")
      @path
      artifactStoreName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    ArtifactStore
  >;

  @doc("Update artifact store resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the artifact store.")
      @path
      artifactStoreName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the create or update application group operation.")
      @body
      parameters: TagsObject;
    },
    ArtifactStore
  >;
}

interface ArtifactManifestsOperations {
  @doc("Gets information about the artifact manifest.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/artifactManifests")
  @get
  ListByArtifactStore is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the artifact store.")
      @path
      artifactStoreName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    ArtifactManifestListResult
  >;

  @doc("Deletes the specified artifact manifest.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/artifactManifests/{artifactManifestName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the artifact store.")
      @path
      artifactStoreName: string;

      @doc("The name of the artifact manifest.")
      @path
      artifactManifestName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Creates or updates a artifact manifest.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/artifactManifests/{artifactManifestName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the artifact store.")
      @path
      artifactStoreName: string;

      @doc("The name of the artifact manifest.")
      @path
      artifactManifestName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the create or update artifact manifest operation.")
      @body
      parameters: ArtifactManifest;
    },
    ArtifactManifest
  >;

  @doc("Gets information about a artifact manifest resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/artifactManifests/{artifactManifestName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the artifact store.")
      @path
      artifactStoreName: string;

      @doc("The name of the artifact manifest.")
      @path
      artifactManifestName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    ArtifactManifest
  >;

  @doc("Updates a artifact manifest resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/artifactManifests/{artifactManifestName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the artifact store.")
      @path
      artifactStoreName: string;

      @doc("The name of the artifact manifest.")
      @path
      artifactManifestName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the create or update artifact manifest operation.")
      @body
      parameters: TagsObject;
    },
    ArtifactManifest
  >;

  @doc("List credential for publishing artifacts defined in artifact manifest.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/artifactManifests/{artifactManifestName}/listCredential")
  @post
  ListCredential is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the artifact store.")
      @path
      artifactStoreName: string;

      @doc("The name of the artifact manifest.")
      @path
      artifactManifestName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    ArtifactAccessCredential
  >;

  @doc("Update state for artifact manifest.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/artifactManifests/{artifactManifestName}/updateState")
  @post
  UpdateState is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the artifact store.")
      @path
      artifactStoreName: string;

      @doc("The name of the artifact manifest.")
      @path
      artifactManifestName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to update the state of artifact manifest.")
      @body
      parameters: ArtifactManifestUpdateState;
    },
    ArtifactManifestUpdateState | void
  >;
}

interface ProxyArtifactOperations {
  @doc("Lists all the available artifacts in the parent Artifact Store.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/artifacts")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the artifact store.")
      @path
      artifactStoreName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    ProxyArtifactOverviewListResult
  >;

  @doc("Get a Artifact overview information.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/artifactVersions")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the artifact store.")
      @path
      artifactStoreName: string;

      @doc("The name of the artifact.")
      @query
      artifactName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    ProxyArtifactVersionsOverviewListResult
  >;

  @doc("Change artifact state defined in artifact store.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/artifactVersions/{artifactVersionName}")
  @patch
  UpdateState is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @path
      publisherName: string;

      @doc("The name of the artifact store.")
      @path
      artifactStoreName: string;

      @doc("The name of the artifact.")
      @query
      artifactName: string;

      @doc("The name of the artifact version.")
      @path
      artifactVersionName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to update the state of artifact manifest.")
      @body
      parameters: ArtifactChangeState;
    },
    ProxyArtifactVersionsListOverview | void
  >;
}

interface SitesOperations {
  @doc("Deletes the specified network site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/sites/{siteName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the network service site.")
      @path
      siteName: string;
    },
    void
  >;

  @doc("Gets information about the specified network site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/sites/{siteName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the network service site.")
      @path
      siteName: string;
    },
    Site
  >;

  @doc("Creates or updates a network site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/sites/{siteName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the network service site.")
      @path
      siteName: string;

      @doc("Parameters supplied to the create or update network site operation.")
      @body
      parameters: Site;
    },
    Site
  >;

  @doc("Updates a site update tags.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/sites/{siteName}")
  @patch
  UpdateTags is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the network service site.")
      @path
      siteName: string;

      @doc("Parameters supplied to update network site tags.")
      @body
      parameters: TagsObject;
    },
    Site
  >;

  @doc("Lists all sites in the network service in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HybridNetwork/sites")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    SiteListResult
  >;

  @doc("Lists all sites in the network service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/sites")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    SiteListResult
  >;
}

interface SiteNetworkServicesOperations {
  @doc("Deletes the specified site network service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/siteNetworkServices/{siteNetworkServiceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the site network service.")
      @path
      siteNetworkServiceName: string;
    },
    void
  >;

  @doc("Gets information about the specified site network service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/siteNetworkServices/{siteNetworkServiceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the site network service.")
      @path
      siteNetworkServiceName: string;
    },
    SiteNetworkService
  >;

  @doc("Creates or updates a network site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/siteNetworkServices/{siteNetworkServiceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the site network service.")
      @path
      siteNetworkServiceName: string;

      @doc("Parameters supplied to the create or update site network service operation.")
      @body
      parameters: SiteNetworkService;
    },
    SiteNetworkService
  >;

  @doc("Updates a site update tags.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/siteNetworkServices/{siteNetworkServiceName}")
  @patch
  UpdateTags is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the site network service.")
      @path
      siteNetworkServiceName: string;

      @doc("Parameters supplied to update network site tags.")
      @body
      parameters: TagsObject;
    },
    SiteNetworkService
  >;

  @doc("Lists all sites in the network service in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HybridNetwork/siteNetworkServices")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    SiteNetworkServiceListResult
  >;

  @doc("Lists all site network services.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/siteNetworkServices")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    SiteNetworkServiceListResult
  >;
}
