import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace FrontDoorManagementClient;

interface PoliciesOperations {
  @doc("Lists all of the protection policies within a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    WebApplicationFirewallPolicyList
  >;

  @doc("Retrieve protection policy with specified name within a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/FrontDoorWebApplicationFirewallPolicies/{policyName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Web Application Firewall Policy.")
      @path
      policyName: string;

      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    WebApplicationFirewallPolicy
  >;

  @doc("Create or update policy with specified rule set name within a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/FrontDoorWebApplicationFirewallPolicies/{policyName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Web Application Firewall Policy.")
      @path
      policyName: string;

      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Policy to be created.")
      @body
      parameters: WebApplicationFirewallPolicy;
    },
    WebApplicationFirewallPolicy
  >;

  @doc("""
Patch a specific frontdoor webApplicationFirewall policy for tags update under
the specified subscription and resource group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/FrontDoorWebApplicationFirewallPolicies/{policyName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Web Application Firewall Policy.")
      @path
      policyName: string;

      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("FrontdoorWebApplicationFirewallPolicy parameters to be patched.")
      @body
      parameters: TagsObject;
    },
    WebApplicationFirewallPolicy
  >;

  @doc("Deletes Policy")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/FrontDoorWebApplicationFirewallPolicies/{policyName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Web Application Firewall Policy.")
      @path
      policyName: string;

      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface ManagedRuleSetsOperations {
  @doc("Lists all available managed rule sets.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Network/FrontDoorWebApplicationFirewallManagedRuleSets")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    ManagedRuleSetDefinitionList
  >;
}

interface FrontDoorNameAvailabilityOperations {
  @doc("Check the availability of a Front Door resource name.")
  @route("/providers/Microsoft.Network/checkFrontDoorNameAvailability")
  @post
  Check is Azure.Core.Foundations.Operation<
    {
      @doc("Input to check.")
      @body
      checkFrontDoorNameAvailabilityInput: CheckNameAvailabilityInput;
    },
    CheckNameAvailabilityOutput
  >;
}

interface FrontDoorNameAvailabilityWithSubscriptionOperations {
  @doc("Check the availability of a Front Door subdomain.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Network/checkFrontDoorNameAvailability")
  @post
  Check is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Input to check.")
      @body
      checkFrontDoorNameAvailabilityInput: CheckNameAvailabilityInput;
    },
    CheckNameAvailabilityOutput
  >;
}

interface FrontDoorsOperations {
  @doc("Lists all of the Front Doors within an Azure subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Network/frontDoors")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    FrontDoorListResult
  >;

  @doc("Lists all of the Front Doors within a resource group under a subscription.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/frontDoors")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;
    },
    FrontDoorListResult
  >;

  @doc("""
Gets a Front Door with the specified Front Door name under the specified
subscription and resource group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/frontDoors/{frontDoorName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("Name of the Front Door which is globally unique.")
      @path
      frontDoorName: string;
    },
    FrontDoor
  >;

  @doc("""
Creates a new Front Door with a Front Door name under the specified
subscription and resource group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/frontDoors/{frontDoorName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("Name of the Front Door which is globally unique.")
      @path
      frontDoorName: string;

      @doc("Front Door properties needed to create a new Front Door.")
      @body
      frontDoorParameters: FrontDoor;
    },
    FrontDoor
  >;

  @doc("Deletes an existing Front Door with the specified parameters.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/frontDoors/{frontDoorName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("Name of the Front Door which is globally unique.")
      @path
      frontDoorName: string;
    },
    void
  >;

  @doc("""
Validates the custom domain mapping to ensure it maps to the correct Front Door
endpoint in DNS.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/frontDoors/{frontDoorName}/validateCustomDomain")
  @post
  ValidateCustomDomain is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("Name of the Front Door which is globally unique.")
      @path
      frontDoorName: string;

      @doc("Custom domain to be validated.")
      @body
      customDomainProperties: ValidateCustomDomainInput;
    },
    ValidateCustomDomainOutput
  >;
}

interface FrontendEndpointsOperations {
  @doc("Lists all of the frontend endpoints within a Front Door.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/frontDoors/{frontDoorName}/frontendEndpoints")
  @get
  ListByFrontDoor is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("Name of the Front Door which is globally unique.")
      @path
      frontDoorName: string;
    },
    FrontendEndpointsListResult
  >;

  @doc("""
Gets a Frontend endpoint with the specified name within the specified Front
Door.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/frontDoors/{frontDoorName}/frontendEndpoints/{frontendEndpointName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("Name of the Front Door which is globally unique.")
      @path
      frontDoorName: string;

      @doc("Name of the Frontend endpoint which is unique within the Front Door.")
      @path
      frontendEndpointName: string;
    },
    FrontendEndpoint
  >;

  @doc("Enables a frontendEndpoint for HTTPS traffic")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/frontDoors/{frontDoorName}/frontendEndpoints/{frontendEndpointName}/enableHttps")
  @post
  EnableHttps is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("Name of the Front Door which is globally unique.")
      @path
      frontDoorName: string;

      @doc("Name of the Frontend endpoint which is unique within the Front Door.")
      @path
      frontendEndpointName: string;

      @doc("The configuration specifying how to enable HTTPS")
      @body
      customHttpsConfiguration: CustomHttpsConfiguration;
    },
    void
  >;

  @doc("Disables a frontendEndpoint for HTTPS traffic")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/frontDoors/{frontDoorName}/frontendEndpoints/{frontendEndpointName}/disableHttps")
  @post
  DisableHttps is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("Name of the Front Door which is globally unique.")
      @path
      frontDoorName: string;

      @doc("Name of the Frontend endpoint which is unique within the Front Door.")
      @path
      frontendEndpointName: string;
    },
    void
  >;
}

interface EndpointsOperations {
  @doc("Removes a content from Front Door.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/frontDoors/{frontDoorName}/purge")
  @post
  PurgeContent is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("Name of the Front Door which is globally unique.")
      @path
      frontDoorName: string;

      @doc("""
The path to the content to be purged. Path can be a full URL, e.g.
'/pictures/city.png' which removes a single file, or a directory with a
wildcard, e.g. '/pictures/*' which removes all folders and files in the
directory.
""")
      @body
      contentFilePaths: PurgeParameters;
    },
    void
  >;
}

interface RulesEnginesOperations {
  @doc("Lists all of the Rules Engine Configurations within a Front Door.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/frontDoors/{frontDoorName}/rulesEngines")
  @get
  ListByFrontDoor is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("Name of the Front Door which is globally unique.")
      @path
      frontDoorName: string;
    },
    RulesEngineListResult
  >;

  @doc("""
Gets a Rules Engine Configuration with the specified name within the specified
Front Door.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/frontDoors/{frontDoorName}/rulesEngines/{rulesEngineName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("Name of the Front Door which is globally unique.")
      @path
      frontDoorName: string;

      @doc("Name of the Rules Engine which is unique within the Front Door.")
      @path
      rulesEngineName: string;
    },
    RulesEngine
  >;

  @doc("""
Creates a new Rules Engine Configuration with the specified name within the
specified Front Door.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/frontDoors/{frontDoorName}/rulesEngines/{rulesEngineName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("Name of the Front Door which is globally unique.")
      @path
      frontDoorName: string;

      @doc("Name of the Rules Engine which is unique within the Front Door.")
      @path
      rulesEngineName: string;

      @doc("""
Rules Engine Configuration properties needed to create a new Rules Engine
Configuration.
""")
      @body
      rulesEngineParameters: RulesEngine;
    },
    RulesEngine
  >;

  @doc("Deletes an existing Rules Engine Configuration with the specified parameters.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/frontDoors/{frontDoorName}/rulesEngines/{rulesEngineName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("Name of the Front Door which is globally unique.")
      @path
      frontDoorName: string;

      @doc("Name of the Rules Engine which is unique within the Front Door.")
      @path
      rulesEngineName: string;
    },
    void
  >;
}

interface NetworkExperimentProfilesOperations {
  @summary("Gets a list of Network Experiment Profiles under a subscription")
  @doc("Gets a list of Network Experiment Profiles under a subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Network/NetworkExperimentProfiles")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    ProfileList
  >;

  @summary("""
Gets a list of Network Experiment Profiles within a resource group under a
subscription
""")
  @doc("""
Gets a list of Network Experiment Profiles within a resource group under a
subscription
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;
    },
    ProfileList
  >;

  @summary("Gets an NetworkExperiment Profile by ProfileName")
  @doc("Gets an NetworkExperiment Profile by ProfileName")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Profile identifier associated with the Tenant and Partner")
      @path
      profileName: string;
    },
    Profile
  >;

  @summary("Creates an NetworkExperiment Profile")
  @doc("Creates an NetworkExperiment Profile")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The Profile identifier associated with the Tenant and Partner")
      @path
      profileName: string;

      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("An Network Experiment Profile")
      @body
      parameters: Profile;
    },
    Profile
  >;

  @summary("Updates an NetworkExperimentProfiles by NetworkExperimentProfile name")
  @doc("Updates an NetworkExperimentProfiles")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Profile identifier associated with the Tenant and Partner")
      @path
      profileName: string;

      @doc("The Profile Update Model")
      @body
      parameters: ProfileUpdateModel;
    },
    Profile
  >;

  @summary("Deletes an NetworkExperiment Profile by ProfileName")
  @doc("Deletes an NetworkExperiment Profile by ProfileName")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Profile identifier associated with the Tenant and Partner")
      @path
      profileName: string;
    },
    void
  >;
}

interface PreconfiguredEndpointsOperations {
  @summary("Gets a list of Preconfigured Endpoints")
  @doc("Gets a list of Preconfigured Endpoints")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}/PreconfiguredEndpoints")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Profile identifier associated with the Tenant and Partner")
      @path
      profileName: string;
    },
    PreconfiguredEndpointList
  >;
}

interface ExperimentsOperations {
  @summary("Gets a list of Experiments")
  @doc("Gets a list of Experiments")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}/Experiments")
  @get
  ListByProfile is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Profile identifier associated with the Tenant and Partner")
      @path
      profileName: string;
    },
    ExperimentList
  >;

  @summary("Gets an Experiment by ExperimentName")
  @doc("Gets an Experiment by ExperimentName")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}/Experiments/{experimentName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Profile identifier associated with the Tenant and Partner")
      @path
      profileName: string;

      @doc("The Experiment identifier associated with the Experiment")
      @path
      experimentName: string;
    },
    Experiment
  >;

  @summary("Creates or updates an Experiment")
  @doc("Creates or updates an Experiment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}/Experiments/{experimentName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Profile identifier associated with the Tenant and Partner")
      @path
      profileName: string;

      @doc("The Experiment identifier associated with the Experiment")
      @path
      experimentName: string;

      @doc("The Experiment resource")
      @body
      parameters: Experiment;
    },
    Experiment
  >;

  @summary("Updates an Experiment by Experiment id")
  @doc("Updates an Experiment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}/Experiments/{experimentName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Profile identifier associated with the Tenant and Partner")
      @path
      profileName: string;

      @doc("The Experiment identifier associated with the Experiment")
      @path
      experimentName: string;

      @doc("The Experiment Update Model")
      @body
      parameters: ExperimentUpdateModel;
    },
    Experiment
  >;

  @summary("Deletes an Experiment")
  @doc("Deletes an Experiment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}/Experiments/{experimentName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Profile identifier associated with the Tenant and Partner")
      @path
      profileName: string;

      @doc("The Experiment identifier associated with the Experiment")
      @path
      experimentName: string;
    },
    void
  >;
}

interface ReportsOperations {
  @summary("Gets a Latency Scorecard for a given Experiment")
  @doc("Gets a Latency Scorecard for a given Experiment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}/Experiments/{experimentName}/LatencyScorecard")
  @get
  GetLatencyScorecards is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Profile identifier associated with the Tenant and Partner")
      @path
      profileName: string;

      @doc("The Experiment identifier associated with the Experiment")
      @path
      experimentName: string;

      @doc("The end DateTime of the Latency Scorecard in UTC")
      @query
      endDateTimeUTC: string;

      @doc("""
The country associated with the Latency Scorecard. Values are country ISO codes
as specified here- https://www.iso.org/iso-3166-country-codes.html
""")
      @query
      country: string;

      @doc("The aggregation interval of the Latency Scorecard")
      @query
      aggregationInterval: LatencyScorecardAggregationInterval;
    },
    LatencyScorecard
  >;

  @summary("Gets a Timeseries for a given Experiment")
  @doc("Gets a Timeseries for a given Experiment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}/Experiments/{experimentName}/Timeseries")
  @get
  GetTimeseries is Azure.Core.Foundations.Operation<
    {
      @doc("""
The subscription credentials which uniquely identify the Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Profile identifier associated with the Tenant and Partner")
      @path
      profileName: string;

      @doc("The Experiment identifier associated with the Experiment")
      @path
      experimentName: string;

      @doc("The start DateTime of the Timeseries in UTC")
      @query
      startDateTimeUTC: utcDateTime;

      @doc("The end DateTime of the Timeseries in UTC")
      @query
      endDateTimeUTC: utcDateTime;

      @doc("The aggregation interval of the Timeseries")
      @query
      aggregationInterval: TimeseriesAggregationInterval;

      @doc("The type of Timeseries")
      @query
      timeseriesType: TimeseriesType;

      @doc("The specific endpoint")
      @query
      endpoint: string;

      @doc("""
The country associated with the Timeseries. Values are country ISO codes as
specified here- https://www.iso.org/iso-3166-country-codes.html
""")
      @query
      country: string;
    },
    Timeseries
  >;
}
