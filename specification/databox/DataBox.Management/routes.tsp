import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.DataBox;

interface ServiceOperations {
  @doc("This method provides the list of available skus for the given subscription, resource group and location.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/locations/{location}/availableSkus")
  @post
  ListAvailableSkusByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("The location of the resource")
      @path
      location: string;

      @doc("Filters for showing the available skus.")
      @body
      availableSkuRequest: AvailableSkuRequest;
    },
    AvailableSkusResult
  >;

  @doc("[DEPRECATED NOTICE: This operation will soon be removed]. This method validates the customer shipping address and provide alternate addresses if any.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataBox/locations/{location}/validateAddress")
  @post
  ValidateAddress is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The location of the resource")
      @path
      location: string;

      @doc("Shipping address of the customer.")
      @body
      validateAddress: ValidateAddress;
    },
    AddressValidationOutput
  >;

  @doc("This method does all necessary pre-job creation validation under resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/locations/{location}/validateInputs")
  @post
  ValidateInputsByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("The location of the resource")
      @path
      location: string;

      @doc("Inputs of the customer.")
      @body
      validationRequest: ValidationRequest;
    },
    ValidationResponse
  >;

  @doc("This method does all necessary pre-job creation validation under subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataBox/locations/{location}/validateInputs")
  @post
  ValidateInputs is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The location of the resource")
      @path
      location: string;

      @doc("Inputs of the customer.")
      @body
      validationRequest: ValidationRequest;
    },
    ValidationResponse
  >;

  @doc("This API provides configuration details specific to given region/location at Subscription level.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataBox/locations/{location}/regionConfiguration")
  @post
  RegionConfiguration is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The location of the resource")
      @path
      location: string;

      @doc("Request body to get the configuration for the region.")
      @body
      regionConfigurationRequest: RegionConfigurationRequest;
    },
    RegionConfigurationResponse
  >;

  @doc("This API provides configuration details specific to given region/location at Resource group level.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/locations/{location}/regionConfiguration")
  @post
  RegionConfigurationByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("The location of the resource")
      @path
      location: string;

      @doc("Request body to get the configuration for the region at resource group level.")
      @body
      regionConfigurationRequest: RegionConfigurationRequest;
    },
    RegionConfigurationResponse
  >;
}
