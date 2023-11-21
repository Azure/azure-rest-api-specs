import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace PowerBIDedicated;

interface CapacitiesOperations {
  @doc("Gets details about the specified dedicated capacity.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PowerBIDedicated/capacities/{dedicatedCapacityName}")
  @get
  GetDetails is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the Azure Resource group of which a given PowerBIDedicated capacity
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the dedicated capacity. It must be a minimum of 3 characters, and a
maximum of 63.
""")
      @path
      dedicatedCapacityName: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    DedicatedCapacity
  >;

  @doc("""
Provisions the specified Dedicated capacity based on the configuration
specified in the request.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PowerBIDedicated/capacities/{dedicatedCapacityName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the Azure Resource group of which a given PowerBIDedicated capacity
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Dedicated capacity. It must be a minimum of 3 characters, and a
maximum of 63.
""")
      @path
      dedicatedCapacityName: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Contains the information used to provision the Dedicated capacity.")
      @body
      capacityParameters: DedicatedCapacity;
    },
    DedicatedCapacity
  >;

  @doc("Deletes the specified Dedicated capacity.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PowerBIDedicated/capacities/{dedicatedCapacityName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the Azure Resource group of which a given PowerBIDedicated capacity
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Dedicated capacity. It must be at least 3 characters in length,
and no more than 63.
""")
      @path
      dedicatedCapacityName: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Updates the current state of the specified Dedicated capacity.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PowerBIDedicated/capacities/{dedicatedCapacityName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the Azure Resource group of which a given PowerBIDedicated capacity
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Dedicated capacity. It must be at least 3 characters in length,
and no more than 63.
""")
      @path
      dedicatedCapacityName: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Request object that contains the updated information for the capacity.")
      @body
      capacityUpdateParameters: DedicatedCapacityUpdateParameters;
    },
    DedicatedCapacity
  >;

  @doc("Suspends operation of the specified dedicated capacity instance.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PowerBIDedicated/capacities/{dedicatedCapacityName}/suspend")
  @post
  Suspend is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the Azure Resource group of which a given PowerBIDedicated capacity
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Dedicated capacity. It must be at least 3 characters in length,
and no more than 63.
""")
      @path
      dedicatedCapacityName: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Resumes operation of the specified Dedicated capacity instance.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PowerBIDedicated/capacities/{dedicatedCapacityName}/resume")
  @post
  Resume is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the Azure Resource group of which a given PowerBIDedicated capacity
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Dedicated capacity. It must be at least 3 characters in length,
and no more than 63.
""")
      @path
      dedicatedCapacityName: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets all the Dedicated capacities for the given resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PowerBIDedicated/capacities")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the Azure Resource group of which a given PowerBIDedicated capacity
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    DedicatedCapacities
  >;

  @doc("Lists all the Dedicated capacities for the given subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.PowerBIDedicated/capacities")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    DedicatedCapacities
  >;

  @doc("Lists eligible SKUs for PowerBI Dedicated resource provider.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.PowerBIDedicated/skus")
  @get
  ListSkus is Azure.Core.Foundations.Operation<
    {
      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SkuEnumerationForNewResourceResult
  >;

  @doc("Lists eligible SKUs for a PowerBI Dedicated resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PowerBIDedicated/capacities/{dedicatedCapacityName}/skus")
  @get
  ListSkusForCapacity is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the Azure Resource group of which a given PowerBIDedicated capacity
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Dedicated capacity. It must be at least 3 characters in length,
and no more than 63.
""")
      @path
      dedicatedCapacityName: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SkuEnumerationForExistingResourceResult
  >;

  @doc("Check the name availability in the target location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.PowerBIDedicated/locations/{location}/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The region name which the operation will lookup into.")
      @path
      location: string;

      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The name of the capacity.")
      @body
      capacityParameters: CheckCapacityNameAvailabilityParameters;
    },
    CheckCapacityNameAvailabilityResult
  >;
}

interface OperationsOperations {
  @doc("Lists all of the available PowerBIDedicated REST API operations.")
  @route("/providers/Microsoft.PowerBIDedicated/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface AutoScaleVCoresOperations {
  @doc("Gets details about the specified auto scale v-core.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PowerBIDedicated/autoScaleVCores/{vcoreName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the Azure Resource group of which a given PowerBIDedicated capacity
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the auto scale v-core. It must be a minimum of 3 characters, and a
maximum of 63.
""")
      @path
      vcoreName: string;
    },
    AutoScaleVCore
  >;

  @doc("""
Provisions the specified auto scale v-core based on the configuration specified
in the request.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PowerBIDedicated/autoScaleVCores/{vcoreName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the Azure Resource group of which a given PowerBIDedicated capacity
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the auto scale v-core. It must be a minimum of 3 characters, and a
maximum of 63.
""")
      @path
      vcoreName: string;

      @doc("Contains the information used to provision the auto scale v-core.")
      @body
      vCoreParameters: AutoScaleVCore;
    },
    AutoScaleVCore
  >;

  @doc("Deletes the specified auto scale v-core.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PowerBIDedicated/autoScaleVCores/{vcoreName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the Azure Resource group of which a given PowerBIDedicated capacity
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the auto scale v-core. It must be a minimum of 3 characters, and a
maximum of 63.
""")
      @path
      vcoreName: string;
    },
    void
  >;

  @doc("Updates the current state of the specified auto scale v-core.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PowerBIDedicated/autoScaleVCores/{vcoreName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the Azure Resource group of which a given PowerBIDedicated capacity
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the auto scale v-core. It must be a minimum of 3 characters, and a
maximum of 63.
""")
      @path
      vcoreName: string;

      @doc("Request object that contains the updated information for the auto scale v-core.")
      @body
      vCoreUpdateParameters: AutoScaleVCoreUpdateParameters;
    },
    AutoScaleVCore
  >;

  @doc("Gets all the auto scale v-cores for the given resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PowerBIDedicated/autoScaleVCores")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the Azure Resource group of which a given PowerBIDedicated capacity
is part. This name must be at least 1 character in length, and no more than 90.
""")
      @path
      resourceGroupName: string;
    },
    AutoScaleVCoreListResult
  >;

  @doc("Lists all the auto scale v-cores for the given subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.PowerBIDedicated/autoScaleVCores")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("""
A unique identifier for a Microsoft Azure subscription. The subscription ID
forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    AutoScaleVCoreListResult
  >;
}
