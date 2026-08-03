## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  test-scenario:
    - name: /SupportTickets/put/Create a ticket to request Quota increase for Low-priority cores for a Batch account
      disabled: true
    - name: /SupportTickets/put/Create a ticket to request Quota increase for Servers for Azure Synapse Analytics
      disabled: true
    - name: /SupportTickets/put/Create a ticket to request Quota increase for DTUs for Azure Synapse Analytics
      disabled: true
    - name: /SupportTickets/put/Create a ticket to request Quota increase for Servers for SQL Database
      disabled: true
    - name: /SupportTickets/put/Create a ticket to request Quota increase for DTUs for SQL Database
      disabled: true
    - name: /SupportTickets/put/Create a ticket to request Quota increase for specific VM family cores for Machine Learning service
      disabled: true
    - name: /SupportTickets/put/Create a ticket to request Quota increase for Active Jobs and Job Schedules for a Batch account
      disabled: true
    - name: /SupportTickets/put/Create a ticket to request Quota increase for Pools for a Batch account
      disabled: true
    - name: /SupportTickets/put/Create a ticket to request Quota increase for specific VM family cores for a Batch account
      disabled: true
    - name: /SupportTickets/put/Create a ticket for Billing related issues
      disabled: true
    - name: /SupportTickets/put/Create a ticket for Subscription Management related issues
      disabled: true
    - name: /SupportTickets/put/Create a ticket to request Quota increase for Low-priority cores for Machine Learning service
      disabled: true
    - name: /SupportTickets/put/Create a ticket for Technical issue related to a specific resource
      disabled: true
    - name: /SupportTickets/put/Create a ticket to request Quota increase for services that do not require additional details in the quotaTi
      disabled: true
    - name: /SupportTickets/put/Create a ticket to request Quota increase for Compute VM Cores
      disabled: true
    - name: /SupportTickets/put/Create a ticket to request Quota increase for Batch accounts for a subscription
      disabled: true
    - name: /Communications/put/AddCommunicationToSubscriptionTicket
      disabled: true
    - name: /Communications/get/Get communication details for a subscription support ticket
      disabled: true
    - name: /Communications/get/List web communications for a subscription support ticket
      disabled: true
    - name: /Communications/get/List communications for a subscription support ticket
      disabled: true
    - name: /Communications/get/List web communication created on or after a specific date for a subscription support ticket
      disabled: true
    - name: /ProblemClassifications/get/Gets details of problemClassification for Azure service
    - name: /SupportTickets/get/Get details of a subscription ticket
      disabled: true
    - name: /SupportTickets/get/List support tickets in open state for a subscription
    - name: /ProblemClassifications/get/Gets list of problemClassifications for a service for which a support ticket can be created
    - name: /SupportTickets/get/List support tickets created on or after a certain date and in open state for a subscription
    - name: /Services/get/Gets list of services for which a support ticket can be created
    - name: /Communications/post/Checks whether name is available for Communication resource
    - name: /SupportTickets/patch/Update contact details of a support ticket
      disabled: true
    - name: /SupportTickets/patch/Update severity of a support ticket
      disabled: true
    - name: /SupportTickets/patch/Update status of a support ticket
      disabled: true
    - name: /SupportTickets/post/Checks whether name is available for SupportTicket resource
