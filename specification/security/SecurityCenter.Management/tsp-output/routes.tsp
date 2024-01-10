import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Security;

interface MdeOnboardingsOperations {
  @doc("The configuration or data needed to onboard the machine to MDE")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/mdeOnboardings")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;
    },
    MdeOnboardingDataList
  >;

  @doc("The default configuration or data needed to onboard the machine to MDE")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/mdeOnboardings/default")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;
    },
    MdeOnboardingData
  >;
}

interface TasksOperations {
  @doc("Recommended tasks that will help improve the security of the subscription proactively")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/tasks")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("OData filter. Optional.")
      @query("$filter")
      $filter?: string;
    },
    ResourceListResult<SecurityTask>
  >;

  @doc("Recommended tasks that will help improve the security of the subscription proactively")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/locations/{ascLocation}/tasks")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the user's subscription. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;

      @doc("OData filter. Optional.")
      @query("$filter")
      $filter?: string;
    },
    ResourceListResult<SecurityTask>
  >;

  @doc("Recommended tasks that will help improve the security of the subscription proactively")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/locations/{ascLocation}/tasks/{taskName}")
  @get
  GetResourceGroupLevelTask is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the user's subscription. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;

      @doc("Name of the task object, will be a GUID")
      @path
      taskName: string;
    },
    SecurityTask
  >;
}

interface InformationProtectionPoliciesOperations {
  @doc("Details of the information protection policy.")
  @route("/{scope}/providers/Microsoft.Security/informationProtectionPolicies/{informationProtectionPolicyName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Scope of the query, can be subscription (/subscriptions/0b06d9ea-afe6-4779-bd59-30e5c2d9d13f) or management group (/providers/Microsoft.Management/managementGroups/mgName).")
      @path
      scope: string;

      @doc("Name of the information protection policy.")
      @path
      informationProtectionPolicyName: InformationProtectionPolicyName;

      @doc("Information protection policy.")
      @body
      informationProtectionPolicy: InformationProtectionPolicy;
    },
    InformationProtectionPolicy
  >;

  @doc("Information protection policies of a specific management group.")
  @route("/{scope}/providers/Microsoft.Security/informationProtectionPolicies")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Scope of the query, can be subscription (/subscriptions/0b06d9ea-afe6-4779-bd59-30e5c2d9d13f) or management group (/providers/Microsoft.Management/managementGroups/mgName).")
      @path
      scope: string;
    },
    InformationProtectionPolicyList
  >;
}

interface SubAssessmentsOperations {
  @doc("Get security sub-assessments on all your scanned resources inside a subscription scope")
  @route("/{scope}/providers/Microsoft.Security/subAssessments")
  @get
  ListAll is Azure.Core.Foundations.Operation<
    {
      @doc("Scope of the query, can be subscription (/subscriptions/0b06d9ea-afe6-4779-bd59-30e5c2d9d13f) or management group (/providers/Microsoft.Management/managementGroups/mgName).")
      @path
      scope: string;
    },
    ResourceListResult<SecuritySubAssessment>
  >;
}

interface AssessmentsMetadataOperations {
  @doc("Get metadata information on all assessment types in a specific subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/assessmentMetadata")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;
    },
    ResourceListResult<SecurityAssessmentMetadataResponse>
  >;

  @doc("Get metadata information on an assessment type in a specific subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/assessmentMetadata/{assessmentMetadataName}")
  @get
  GetInSubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The Assessment Key - Unique key for the assessment type")
      @path
      assessmentMetadataName: string;

      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;
    },
    SecurityAssessmentMetadataResponse
  >;

  @doc("Create metadata information on an assessment type in a specific subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/assessmentMetadata/{assessmentMetadataName}")
  @put
  CreateInSubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The Assessment Key - Unique key for the assessment type")
      @path
      assessmentMetadataName: string;

      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("AssessmentMetadata object")
      @body
      assessmentMetadata: SecurityAssessmentMetadataResponse;
    },
    SecurityAssessmentMetadataResponse
  >;

  @doc("Delete metadata information on an assessment type in a specific subscription, will cause the deletion of all the assessments of that type in that subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/assessmentMetadata/{assessmentMetadataName}")
  @delete
  DeleteInSubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The Assessment Key - Unique key for the assessment type")
      @path
      assessmentMetadataName: string;

      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface AssessmentsOperations {
  @doc("Get security assessments on all your scanned resources inside a scope")
  @route("/{scope}/providers/Microsoft.Security/assessments")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Scope of the query, can be subscription (/subscriptions/0b06d9ea-afe6-4779-bd59-30e5c2d9d13f) or management group (/providers/Microsoft.Management/managementGroups/mgName).")
      @path
      scope: string;
    },
    SecurityAssessmentList
  >;
}

interface AllowedConnectionsOperations {
  @doc("Gets the list of all possible traffic between resources for the subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/allowedConnections")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;
    },
    AllowedConnectionsList
  >;

  @doc("Gets the list of all possible traffic between resources for the subscription and location, based on connection type.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/locations/{ascLocation}/allowedConnections/{connectionType}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the user's subscription. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;

      @doc("The type of allowed connections (Internal, External)")
      @path
      connectionType: ConnectionType;
    },
    AllowedConnectionsResource
  >;
}

interface TopologyOperations {
  @doc("Gets a list that allows to build a topology view of a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/topologies")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;
    },
    TopologyList
  >;

  @doc("Gets a specific topology component.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/locations/{ascLocation}/topologies/{topologyResourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the user's subscription. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;

      @doc("Name of a topology resources collection.")
      @path
      topologyResourceName: string;
    },
    TopologyResource
  >;
}

interface DiscoveredSecuritySolutionsOperations {
  @doc("Gets a list of discovered Security Solutions for the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/discoveredSecuritySolutions")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;
    },
    DiscoveredSecuritySolutionList
  >;

  @doc("Gets a specific discovered Security Solution.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/locations/{ascLocation}/discoveredSecuritySolutions/{discoveredSecuritySolutionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the user's subscription. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;

      @doc("Name of a discovered security solution.")
      @path
      discoveredSecuritySolutionName: string;
    },
    DiscoveredSecuritySolution
  >;
}

interface securitySolutionsReferenceDataOperations {
  @doc("Gets a list of all supported Security Solutions for the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/securitySolutionsReferenceData")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;
    },
    SecuritySolutionsReferenceDataList
  >;
}

interface ExternalSecuritySolutionsOperations {
  @doc("Gets a list of external security solutions for the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/externalSecuritySolutions")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;
    },
    ExternalSecuritySolutionList
  >;

  @doc("Gets a specific external Security Solution.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/locations/{ascLocation}/ExternalSecuritySolutions/{externalSecuritySolutionsName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the user's subscription. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;

      @doc("Name of an external security solution.")
      @path
      externalSecuritySolutionsName: string;
    },
    ExternalSecuritySolution
  >;
}

interface SecureScoreControlsOperations {
  @doc("Get all security controls within a scope")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/secureScoreControls")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("OData expand. Optional.")
      @query("$expand")
      $expand?: ExpandControlsEnum;
    },
    SecureScoreControlList
  >;
}

interface SecureScoreControlDefinitionsOperations {
  @doc("List the available security controls, their assessments, and the max score")
  @route("/providers/Microsoft.Security/secureScoreControlDefinitions")
  @get
  List is Azure.Core.Foundations.Operation<
    {},
    SecureScoreControlDefinitionList
  >;

  @doc("For a specified subscription, list the available security controls, their assessments, and the max score")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/secureScoreControlDefinitions")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;
    },
    SecureScoreControlDefinitionList
  >;
}

interface SecuritySolutionsOperations {
  @doc("Gets a list of Security Solutions for the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/securitySolutions")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;
    },
    SecuritySolutionList
  >;

  @doc("Gets a specific Security Solution.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/locations/{ascLocation}/securitySolutions/{securitySolutionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the user's subscription. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;

      @doc("Name of security solution.")
      @path
      securitySolutionName: string;
    },
    SecuritySolution
  >;
}

interface AlertsOperations {
  @doc("List all the alerts that are associated with the subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/alerts")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;
    },
    ResourceListResult<Alert>
  >;

  @doc("List all the alerts that are associated with the resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/alerts")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the user's subscription. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;
    },
    ResourceListResult<Alert>
  >;

  @doc("List all the alerts that are associated with the resource group that are stored in a specific location")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/locations/{ascLocation}/alerts")
  @get
  ListResourceGroupLevelByRegion is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;

      @doc("The name of the resource group within the user's subscription. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;
    },
    ResourceListResult<Alert>
  >;

  @doc("Get an alert that is associated a resource group or a resource in a resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/locations/{ascLocation}/alerts/{alertName}")
  @get
  GetResourceGroupLevel is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the user's subscription. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;

      @doc("Name of the alert object")
      @path
      alertName: string;
    },
    Alert
  >;

  @doc("Update the alert's state")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/locations/{ascLocation}/alerts/{alertName}/resolve")
  @post
  UpdateResourceGroupLevelStateToResolve is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the user's subscription. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;

      @doc("Name of the alert object")
      @path
      alertName: string;
    },
    void
  >;

  @doc("Update the alert's state")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/locations/{ascLocation}/alerts/{alertName}/dismiss")
  @post
  UpdateResourceGroupLevelStateToDismiss is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the user's subscription. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;

      @doc("Name of the alert object")
      @path
      alertName: string;
    },
    void
  >;

  @doc("Update the alert's state")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/locations/{ascLocation}/alerts/{alertName}/activate")
  @post
  UpdateResourceGroupLevelStateToActivate is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the user's subscription. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;

      @doc("Name of the alert object")
      @path
      alertName: string;
    },
    void
  >;

  @doc("Update the alert's state")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/locations/{ascLocation}/alerts/{alertName}/inProgress")
  @post
  UpdateResourceGroupLevelStateToInProgress is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the user's subscription. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;

      @doc("Name of the alert object")
      @path
      alertName: string;
    },
    void
  >;

  @doc("Simulate security alerts")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{ascLocation}/alerts/default/simulate")
  @post
  Simulate is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The location where ASC stores the data of the subscription. can be retrieved from Get locations")
      @path
      ascLocation: string;

      @doc("Alert Simulator Request Properties")
      @body
      alertSimulatorRequestBody: AlertSimulatorRequestBody;
    },
    void
  >;
}

interface SecurityConnectorApplicationsOperations {
  @doc("Get a list of all relevant applications over a security connector level scope")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/securityConnectors/{securityConnectorName}/providers/Microsoft.Security/applications")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the user's subscription. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The security connector name.")
      @path
      securityConnectorName: string;
    },
    ResourceListResult<Application>
  >;

  @doc("Get a specific application for the requested scope by applicationId")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/securityConnectors/{securityConnectorName}/providers/Microsoft.Security/applications/{applicationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the user's subscription. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The security connector name.")
      @path
      securityConnectorName: string;

      @doc("The security Application key - unique key for the standard application")
      @path
      applicationId: string;
    },
    Application
  >;

  @doc("Creates or update a security Application on the given security connector.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/securityConnectors/{securityConnectorName}/providers/Microsoft.Security/applications/{applicationId}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the user's subscription. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The security connector name.")
      @path
      securityConnectorName: string;

      @doc("The security Application key - unique key for the standard application")
      @path
      applicationId: string;

      @doc("Application over a subscription scope")
      @body
      application: Application;
    },
    Application
  >;

  @doc("Delete an Application over a given scope")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/securityConnectors/{securityConnectorName}/providers/Microsoft.Security/applications/{applicationId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID")
      @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the user's subscription. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The security connector name.")
      @path
      securityConnectorName: string;

      @doc("The security Application key - unique key for the standard application")
      @path
      applicationId: string;
    },
    void
  >;
}

interface SqlVulnerabilityAssessmentBaselineRulesOperations {
  @summary("Add a list of baseline rules. Will overwrite any previously existing results (for all rules).")
  @doc("Add a list of baseline rules. Will overwrite any previously existing results (for all rules).")
  @route("/{resourceId}/providers/Microsoft.Security/sqlVulnerabilityAssessments/default/baselineRules")
  @post
  Add is Azure.Core.Foundations.Operation<
    {
      @doc("The workspace Id.")
      @query("workspaceId")
      workspaceId: string;

      @doc("The identifier of the resource.")
      @path
      resourceId: string;

      @doc("The baseline rules.")
      @body
      body?: RulesResultsInput;
    },
    ResourceListResult<RuleResults>
  >;
}
