import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/http";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;

namespace PurviewDataAccess;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;
alias DataAccessOperations = Azure.Core.ResourceOperations<ServiceTraits>;

// ============================================================
// Data Subscriptions
// ============================================================

interface DataSubscriptions {
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("DataSubscriptions")
  @doc("Gets a data subscription by its identifier.")
  @get
  Get is DataAccessOperations.ResourceRead<DataSubscription>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("DataSubscriptions")
  @doc("Creates or updates a data subscription.")
  @route("/dataSubscriptions/{dataSubscriptionId}")
  @put
  CreateOrUpdate is RpcOperation<
    {
      @doc("The data subscription identifier.")
      @path
      dataSubscriptionId: uuid;

      @doc("The data subscription payload.")
      @body
      dataSubscription: DataSubscription;
    },
    DataSubscription
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("DataSubscriptions")
  @doc("Deletes a data subscription.")
  @delete
  Delete is DataAccessOperations.ResourceDelete<DataSubscription>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("DataSubscriptions")
  @doc("Lists data subscriptions with optional filtering.")
  @get
  List is DataAccessOperations.ResourceList<
    DataSubscription,
    ListQueryParametersTrait<{
      @doc("Continuation token for pagination.")
      @query
      skipToken?: string;

      @doc("Filter for subscriptions using workflows.")
      @query
      workflowSubscriptions?: boolean;

      @doc("Filter for legacy subscriptions not using workflows.")
      @query
      legacySubscriptions?: boolean;

      @doc("Filter for access provider subscriptions.")
      @query
      accessProvidersOnly?: boolean;

      @doc("Filter by Power Automate usage.")
      @query
      powerAutomate?: boolean;

      @doc("Return only count of matching subscriptions.")
      @query
      count?: boolean;

      @doc("Filter by data product identifier.")
      @query
      dataProductId?: uuid;

      @doc("Filter by data product name.")
      @query
      dataProductName?: string;

      @doc("Filter by governance domain.")
      @query
      governanceDomain?: string;

      @doc("Filter by workflow type.")
      @query
      workflowType?: string;

      @doc("Filter by business concept type.")
      @query
      businessConceptType?: string;

      @doc("Whether to ignore action statuses in filtering.")
      @query
      ignoreActionStatuses?: boolean;
    }>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("DataSubscriptions")
  @doc("Saves a data subscription as a draft.")
  @route("/dataSubscriptions/{dataSubscriptionId}:save")
  @put
  Save is RpcOperation<
    {
      @doc("The data subscription identifier.")
      @path
      dataSubscriptionId: uuid;

      @doc("The data subscription payload.")
      @body
      dataSubscription: DataSubscription;
    },
    DataSubscription
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("DataSubscriptions")
  @doc("Approves a data subscription request.")
  @route("/dataSubscriptions/{dataSubscriptionId}:approve")
  @post
  Approve is RpcOperation<
    {
      @doc("The data subscription identifier.")
      @path
      dataSubscriptionId: uuid;

      @doc("The approver's decision.")
      @body
      decision: ApproverDecision;
    },
    DataSubscription
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("DataSubscriptions")
  @doc("Declines a data subscription request.")
  @route("/dataSubscriptions/{dataSubscriptionId}:decline")
  @post
  Decline is RpcOperation<
    {
      @doc("The data subscription identifier.")
      @path
      dataSubscriptionId: uuid;

      @doc("The approver's decision.")
      @body
      decision: ApproverDecision;
    },
    DataSubscription
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("DataSubscriptions")
  @doc("Completes a data subscription after access has been granted.")
  @route("/dataSubscriptions/{dataSubscriptionId}:complete")
  @post
  Complete is RpcOperation<
    {
      @doc("The data subscription identifier.")
      @path
      dataSubscriptionId: uuid;
    },
    DataSubscription
  >;
}

// ============================================================
// Workflows
// ============================================================

interface Workflows {
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("Workflows")
  @doc("Gets a workflow by its identifier.")
  @get
  Get is DataAccessOperations.ResourceRead<Workflow>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("Workflows")
  @doc("Creates or updates a workflow.")
  @route("/workflows/{workflowId}")
  @put
  CreateOrUpdate is RpcOperation<
    {
      @doc("The workflow identifier.")
      @path
      workflowId: uuid;

      @doc("The workflow payload.")
      @body
      workflow: Workflow;
    },
    Workflow
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("Workflows")
  @doc("Deletes a workflow.")
  @delete
  Delete is DataAccessOperations.ResourceDelete<Workflow>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("Workflows")
  @doc("Lists workflows with optional filtering.")
  @get
  List is DataAccessOperations.ResourceList<
    Workflow,
    ListQueryParametersTrait<{
      @doc("Continuation token for pagination.")
      @query
      skipToken?: string;

      @doc("Filter by enabled status.")
      @query
      isEnabled?: boolean;

      @doc("Filter by trigger type.")
      @query
      triggerType?: string;

      @doc("Filter by glossary hierarchy path.")
      @query
      underGlossaryHierarchy?: string;

      @doc("Filter by business concept.")
      @query
      businessConcept?: string;

      @doc("Filter by workflow type.")
      @query
      workflowType?: string;
    }>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("Workflows")
  @doc("Gets the data access request template.")
  @route("/workflows/templates/dataAccessRequestTemplate")
  @get
  GetTemplate is RpcOperation<{}, ActionListResponse>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("Workflows")
  @doc("Gets the data access request template for a specific trigger type.")
  @route("/workflows/templates/dataAccessRequestTemplate/{triggerType}")
  @get
  GetTemplateByTriggerType is RpcOperation<
    {
      @doc("The trigger type.")
      @path
      triggerType: string;
    },
    ActionListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("Workflows")
  @doc("Approves a workflow run.")
  @route("/workflows/{workflowId}/workflowRunId/{workflowRunId}:approve")
  @post
  ApproveRun is RpcOperation<
    {
      @doc("The workflow identifier.")
      @path
      workflowId: uuid;

      @doc("The workflow run identifier.")
      @path
      workflowRunId: uuid;

      @doc("The approver's decision.")
      @body
      decision: ApproverDecision;
    },
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("Workflows")
  @doc("Rejects a workflow run.")
  @route("/workflows/{workflowId}/workflowRunId/{workflowRunId}:reject")
  @post
  RejectRun is RpcOperation<
    {
      @doc("The workflow identifier.")
      @path
      workflowId: uuid;

      @doc("The workflow run identifier.")
      @path
      workflowRunId: uuid;

      @doc("The approver's decision.")
      @body
      decision: ApproverDecision;
    },
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("Workflows")
  @doc("Gets pending approvals for the current user.")
  @route("/approvals")
  @get
  GetApprovals is RpcOperation<
    {
      @doc("Continuation token for pagination.")
      @query
      skipToken?: string;

      @doc("Filter by approval status.")
      @query
      approvalStatus?: string;

      @doc("Filter by business concept.")
      @query
      businessConcept?: string;

      @doc("Filter by business concept type.")
      @query
      businessConceptType?: string;

      @doc("Filter by workflow type.")
      @query
      workflowType?: string;

      @doc("Filter by governance domain.")
      @query
      governanceDomain?: string;
    },
    ApprovalWorkflowListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("Workflows")
  @doc("Lists workflow runs with optional filtering.")
  @route("/workflowRuns")
  @get
  ListRuns is RpcOperation<
    {
      @doc("Continuation token for pagination.")
      @query
      skipToken?: string;

      @doc("Filter by glossary hierarchy path.")
      @query
      underGlossaryHierarchy?: string;

      @doc("Filter by workflow type.")
      @query
      workflowType?: string;

      @doc("Filter by status.")
      @query
      status?: string;

      @doc("Filter by applied concept identifier.")
      @query
      appliedConceptId?: string;

      @doc("Filter by business concept.")
      @query
      businessConcept?: string;

      @doc("Filter by business domain name.")
      @query
      businessDomainName?: string;

      @doc("Filter by business concept type.")
      @query
      businessConceptType?: string;

      @doc("Whether to ignore action statuses in filtering.")
      @query
      ignoreActionStatuses?: boolean;
    },
    WorkflowRunListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("Workflows")
  @doc("Gets a specific workflow run by identifier.")
  @route("/workflowRuns/{workflowRunId}")
  @get
  GetRun is RpcOperation<
    {
      @doc("The workflow run identifier.")
      @path
      workflowRunId: uuid;
    },
    WorkflowRun
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("Workflows")
  @doc("Gets approvals for a specific workflow run.")
  @route("/workflowRuns/{workflowRunId}/approvals")
  @get
  GetRunApprovals is RpcOperation<
    {
      @doc("The workflow run identifier.")
      @path
      workflowRunId: uuid;
    },
    WorkflowRunApprovalListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("Workflows")
  @doc("Updates a workflow run.")
  @route("/workflowRuns/{workflowRunId}")
  @put
  UpdateRun is RpcOperation<
    {
      @doc("The workflow run identifier.")
      @path
      workflowRunId: uuid;

      @doc("The workflow run payload.")
      @body
      workflowRun: WorkflowRun;
    },
    WorkflowRun
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("Workflows")
  @doc("Deletes a workflow run.")
  @route("/workflowRuns/{workflowRunId}")
  @delete
  DeleteRun is RpcOperation<
    {
      @doc("The workflow run identifier.")
      @path
      workflowRunId: uuid;
    },
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("Workflows")
  @doc("Triggers a workflow.")
  @route("/workflows/{workflowId}/trigger")
  @put
  Trigger is RpcOperation<
    {
      @doc("The workflow identifier.")
      @path
      workflowId: uuid;
    },
    {}
  >;
}

// ============================================================
// Workflow Runs (Status Checks)
// ============================================================

interface WorkflowRunStatus {
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("WorkflowRunStatus")
  @doc("Checks if a DataProductPublish workflow run is in progress for the specified data product.")
  @route("/dataProducts/{dataProductId}/workflowRunInProgress")
  @get
  GetDataProductWorkflowRunInProgress is RpcOperation<
    {
      @doc("The data product identifier.")
      @path
      dataProductId: uuid;
    },
    WorkflowRunInProgressResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("WorkflowRunStatus")
  @doc("Checks if a TermPublish workflow run is in progress for the specified term.")
  @route("/terms/{termId}/workflowRunInProgress")
  @get
  GetTermWorkflowRunInProgress is RpcOperation<
    {
      @doc("The term identifier.")
      @path
      termId: uuid;
    },
    WorkflowRunInProgressResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("WorkflowRunStatus")
  @doc("Checks if an enabled publish workflow exists for the specified data product's domain.")
  @route("/dataProducts/{dataProductId}/publishWorkflowEnabled")
  @get
  HasEnabledPublishWorkflowForDataProduct is RpcOperation<
    {
      @doc("The data product identifier.")
      @path
      dataProductId: uuid;
    },
    PublishWorkflowEnabledResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("WorkflowRunStatus")
  @doc("Checks if an enabled publish workflow exists for the specified term's domain.")
  @route("/terms/{termId}/publishWorkflowEnabled")
  @get
  HasEnabledPublishWorkflowForTerm is RpcOperation<
    {
      @doc("The term identifier.")
      @path
      termId: uuid;
    },
    PublishWorkflowEnabledResponse
  >;
}

// ============================================================
// Policy Sets - Data Products
// ============================================================

interface DataProductPolicySets {
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("PolicySets")
  @doc("Gets the applied policy set for a data product.")
  @route("/dataProducts/{dataProductId}/policySets/applied")
  @get
  GetApplied is RpcOperation<
    {
      @doc("The data product identifier.")
      @path
      dataProductId: uuid;
    },
    PolicySet
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("PolicySets")
  @doc("Creates or updates the applied policy set for a data product.")
  @route("/dataProducts/{dataProductId}/policySets/applied")
  @put
  CreateOrUpdateApplied is RpcOperation<
    {
      @doc("The data product identifier.")
      @path
      dataProductId: uuid;

      @doc("The policy set payload.")
      @body
      policySet: PolicySet;
    },
    PolicySet
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("PolicySets")
  @doc("Deletes the applied policy set for a data product.")
  @route("/dataProducts/{dataProductId}/policySets/applied")
  @delete
  DeleteApplied is RpcOperation<
    {
      @doc("The data product identifier.")
      @path
      dataProductId: uuid;
    },
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("PolicySets")
  @doc("Gets the effective policy set for a data product, combining applied and inherited policies.")
  @route("/dataProducts/{dataProductId}/policySets/effective")
  @get
  GetEffective is RpcOperation<
    {
      @doc("The data product identifier.")
      @path
      dataProductId: uuid;
    },
    PolicySet
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("PolicySets")
  @doc("Gets term policy sets associated with a data product.")
  @route("/dataProducts/{dataProductId}/policySets/terms")
  @get
  GetTermPolicies is RpcOperation<
    {
      @doc("The data product identifier.")
      @path
      dataProductId: uuid;
    },
    PolicySetListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("PolicySets")
  @doc("Gets critical data element policy sets associated with a data product.")
  @route("/dataProducts/{dataProductId}/policySets/criticalDataElements")
  @get
  GetCriticalDataElementPolicies is RpcOperation<
    {
      @doc("The data product identifier.")
      @path
      dataProductId: uuid;
    },
    PolicySetListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("PolicySets")
  @doc("Gets workflow settings for a data product policy set.")
  @route("/dataProducts/{dataProductId}/policySet")
  @get
  GetWorkflowSettings is RpcOperation<
    {
      @doc("The data product identifier.")
      @path
      dataProductId: uuid;
    },
    DataProductWorkflowSettingsResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("PolicySets")
  @doc("Gets the count of active subscribers for a data product.")
  @route("/dataProducts/{dataProductId}/activeSubscribers")
  @get
  GetActiveSubscribers is RpcOperation<
    {
      @doc("The data product identifier.")
      @path
      dataProductId: uuid;
    },
    ActiveSubscribersResponse
  >;
}

// ============================================================
// Policy Sets - Business Domains
// ============================================================

interface DomainPolicySets {
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("PolicySets")
  @doc("Gets the applied policy set for a business domain.")
  @route("/businessDomains/{domainId}/policySets/applied")
  @get
  GetApplied is RpcOperation<
    {
      @doc("The business domain identifier.")
      @path
      domainId: uuid;
    },
    PolicySet
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("PolicySets")
  @doc("Creates or updates the applied policy set for a business domain.")
  @route("/businessDomains/{domainId}/policySets/applied")
  @put
  CreateOrUpdateApplied is RpcOperation<
    {
      @doc("The business domain identifier.")
      @path
      domainId: uuid;

      @doc("The policy set payload.")
      @body
      policySet: PolicySet;
    },
    PolicySet
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("PolicySets")
  @doc("Deletes the applied policy set for a business domain.")
  @route("/businessDomains/{domainId}/policySets/applied")
  @delete
  DeleteApplied is RpcOperation<
    {
      @doc("The business domain identifier.")
      @path
      domainId: uuid;
    },
    {}
  >;
}

// ============================================================
// Policy Sets - Terms
// ============================================================

interface TermPolicySets {
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("PolicySets")
  @doc("Gets the applied policy set for a term.")
  @route("/terms/{termId}/policySets/applied")
  @get
  GetApplied is RpcOperation<
    {
      @doc("The term identifier.")
      @path
      termId: uuid;
    },
    PolicySet
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("PolicySets")
  @doc("Creates or updates the applied policy set for a term.")
  @route("/terms/{termId}/policySets/applied")
  @put
  CreateOrUpdateApplied is RpcOperation<
    {
      @doc("The term identifier.")
      @path
      termId: uuid;

      @doc("The policy set payload.")
      @body
      policySet: PolicySet;
    },
    PolicySet
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("PolicySets")
  @doc("Deletes the applied policy set for a term.")
  @route("/terms/{termId}/policySets/applied")
  @delete
  DeleteApplied is RpcOperation<
    {
      @doc("The term identifier.")
      @path
      termId: uuid;
    },
    {}
  >;
}

// ============================================================
// Policy Sets - Critical Data Elements
// ============================================================

interface CriticalDataElementPolicySets {
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("PolicySets")
  @doc("Gets the applied policy set for a critical data element.")
  @route("/criticalDataElements/{criticalDataElementId}/policySets/applied")
  @get
  GetApplied is RpcOperation<
    {
      @doc("The critical data element identifier.")
      @path
      criticalDataElementId: uuid;
    },
    PolicySet
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("PolicySets")
  @doc("Creates or updates the applied policy set for a critical data element.")
  @route("/criticalDataElements/{criticalDataElementId}/policySets/applied")
  @put
  CreateOrUpdateApplied is RpcOperation<
    {
      @doc("The critical data element identifier.")
      @path
      criticalDataElementId: uuid;

      @doc("The policy set payload.")
      @body
      policySet: PolicySet;
    },
    PolicySet
  >;
}
