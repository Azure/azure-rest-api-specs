import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Machine Learning Compute Management Client",
  version: "2017-08-01-preview",
})
@server(
  "{$host}",
  "These APIs allow end users to operate on Azure Machine Learning Compute resources. They support the following operations:<ul><li>Create or update a cluster</li><li>Get a cluster</li><li>Patch a cluster</li><li>Delete a cluster</li><li>Get keys for a cluster</li><li>Check if updates are available for system services in a cluster</li><li>Update system services in a cluster</li><li>Get all clusters in a resource group</li><li>Get all clusters in a subscription</li></ul>",
  {
    $host: string,
  }
)
@doc("""
These APIs allow end users to operate on Azure Machine Learning Compute
resources. They support the following operations:<ul><li>Create or update a
cluster</li><li>Get a cluster</li><li>Patch a cluster</li><li>Delete a
cluster</li><li>Get keys for a cluster</li><li>Check if updates are available
for system services in a cluster</li><li>Update system services in a
cluster</li><li>Get all clusters in a resource group</li><li>Get all clusters
in a subscription</li></ul>
""")
namespace MachineLearningComputeManagementClient;
