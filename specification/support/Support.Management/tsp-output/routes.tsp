import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Support;

interface SupportTicketsNoSubscriptionOperations {
  /**
   * Check the availability of a resource name. This API should be used to check the uniqueness of the name for support ticket creation for the selected subscription.
   */
  @route("/providers/Microsoft.Support/checkNameAvailability")
  @post
  checkNameAvailability is Azure.Core.Foundations.Operation<
    CheckNameAvailabilityInput,
    CheckNameAvailabilityOutput
  >;

  /**
   * Lists all the support tickets. <br/><br/>You can also filter the support tickets by <i>Status</i>, <i>CreatedDate</i>, , <i>ServiceId</i>, and <i>ProblemClassificationId</i> using the $filter parameter. Output will be a paged result with <i>nextLink</i>, using which you can retrieve the next set of support tickets. <br/><br/>Support ticket data is available for 18 months after ticket creation. If a ticket was created more than 18 months ago, a request for data might cause an error.
   */
  @route("/providers/Microsoft.Support/supportTickets")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The number of values to return in the collection. Default is 25 and max is 100.
       */
      @query("$top")
      $top?: int32;

      /**
       * The filter to apply on the operation. We support 'odata v4.0' filter semantics. <a target='_blank' href='https://docs.microsoft.com/odata/concepts/queryoptions-overview'>Learn more</a> <br/><i>Status</i> , <i>ServiceId</i>, and <i>ProblemClassificationId</i> filters can only be used with 'eq' operator. For <i>CreatedDate</i> filter, the supported operators are 'gt' and 'ge'. When using both filters, combine them using the logical 'AND'.
       */
      @query("$filter")
      $filter?: string;
    },
    ResourceListResult<SupportTicketDetails>
  >;

  /**
   * Gets details for a specific support ticket. Support ticket data is available for 18 months after ticket creation. If a ticket was created more than 18 months ago, a request for data might cause an error.
   */
  @route("/providers/Microsoft.Support/supportTickets/{supportTicketName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Support ticket name.
       */
      @path
      supportTicketName: string;
    },
    SupportTicketDetails
  >;

  /**
   * This API allows you to update the severity level, ticket status, and your contact information in the support ticket.<br/><br/>Note: The severity levels cannot be changed if a support ticket is actively being worked upon by an Azure support engineer. In such a case, contact your support engineer to request severity update by adding a new communication using the Communications API.
   */
  @route("/providers/Microsoft.Support/supportTickets/{supportTicketName}")
  @patch
  update is Azure.Core.Foundations.Operation<
    {
      /**
       * Support ticket name.
       */
      @path
      supportTicketName: string;

      /**
       * UpdateSupportTicket object.
       */
      @body
      updateSupportTicket: UpdateSupportTicket;
    },
    SupportTicketDetails
  >;

  /**
   * Creates a new support ticket for Billing, and Subscription Management issues. Learn the [prerequisites](https://aka.ms/supportAPI) required to create a support ticket.<br/><br/>Always call the Services and ProblemClassifications API to get the most recent set of services and problem categories required for support ticket creation.<br/><br/>Adding attachments is not currently supported via the API. To add a file to an existing support ticket, visit the [Manage support ticket](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/managesupportrequest) page in the Azure portal, select the support ticket, and use the file upload control to add a new file.<br/><br/>Providing consent to share diagnostic information with Azure support is currently not supported via the API. The Azure support engineer working on your ticket will reach out to you for consent if your issue requires gathering diagnostic information from your Azure resources.<br/><br/>
   */
  @route("/providers/Microsoft.Support/supportTickets/{supportTicketName}")
  @put
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * Support ticket name.
       */
      @path
      supportTicketName: string;

      /**
       * Support ticket request payload.
       */
      @body
      createSupportTicketParameters: SupportTicketDetails;
    },
    SupportTicketDetails | void
  >;
}

interface CommunicationsNoSubscriptionOperations {
  /**
   * Check the availability of a resource name. This API should be used to check the uniqueness of the name for adding a new communication to the support ticket.
   */
  @route("/providers/Microsoft.Support/supportTickets/{supportTicketName}/checkNameAvailability")
  @post
  checkNameAvailability is Azure.Core.Foundations.Operation<
    {
      /**
       * Support ticket name.
       */
      @path
      supportTicketName: string;

      /**
       * Input to check.
       */
      @body
      checkNameAvailabilityInput: CheckNameAvailabilityInput;
    },
    CheckNameAvailabilityOutput
  >;

  /**
   * Returns communication details for a support ticket.
   */
  @route("/providers/Microsoft.Support/supportTickets/{supportTicketName}/communications/{communicationName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Support ticket name.
       */
      @path
      supportTicketName: string;

      /**
       * Communication name.
       */
      @path
      communicationName: string;
    },
    CommunicationDetails
  >;

  /**
   * Adds a new customer communication to an Azure support ticket.
   */
  @route("/providers/Microsoft.Support/supportTickets/{supportTicketName}/communications/{communicationName}")
  @put
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * Support ticket name.
       */
      @path
      supportTicketName: string;

      /**
       * Communication name.
       */
      @path
      communicationName: string;

      /**
       * Communication object.
       */
      @body
      createCommunicationParameters: CommunicationDetails;
    },
    CommunicationDetails | void
  >;
}

interface SupportTicketCommunicationsNoSubscriptionOperations {
  /**
   * Lists all communications (attachments not included) for a support ticket. <br/></br> You can also filter support ticket communications by _CreatedDate_ or _CommunicationType_ using the $filter parameter. The only type of communication supported today is _Web_. Output will be a paged result with _nextLink_, using which you can retrieve the next set of Communication results. <br/><br/>Support ticket data is available for 18 months after ticket creation. If a ticket was created more than 18 months ago, a request for data might cause an error.
   */
  @route("/providers/Microsoft.Support/supportTickets/{supportTicketName}/communications")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Support ticket name
       */
      @path
      supportTicketName: string;

      /**
       * The number of values to return in the collection. Default is 10 and max is 10.
       */
      @query("$top")
      $top?: int32;

      /**
       * The filter to apply on the operation. You can filter by communicationType and createdDate properties. CommunicationType supports Equals ('eq') operator and createdDate supports Greater Than ('gt') and Greater Than or Equals ('ge') operators. You may combine the CommunicationType and CreatedDate filters by Logical And ('and') operator.
       */
      @query("$filter")
      $filter?: string;
    },
    ResourceListResult<CommunicationDetails>
  >;
}

interface SupportTicketChatTranscriptsNoSubscriptionOperations {
  /**
   * Lists all chat transcripts for a support ticket
   */
  @route("/providers/Microsoft.Support/supportTickets/{supportTicketName}/chatTranscripts")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Support ticket name
       */
      @path
      supportTicketName: string;
    },
    ResourceListResult<ChatTranscriptDetails>
  >;
}

interface ChatTranscriptsNoSubscriptionOperations {
  /**
   * Returns chatTranscript details for a no subscription support ticket.
   */
  @route("/providers/Microsoft.Support/supportTickets/{supportTicketName}/chatTranscripts/{chatTranscriptName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Support ticket name.
       */
      @path
      supportTicketName: string;

      /**
       * ChatTranscript name.
       */
      @path
      chatTranscriptName: string;
    },
    ChatTranscriptDetails
  >;
}

interface FileWorkspacesNoSubscriptionOperations {
  /**
   * Gets details for a specific file workspace.
   */
  @route("/providers/Microsoft.Support/fileWorkspaces/{fileWorkspaceName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * File Workspace Name
       */
      @path
      fileWorkspaceName: string;
    },
    FileWorkspaceDetails
  >;

  /**
   * Creates a new file workspace.
   */
  @route("/providers/Microsoft.Support/fileWorkspaces/{fileWorkspaceName}")
  @put
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * File workspace name.
       */
      @pattern("^[0-9a-zA-Z_\\-. ]+$")
      @path
      fileWorkspaceName: string;
    },
    FileWorkspaceDetails
  >;
}

interface FilesNoSubscriptionOperations {
  /**
   * Lists all the Files information under a workspace for an Azure subscription.
   */
  @route("/providers/Microsoft.Support/fileWorkspaces/{fileWorkspaceName}/files")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * File Workspace Name
       */
      @path
      fileWorkspaceName: string;
    },
    ResourceListResult<FileDetails>
  >;

  /**
   * Returns details of a specific file in a work space.
   */
  @route("/providers/Microsoft.Support/fileWorkspaces/{fileWorkspaceName}/files/{fileName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * File Workspace Name
       */
      @path
      fileWorkspaceName: string;

      /**
       * File Name
       */
      @path
      fileName: string;
    },
    FileDetails
  >;

  /**
   * Creates a new file under a workspace.
   */
  @route("/providers/Microsoft.Support/fileWorkspaces/{fileWorkspaceName}/files/{fileName}")
  @put
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * File workspace name.
       */
      @pattern("^[0-9a-zA-Z_\\-. ]+$")
      @path
      fileWorkspaceName: string;

      /**
       * File name.
       */
      @path
      fileName: string;

      /**
       * Create file object
       */
      @body
      createFileParameters: FileDetails;
    },
    FileDetails
  >;

  /**
   * This API allows you to upload content to a file
   */
  @route("/providers/Microsoft.Support/fileWorkspaces/{fileWorkspaceName}/files/{fileName}/upload")
  @post
  upload is Azure.Core.Foundations.Operation<
    {
      /**
       * File WorkspaceName
       */
      @path
      fileWorkspaceName: string;

      /**
       * File Name
       */
      @path
      fileName: string;

      /**
       * UploadFile object
       */
      @body
      uploadFile: UploadFile;
    },
    void
  >;
}
