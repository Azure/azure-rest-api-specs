import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace QuantumClient;

interface JobsOperations {
  @doc("List jobs.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/jobs")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the workspace.")
      @path
      workspaceName: string;
    },
    JobDetailsList
  >;

  @doc("Get job by id")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/jobs/{jobId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the workspace.")
      @path
      workspaceName: string;

      @doc("Id of the job.")
      @path
      jobId: string;
    },
    JobDetails
  >;

  @doc("Create a job.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/jobs/{jobId}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the workspace.")
      @path
      workspaceName: string;

      @doc("Id of the job.")
      @path
      jobId: string;

      @doc("The complete metadata of the job to submit.")
      @body
      job: JobDetails;
    },
    JobDetails
  >;

  @doc("Cancel a job.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/jobs/{jobId}")
  @delete
  Cancel is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the workspace.")
      @path
      workspaceName: string;

      @doc("Id of the job.")
      @path
      jobId: string;
    },
    void
  >;

  @doc("Patch a job.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/jobs/{jobId}")
  @patch
  Patch is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the workspace.")
      @path
      workspaceName: string;

      @doc("Id of the job.")
      @path
      jobId: string;

      @doc("The json patch document containing the patch operations.")
      @body
      patchJob: JsonPatchDocument[];
    },
    JobDetails | void
  >;
}

interface ProvidersOperations {
  @doc("Get provider status.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/providerStatus")
  @get
  GetStatus is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the workspace.")
      @path
      workspaceName: string;
    },
    ProviderStatusList
  >;
}

interface StorageOperations {
  @doc("""
Gets a URL with SAS token for a container/blob in the storage account
associated with the workspace. The SAS URL can be used to upload job input
and/or download job output.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/storage/sasUri")
  @post
  SasUri is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the workspace.")
      @path
      workspaceName: string;

      @doc("The details (name and container) of the blob to store or download data.")
      @body
      blobDetails: BlobDetails;
    },
    SasUriResponse
  >;
}

interface QuotasOperations {
  @doc("List quotas for the given workspace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/quotas")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the workspace.")
      @path
      workspaceName: string;
    },
    QuotaList
  >;
}

interface SessionsOperations {
  @doc("List sessions.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/sessions")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the workspace.")
      @path
      workspaceName: string;
    },
    SessionDetailsList
  >;

  @doc("Get session by id")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/sessions/{sessionId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the workspace.")
      @path
      workspaceName: string;

      @doc("Id of the session.")
      @path
      sessionId: string;
    },
    SessionDetails
  >;

  @doc("Open a session.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/sessions/{sessionId}")
  @put
  Open is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the workspace.")
      @path
      workspaceName: string;

      @doc("Id of the session.")
      @path
      sessionId: string;

      @doc("The complete metadata of the session to be opened.")
      @body
      session: SessionDetails;
    },
    SessionDetails
  >;

  @doc("Close a session")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/sessions/{sessionId}:close")
  @post
  Close is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the workspace.")
      @path
      workspaceName: string;

      @doc("Id of the session.")
      @path
      sessionId: string;
    },
    SessionDetails
  >;

  @doc("List jobs in a session.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/sessions/{sessionId}/jobs")
  @get
  JobsList is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the workspace.")
      @path
      workspaceName: string;

      @doc("Id of the session.")
      @path
      sessionId: string;
    },
    JobDetailsList
  >;
}

interface TopLevelItemsOperations {
  @doc("List top-level items.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/topLevelItems")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("Name of an Azure resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the workspace.")
      @path
      workspaceName: string;
    },
    ItemDetailsList
  >;
}
