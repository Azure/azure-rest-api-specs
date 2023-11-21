import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ConfidentialLedger;

interface OperationsOperations {
  @summary("Retrieves a list of available API operations under this Resource Provider.")
  @doc("Retrieves a list of available API operations")
  @route("/providers/Microsoft.ConfidentialLedger/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, ResourceProviderOperationList>;
}

@doc("To check whether a resource name is available.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.ConfidentialLedger/checkNameAvailability")
@post
op CheckNameAvailability is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription.")
    @path
    subscriptionId: string;

    @doc("Name availability request payload.")
    @body
    nameAvailabilityRequest: CheckNameAvailabilityRequest;
  },
  CheckNameAvailabilityResponse
>;

interface LedgerOperations {
  @summary("Retrieves information about a Confidential Ledger resource.")
  @doc("Retrieves the properties of a Confidential Ledger.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ConfidentialLedger/ledgers/{ledgerName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Confidential Ledger")
      @path
      ledgerName: string;
    },
    ConfidentialLedger
  >;

  @summary("Deletes a Confidential Ledger resource.")
  @doc("Deletes an existing Confidential Ledger.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ConfidentialLedger/ledgers/{ledgerName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Confidential Ledger")
      @path
      ledgerName: string;
    },
    void
  >;

  @summary("Creates a  Confidential Ledger.")
  @doc("Creates a  Confidential Ledger with the specified ledger parameters.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ConfidentialLedger/ledgers/{ledgerName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Confidential Ledger")
      @path
      ledgerName: string;

      @doc("Confidential Ledger Create Request Body")
      @body
      confidentialLedger: ConfidentialLedger;
    },
    ConfidentialLedger
  >;

  @summary("Update Confidential Ledger properties")
  @doc("Updates properties of Confidential Ledger")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ConfidentialLedger/ledgers/{ledgerName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Confidential Ledger")
      @path
      ledgerName: string;

      @doc("Confidential Ledger request body for Updating Ledger")
      @body
      confidentialLedger: ConfidentialLedger;
    },
    ConfidentialLedger | void
  >;

  @summary("""
Retrieves information about all Confidential Ledger resources under the given
subscription and resource group
""")
  @doc("Retrieves the properties of all Confidential Ledgers.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ConfidentialLedger/ledgers")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The filter to apply on the list operation. eg. $filter=ledgerType eq 'Public'")
      @query
      $filter: string;
    },
    ConfidentialLedgerList
  >;

  @summary("""
Retrieves information about all Confidential Ledger resources under the given
subscription
""")
  @doc("Retrieves the properties of all Confidential Ledgers.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ConfidentialLedger/ledgers/")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The filter to apply on the list operation. eg. $filter=ledgerType eq 'Public'")
      @query
      $filter: string;
    },
    ConfidentialLedgerList
  >;
}

interface ManagedCCFOperations {
  @summary("Retrieves information about a Managed CCF resource.")
  @doc("Retrieves the properties of a Managed CCF app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ConfidentialLedger/managedCCFs/{appName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Managed CCF")
      @path
      appName: string;
    },
    ManagedCCF
  >;

  @summary("Deletes a Managed CCF resource.")
  @doc("Deletes an existing Managed CCF.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ConfidentialLedger/managedCCFs/{appName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Managed CCF")
      @path
      appName: string;
    },
    void
  >;

  @summary("Creates a Managed CCF.")
  @doc("Creates a Managed CCF with the specified Managed CCF parameters.")
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [ManagedCCF]
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ConfidentialLedger/managedCCFs/{appName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Managed CCF")
      @path
      appName: string;

      @doc("Managed CCF Create Request Body")
      @body
      ManagedCCF: ManagedCCF;
    },
    ManagedCCF | void
  >;

  @summary("Update Managed CCF properties")
  @doc("Updates properties of Managed CCF")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ConfidentialLedger/managedCCFs/{appName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the Managed CCF")
      @path
      appName: string;

      @doc("Request body for Updating Managed CCF App")
      @body
      ManagedCCF: ManagedCCF;
    },
    void
  >;

  @summary("""
Retrieves information about all Managed CCF resources under the given
subscription and resource group
""")
  @doc("Retrieves the properties of all Managed CCF apps.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ConfidentialLedger/managedCCFs")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The filter to apply on the list operation. eg. $filter=ledgerType eq 'Public'")
      @query
      $filter: string;
    },
    ManagedCCFList
  >;

  @summary("""
Retrieves information about all Managed CCF resources under the given
subscription
""")
  @doc("Retrieves the properties of all Managed CCF.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ConfidentialLedger/managedCCFs/")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The filter to apply on the list operation. eg. $filter=ledgerType eq 'Public'")
      @query
      $filter: string;
    },
    ManagedCCFList
  >;
}
