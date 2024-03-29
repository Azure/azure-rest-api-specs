//go:build go1.18
// +build go1.18

// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.

package armapicenter_test

import (
	"context"
	"fmt"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azcore"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/arm"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/to"
	"github.com/Azure/azure-sdk-for-go/sdk/internal/recording"
	"github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/apicenter/armapicenter"
	"github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/internal/v2/testutil"
	"github.com/stretchr/testify/suite"
)

type ApicenterTestSuite struct {
	suite.Suite

	ctx                context.Context
	cred               azcore.TokenCredential
	options            *arm.ClientOptions
	apiName            string
	armEndpoint        string
	definitionName     string
	deploymentName     string
	environmentName    string
	metadataSchemaName string
	serviceName        string
	versionName        string
	workspaceName      string
	location           string
	payload            string
	resourceGroupName  string
	subscriptionId     string
}

func (testsuite *ApicenterTestSuite) SetupSuite() {
	testutil.StartRecording(testsuite.T(), "sdk/resourcemanager/apicenter/armapicenter/testdata")

	testsuite.ctx = context.Background()
	testsuite.cred, testsuite.options = testutil.GetCredAndClientOptions(testsuite.T())
	testsuite.apiName, _ = recording.GenerateAlphaNumericID(testsuite.T(), "apiname", 13, false)
	testsuite.armEndpoint = "https://management.azure.com"
	testsuite.definitionName, _ = recording.GenerateAlphaNumericID(testsuite.T(), "definiti", 14, false)
	testsuite.deploymentName, _ = recording.GenerateAlphaNumericID(testsuite.T(), "deployme", 14, false)
	testsuite.environmentName, _ = recording.GenerateAlphaNumericID(testsuite.T(), "environm", 14, false)
	testsuite.metadataSchemaName, _ = recording.GenerateAlphaNumericID(testsuite.T(), "metadata", 14, false)
	testsuite.serviceName, _ = recording.GenerateAlphaNumericID(testsuite.T(), "servicen", 14, false)
	testsuite.versionName, _ = recording.GenerateAlphaNumericID(testsuite.T(), "versionn", 14, false)
	testsuite.workspaceName, _ = recording.GenerateAlphaNumericID(testsuite.T(), "workspac", 14, false)
	testsuite.location = recording.GetEnvVariable("LOCATION", "eastus")
	testsuite.payload = recording.GetEnvVariable("PAYLOAD", "")
	testsuite.resourceGroupName = recording.GetEnvVariable("RESOURCE_GROUP_NAME", "scenarioTestTempGroup")
	testsuite.subscriptionId = recording.GetEnvVariable("AZURE_SUBSCRIPTION_ID", "00000000-0000-0000-0000-000000000000")
	resourceGroup, _, err := testutil.CreateResourceGroup(testsuite.ctx, testsuite.subscriptionId, testsuite.cred, testsuite.options, testsuite.location)
	testsuite.Require().NoError(err)
	testsuite.resourceGroupName = *resourceGroup.Name
	testsuite.Prepare()
}

func (testsuite *ApicenterTestSuite) TearDownSuite() {
	testsuite.Cleanup()
	_, err := testutil.DeleteResourceGroup(testsuite.ctx, testsuite.subscriptionId, testsuite.cred, testsuite.options, testsuite.resourceGroupName)
	testsuite.Require().NoError(err)
	testutil.StopRecording(testsuite.T())
}

func TestApicenterTestSuite(t *testing.T) {
	suite.Run(t, new(ApicenterTestSuite))
}

func (testsuite *ApicenterTestSuite) Prepare() {
	var err error
	// From step Services_CreateOrUpdate
	fmt.Println("Call operation: Services_CreateOrUpdate")
	servicesClient, err := armapicenter.NewServicesClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	_, err = servicesClient.CreateOrUpdate(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, armapicenter.Service{
		Location: to.Ptr(testsuite.location),
		Identity: &armapicenter.ManagedIdentityProperties{
			Type: to.Ptr(armapicenter.ManagedIdentityTypeSystemAssigned),
		},
	}, nil)
	testsuite.Require().NoError(err)

	// From step Workspaces_CreateOrUpdate
	fmt.Println("Call operation: Workspaces_CreateOrUpdate")
	workspacesClient, err := armapicenter.NewWorkspacesClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	_, err = workspacesClient.CreateOrUpdate(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, armapicenter.Workspace{
		Properties: &armapicenter.WorkspaceProperties{
			Title: to.Ptr("default"),
		},
	}, nil)
	testsuite.Require().NoError(err)

	// From step Apis_CreateOrUpdate
	fmt.Println("Call operation: Apis_CreateOrUpdate")
	apisClient, err := armapicenter.NewApisClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	_, err = apisClient.CreateOrUpdate(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, testsuite.apiName, armapicenter.API{
		Properties: &armapicenter.APIProperties{
			Title:          to.Ptr("Echo API"),
			Description:    to.Ptr("A simple HTTP request/response service."),
			LifecycleStage: to.Ptr(armapicenter.LifecycleStageDesign),
			Kind:           to.Ptr(armapicenter.APIKindRest),
			TermsOfService: &armapicenter.TermsOfService{
				URL: to.Ptr("https://contoso.com/terms-of-service"),
			},
			License: &armapicenter.License{
				URL: to.Ptr("https://contoso.com/license"),
			},
			ExternalDocumentation: []*armapicenter.ExternalDocumentation{
				{
					Title: to.Ptr("Onboarding docs"),
					URL:   to.Ptr("https://docs.contoso.com"),
				},
			},
		},
	}, nil)
	testsuite.Require().NoError(err)

	// From step ApiVersions_CreateOrUpdate
	fmt.Println("Call operation: ApiVersions_CreateOrUpdate")
	aPIVersionsClient, err := armapicenter.NewApiVersionsClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	_, err = aPIVersionsClient.CreateOrUpdate(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, testsuite.apiName, testsuite.versionName, armapicenter.APIVersion{
		Properties: &armapicenter.APIVersionProperties{
			Title:          to.Ptr("2023-01-01"),
			LifecycleStage: to.Ptr(armapicenter.LifecycleStageProduction),
		},
	}, nil)
	testsuite.Require().NoError(err)

	// From step ApiDefinitions_CreateOrUpdate
	fmt.Println("Call operation: ApiDefinitions_CreateOrUpdate")
	aPIDefinitionsClient, err := armapicenter.NewApiDefinitionsClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	_, err = aPIDefinitionsClient.CreateOrUpdate(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, testsuite.apiName, testsuite.versionName, testsuite.definitionName, armapicenter.APIDefinition{
		Properties: &armapicenter.APIDefinitionProperties{
			Title:       to.Ptr("OpenAPI"),
			Description: to.Ptr("Default spec"),
		},
	}, nil)
	testsuite.Require().NoError(err)

	// From step Environments_CreateOrUpdate
	fmt.Println("Call operation: Environments_CreateOrUpdate")
	environmentsClient, err := armapicenter.NewEnvironmentsClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	_, err = environmentsClient.CreateOrUpdate(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, testsuite.environmentName, armapicenter.Environment{
		Properties: &armapicenter.EnvironmentProperties{
			Title:       to.Ptr("Contoso Europe Azure API Management"),
			Description: to.Ptr("The primary Azure API Management service for the European division of Contoso."),
			Kind:        to.Ptr(armapicenter.EnvironmentKindProduction),
			Server: &armapicenter.EnvironmentServer{
				Type: to.Ptr(armapicenter.EnvironmentServerTypeAzureAPIManagement),
				ManagementPortalURI: []*string{
					to.Ptr("https://management.azure.com/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/contoso-resources/providers/Microsoft.ApiManagement/service/contoso"),
				},
			},
			Onboarding: &armapicenter.Onboarding{
				Instructions: to.Ptr("Sign in or sign up in the specified developer portal to request API access. You must complete the internal privacy training for your account to be approved."),
				DeveloperPortalURI: []*string{
					to.Ptr("https://developer.contoso.com"),
				},
			},
		},
	}, nil)
	testsuite.Require().NoError(err)
}

// Microsoft.ApiCenter/services/{serviceName}
func (testsuite *ApicenterTestSuite) TestServices() {
	var err error
	// From step Services_ListByResourceGroup
	fmt.Println("Call operation: Services_ListByResourceGroup")
	servicesClient, err := armapicenter.NewServicesClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	servicesClientNewListByResourceGroupPager := servicesClient.NewListByResourceGroupPager(testsuite.subscriptionId, testsuite.resourceGroupName, nil)
	for servicesClientNewListByResourceGroupPager.More() {
		_, err := servicesClientNewListByResourceGroupPager.NextPage(testsuite.ctx)
		testsuite.Require().NoError(err)
		break
	}

	// From step Services_Get
	fmt.Println("Call operation: Services_Get")
	_, err = servicesClient.Get(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, nil)
	testsuite.Require().NoError(err)

	// From step Services_Update
	fmt.Println("Call operation: Services_Update")
	_, err = servicesClient.Update(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, armapicenter.ServiceUpdate{
		Tags: map[string]*string{
			"tag1": to.Ptr("value1"),
		},
	}, nil)
	testsuite.Require().NoError(err)
}

// Microsoft.ApiCenter/services/{serviceName}/metadataSchemas/{metadataSchemaName}
func (testsuite *ApicenterTestSuite) TestMetadataSchemas() {
	var err error
	// From step MetadataSchemas_CreateOrUpdate
	fmt.Println("Call operation: MetadataSchemas_CreateOrUpdate")
	metadataSchemasClient, err := armapicenter.NewMetadataSchemasClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	_, err = metadataSchemasClient.CreateOrUpdate(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.metadataSchemaName, armapicenter.MetadataSchema{
		Properties: &armapicenter.MetadataSchemaProperties{
			Schema: to.Ptr("{\"type\":\"string\", \"title\":\"Author\", pattern: \"^[a-zA-Z]+$\"}"),
			AssignedTo: []*armapicenter.MetadataAssignment{
				{
					Entity:     to.Ptr(armapicenter.MetadataAssignmentEntityAPI),
					Deprecated: to.Ptr(true),
				},
			},
		},
	}, nil)
	testsuite.Require().NoError(err)

	// From step MetadataSchemas_Head
	fmt.Println("Call operation: MetadataSchemas_Head")
	_, err = metadataSchemasClient.Head(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.metadataSchemaName, nil)
	testsuite.Require().NoError(err)

	// From step MetadataSchemas_Get
	fmt.Println("Call operation: MetadataSchemas_Get")
	_, err = metadataSchemasClient.Get(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.metadataSchemaName, nil)
	testsuite.Require().NoError(err)

	// From step MetadataSchemas_List
	fmt.Println("Call operation: MetadataSchemas_List")
	metadataSchemasClientNewListPager := metadataSchemasClient.NewListPager(testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, &armapicenter.MetadataSchemasClientListOptions{Filter: nil})
	for metadataSchemasClientNewListPager.More() {
		_, err := metadataSchemasClientNewListPager.NextPage(testsuite.ctx)
		testsuite.Require().NoError(err)
		break
	}

	// From step Services_ExportMetadataSchema
	fmt.Println("Call operation: Services_ExportMetadataSchema")
	servicesClient, err := armapicenter.NewServicesClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	servicesClientExportMetadataSchemaResponsePoller, err := servicesClient.BeginExportMetadataSchema(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, armapicenter.MetadataSchemaExportRequest{
		AssignedTo: to.Ptr(armapicenter.MetadataAssignmentEntityAPI),
	}, nil)
	testsuite.Require().NoError(err)
	_, err = testutil.PollForTest(testsuite.ctx, servicesClientExportMetadataSchemaResponsePoller)
	testsuite.Require().NoError(err)

	// From step MetadataSchemas_Delete
	fmt.Println("Call operation: MetadataSchemas_Delete")
	_, err = metadataSchemasClient.Delete(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.metadataSchemaName, nil)
	testsuite.Require().NoError(err)
}

// Microsoft.ApiCenter/services/{serviceName}/workspaces/{workspaceName}
func (testsuite *ApicenterTestSuite) TestWorkspaces() {
	var err error
	// From step Workspaces_Head
	fmt.Println("Call operation: Workspaces_Head")
	workspacesClient, err := armapicenter.NewWorkspacesClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	_, err = workspacesClient.Head(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, nil)
	testsuite.Require().NoError(err)

	// From step Workspaces_List
	fmt.Println("Call operation: Workspaces_List")
	workspacesClientNewListPager := workspacesClient.NewListPager(testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, &armapicenter.WorkspacesClientListOptions{Filter: nil})
	for workspacesClientNewListPager.More() {
		_, err := workspacesClientNewListPager.NextPage(testsuite.ctx)
		testsuite.Require().NoError(err)
		break
	}

	// From step Workspaces_Get
	fmt.Println("Call operation: Workspaces_Get")
	_, err = workspacesClient.Get(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, nil)
	testsuite.Require().NoError(err)
}

// Microsoft.ApiCenter/services/{serviceName}/workspaces/{workspaceName}/environments/{environmentName}
func (testsuite *ApicenterTestSuite) TestEnvironments() {
	var err error
	// From step Environments_Head
	fmt.Println("Call operation: Environments_Head")
	environmentsClient, err := armapicenter.NewEnvironmentsClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	_, err = environmentsClient.Head(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, testsuite.environmentName, nil)
	testsuite.Require().NoError(err)

	// From step Environments_Get
	fmt.Println("Call operation: Environments_Get")
	_, err = environmentsClient.Get(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, testsuite.environmentName, nil)
	testsuite.Require().NoError(err)

	// From step Environments_List
	fmt.Println("Call operation: Environments_List")
	environmentsClientNewListPager := environmentsClient.NewListPager(testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, &armapicenter.EnvironmentsClientListOptions{Filter: nil})
	for environmentsClientNewListPager.More() {
		_, err := environmentsClientNewListPager.NextPage(testsuite.ctx)
		testsuite.Require().NoError(err)
		break
	}
}

// Microsoft.ApiCenter/services/{serviceName}/workspaces/{workspaceName}/apis/{apiName}
func (testsuite *ApicenterTestSuite) TestApis() {
	var err error
	// From step Apis_Head
	fmt.Println("Call operation: Apis_Head")
	apisClient, err := armapicenter.NewApisClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	_, err = apisClient.Head(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, testsuite.apiName, nil)
	testsuite.Require().NoError(err)

	// From step Apis_List
	fmt.Println("Call operation: Apis_List")
	apisClientNewListPager := apisClient.NewListPager(testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, &armapicenter.ApisClientListOptions{Filter: nil})
	for apisClientNewListPager.More() {
		_, err := apisClientNewListPager.NextPage(testsuite.ctx)
		testsuite.Require().NoError(err)
		break
	}

	// From step Apis_Get
	fmt.Println("Call operation: Apis_Get")
	_, err = apisClient.Get(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, testsuite.apiName, nil)
	testsuite.Require().NoError(err)
}

// Microsoft.ApiCenter/services/{serviceName}/workspaces/{workspaceName}/apis/{apiName}/versions/{versionName}
func (testsuite *ApicenterTestSuite) TestApiVersions() {
	var err error
	// From step ApiVersions_Head
	fmt.Println("Call operation: ApiVersions_Head")
	aPIVersionsClient, err := armapicenter.NewApiVersionsClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	_, err = aPIVersionsClient.Head(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, testsuite.apiName, testsuite.versionName, nil)
	testsuite.Require().NoError(err)

	// From step ApiVersions_List
	fmt.Println("Call operation: ApiVersions_List")
	aPIVersionsClientNewListPager := aPIVersionsClient.NewListPager(testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, testsuite.apiName, &armapicenter.ApiVersionsClientListOptions{Filter: nil})
	for aPIVersionsClientNewListPager.More() {
		_, err := aPIVersionsClientNewListPager.NextPage(testsuite.ctx)
		testsuite.Require().NoError(err)
		break
	}

	// From step ApiVersions_Get
	fmt.Println("Call operation: ApiVersions_Get")
	_, err = aPIVersionsClient.Get(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, testsuite.apiName, testsuite.versionName, nil)
	testsuite.Require().NoError(err)
}

// Microsoft.ApiCenter/services/{serviceName}/workspaces/{workspaceName}/apis/{apiName}/versions/{versionName}/definitions/{definitionName}
func (testsuite *ApicenterTestSuite) TestApiDefinitions() {
	var err error
	// From step ApiDefinitions_Head
	fmt.Println("Call operation: ApiDefinitions_Head")
	aPIDefinitionsClient, err := armapicenter.NewApiDefinitionsClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	_, err = aPIDefinitionsClient.Head(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, testsuite.apiName, testsuite.versionName, testsuite.definitionName, nil)
	testsuite.Require().NoError(err)

	// From step ApiDefinitions_List
	fmt.Println("Call operation: ApiDefinitions_List")
	aPIDefinitionsClientNewListPager := aPIDefinitionsClient.NewListPager(testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, testsuite.apiName, testsuite.versionName, &armapicenter.ApiDefinitionsClientListOptions{Filter: nil})
	for aPIDefinitionsClientNewListPager.More() {
		_, err := aPIDefinitionsClientNewListPager.NextPage(testsuite.ctx)
		testsuite.Require().NoError(err)
		break
	}

	// From step ApiDefinitions_Get
	fmt.Println("Call operation: ApiDefinitions_Get")
	_, err = aPIDefinitionsClient.Get(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, testsuite.apiName, testsuite.versionName, testsuite.definitionName, nil)
	testsuite.Require().NoError(err)
}

// Microsoft.ApiCenter/operations
func (testsuite *ApicenterTestSuite) TestOperations() {
	var err error
	// From step Operations_List
	fmt.Println("Call operation: Operations_List")
	operationsClient, err := armapicenter.NewOperationsClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	operationsClientNewListPager := operationsClient.NewListPager(nil)
	for operationsClientNewListPager.More() {
		_, err := operationsClientNewListPager.NextPage(testsuite.ctx)
		testsuite.Require().NoError(err)
		break
	}
}

func (testsuite *ApicenterTestSuite) Cleanup() {
	var err error
	// From step Environments_Delete
	fmt.Println("Call operation: Environments_Delete")
	environmentsClient, err := armapicenter.NewEnvironmentsClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	_, err = environmentsClient.Delete(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, testsuite.environmentName, nil)
	testsuite.Require().NoError(err)

	// From step ApiDefinitions_Delete
	fmt.Println("Call operation: ApiDefinitions_Delete")
	aPIDefinitionsClient, err := armapicenter.NewApiDefinitionsClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	_, err = aPIDefinitionsClient.Delete(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, testsuite.apiName, testsuite.versionName, testsuite.definitionName, nil)
	testsuite.Require().NoError(err)

	// From step ApiVersions_Delete
	fmt.Println("Call operation: ApiVersions_Delete")
	aPIVersionsClient, err := armapicenter.NewApiVersionsClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	_, err = aPIVersionsClient.Delete(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, testsuite.apiName, testsuite.versionName, nil)
	testsuite.Require().NoError(err)

	// From step Apis_Delete
	fmt.Println("Call operation: Apis_Delete")
	apisClient, err := armapicenter.NewApisClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	_, err = apisClient.Delete(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, testsuite.apiName, nil)
	testsuite.Require().NoError(err)

	// From step Workspaces_Delete
	fmt.Println("Call operation: Workspaces_Delete")
	workspacesClient, err := armapicenter.NewWorkspacesClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	_, err = workspacesClient.Delete(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, testsuite.workspaceName, nil)
	testsuite.Require().NoError(err)

	// From step Services_Delete
	fmt.Println("Call operation: Services_Delete")
	servicesClient, err := armapicenter.NewServicesClient(testsuite.cred, testsuite.options)
	testsuite.Require().NoError(err)
	_, err = servicesClient.Delete(testsuite.ctx, testsuite.subscriptionId, testsuite.resourceGroupName, testsuite.serviceName, nil)
	testsuite.Require().NoError(err)
}
