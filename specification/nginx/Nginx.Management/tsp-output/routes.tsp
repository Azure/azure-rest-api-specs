import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace NginxManagementClient;

interface CertificatesOperations {
  @summary("Get a certificate of given Nginx deployment")
  @doc("Get a certificate of given Nginx deployment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Nginx.NginxPlus/nginxDeployments/{deploymentName}/certificates/{certificateName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of targeted Nginx deployment")
      @path
      deploymentName: string;

      @doc("The name of certificate")
      @path
      certificateName: string;
    },
    NginxCertificate
  >;

  @summary("Create or update the Nginx certificates for given Nginx deployment")
  @doc("Create or update the Nginx certificates for given Nginx deployment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Nginx.NginxPlus/nginxDeployments/{deploymentName}/certificates/{certificateName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of targeted Nginx deployment")
      @path
      deploymentName: string;

      @doc("The name of certificate")
      @path
      certificateName: string;

      @doc("The certificate")
      @body
      body: NginxCertificate;
    },
    NginxCertificate
  >;

  @summary("Deletes a certificate from the nginx deployment")
  @doc("Deletes a certificate from the nginx deployment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Nginx.NginxPlus/nginxDeployments/{deploymentName}/certificates/{certificateName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of targeted Nginx deployment")
      @path
      deploymentName: string;

      @doc("The name of certificate")
      @path
      certificateName: string;
    },
    void
  >;

  @summary("List all certificates of given Nginx deployment")
  @doc("List all certificates of given Nginx deployment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Nginx.NginxPlus/nginxDeployments/{deploymentName}/certificates")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of targeted Nginx deployment")
      @path
      deploymentName: string;
    },
    NginxCertificateListResponse
  >;
}

interface ConfigurationsOperations {
  @summary("List the Nginx configuration of given Nginx deployment.")
  @doc("List the Nginx configuration of given Nginx deployment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Nginx.NginxPlus/nginxDeployments/{deploymentName}/configurations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of targeted Nginx deployment")
      @path
      deploymentName: string;
    },
    NginxConfigurationListResponse
  >;

  @summary("Get the Nginx configuration of given Nginx deployment")
  @doc("Get the Nginx configuration of given Nginx deployment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Nginx.NginxPlus/nginxDeployments/{deploymentName}/configurations/{configurationName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of targeted Nginx deployment")
      @path
      deploymentName: string;

      @doc("""
The name of configuration, only 'default' is supported value due to the
singleton of Nginx conf
""")
      @path
      configurationName: string;
    },
    NginxConfiguration
  >;

  @summary("Create or update the Nginx configuration for given Nginx deployment")
  @doc("Create or update the Nginx configuration for given Nginx deployment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Nginx.NginxPlus/nginxDeployments/{deploymentName}/configurations/{configurationName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of targeted Nginx deployment")
      @path
      deploymentName: string;

      @doc("""
The name of configuration, only 'default' is supported value due to the
singleton of Nginx conf
""")
      @path
      configurationName: string;

      @doc("The Nginx configuration")
      @body
      body: NginxConfiguration;
    },
    NginxConfiguration
  >;

  @summary("Reset the Nginx configuration of given Nginx deployment to default")
  @doc("Reset the Nginx configuration of given Nginx deployment to default")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Nginx.NginxPlus/nginxDeployments/{deploymentName}/configurations/{configurationName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of targeted Nginx deployment")
      @path
      deploymentName: string;

      @doc("""
The name of configuration, only 'default' is supported value due to the
singleton of Nginx conf
""")
      @path
      configurationName: string;
    },
    void
  >;
}

interface DeploymentsOperations {
  @summary("Get the Nginx deployment")
  @doc("Get the Nginx deployment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Nginx.NginxPlus/nginxDeployments/{deploymentName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of targeted Nginx deployment")
      @path
      deploymentName: string;
    },
    NginxDeployment
  >;

  @summary("Create or update the Nginx deployment")
  @doc("Create or update the Nginx deployment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Nginx.NginxPlus/nginxDeployments/{deploymentName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of targeted Nginx deployment")
      @path
      deploymentName: string;

      @body body: NginxDeployment;
    },
    NginxDeployment
  >;

  @summary("Update the Nginx deployment")
  @doc("Update the Nginx deployment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Nginx.NginxPlus/nginxDeployments/{deploymentName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of targeted Nginx deployment")
      @path
      deploymentName: string;

      @body body: NginxDeploymentUpdateParameters;
    },
    NginxDeployment
  >;

  @summary("Delete the Nginx deployment resource")
  @doc("Delete the Nginx deployment resource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Nginx.NginxPlus/nginxDeployments/{deploymentName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of targeted Nginx deployment")
      @path
      deploymentName: string;
    },
    void
  >;

  @summary("List the Nginx deployments resources")
  @doc("List the Nginx deployments resources")
  @route("/subscriptions/{subscriptionId}/providers/Nginx.NginxPlus/nginxDeployments")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    NginxDeploymentListResponse
  >;

  @summary("List all Nginx deployments under the specified resource group.")
  @doc("List all Nginx deployments under the specified resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Nginx.NginxPlus/nginxDeployments")
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
    NginxDeploymentListResponse
  >;
}

interface OperationsOperations {
  @summary("List all operations provided by Nginx.NginxPlus for the 2022-08-01 api version.")
  @doc("List all operations provided by Nginx.NginxPlus for the 2022-08-01 api version.")
  @route("/providers/Nginx.NginxPlus/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}
