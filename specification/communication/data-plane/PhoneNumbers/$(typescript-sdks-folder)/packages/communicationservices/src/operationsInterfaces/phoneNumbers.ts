import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { SimplePollerLike, OperationState } from "@azure/core-lro";
import {
  PhoneNumberAreaCode,
  PhoneNumberType,
  PhoneNumbersListAreaCodesOptionalParams,
  PhoneNumberCountry,
  PhoneNumbersListAvailableCountriesOptionalParams,
  PhoneNumberLocality,
  PhoneNumbersListAvailableLocalitiesOptionalParams,
  PhoneNumberOffering,
  PhoneNumbersListOfferingsOptionalParams,
  PurchasedPhoneNumber,
  PhoneNumbersListPhoneNumbersOptionalParams,
  PhoneNumberSearchRequest,
  PhoneNumbersSearchAvailablePhoneNumbersOptionalParams,
  PhoneNumbersSearchAvailablePhoneNumbersResponse,
  PhoneNumbersGetSearchResultOptionalParams,
  PhoneNumbersGetSearchResultResponse,
  PhoneNumberPurchaseRequest,
  PhoneNumbersPurchasePhoneNumbersOptionalParams,
  PhoneNumbersPurchasePhoneNumbersResponse,
  PhoneNumbersGetOperationOptionalParams,
  PhoneNumbersGetOperationResponse,
  PhoneNumbersCancelOperationOptionalParams,
  PhoneNumbersUpdateCapabilitiesOptionalParams,
  PhoneNumbersUpdateCapabilitiesResponse,
  PhoneNumbersGetByNumberOptionalParams,
  PhoneNumbersGetByNumberResponse,
  PhoneNumbersReleasePhoneNumberOptionalParams,
  PhoneNumbersReleasePhoneNumberResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a PhoneNumbers. */
export interface PhoneNumbers {
  /**
   * Gets the list of available area codes.
   * @param countryCode The ISO 3166-2 country code, e.g. US.
   * @param phoneNumberType Filter by numberType, e.g. Geographic, TollFree.
   * @param options The options parameters.
   */
  listAreaCodes(
    countryCode: string,
    phoneNumberType: PhoneNumberType,
    options?: PhoneNumbersListAreaCodesOptionalParams
  ): PagedAsyncIterableIterator<PhoneNumberAreaCode>;
  /**
   * Gets the list of supported countries.
   * @param options The options parameters.
   */
  listAvailableCountries(
    options?: PhoneNumbersListAvailableCountriesOptionalParams
  ): PagedAsyncIterableIterator<PhoneNumberCountry>;
  /**
   * Gets the list of cities or towns with available phone numbers.
   * @param countryCode The ISO 3166-2 country code, e.g. US.
   * @param options The options parameters.
   */
  listAvailableLocalities(
    countryCode: string,
    options?: PhoneNumbersListAvailableLocalitiesOptionalParams
  ): PagedAsyncIterableIterator<PhoneNumberLocality>;
  /**
   * List available offerings of capabilities with rates for the given country.
   * @param countryCode The ISO 3166-2 country code, e.g. US.
   * @param options The options parameters.
   */
  listOfferings(
    countryCode: string,
    options?: PhoneNumbersListOfferingsOptionalParams
  ): PagedAsyncIterableIterator<PhoneNumberOffering>;
  /**
   * Gets the list of all purchased phone numbers.
   * @param options The options parameters.
   */
  listPhoneNumbers(
    options?: PhoneNumbersListPhoneNumbersOptionalParams
  ): PagedAsyncIterableIterator<PurchasedPhoneNumber>;
  /**
   * Search for available phone numbers to purchase.
   * @param countryCode The ISO 3166-2 country code, e.g. US.
   * @param body The phone number search request.
   * @param options The options parameters.
   */
  beginSearchAvailablePhoneNumbers(
    countryCode: string,
    body: PhoneNumberSearchRequest,
    options?: PhoneNumbersSearchAvailablePhoneNumbersOptionalParams
  ): Promise<
    SimplePollerLike<
      OperationState<PhoneNumbersSearchAvailablePhoneNumbersResponse>,
      PhoneNumbersSearchAvailablePhoneNumbersResponse
    >
  >;
  /**
   * Search for available phone numbers to purchase.
   * @param countryCode The ISO 3166-2 country code, e.g. US.
   * @param body The phone number search request.
   * @param options The options parameters.
   */
  beginSearchAvailablePhoneNumbersAndWait(
    countryCode: string,
    body: PhoneNumberSearchRequest,
    options?: PhoneNumbersSearchAvailablePhoneNumbersOptionalParams
  ): Promise<PhoneNumbersSearchAvailablePhoneNumbersResponse>;
  /**
   * Gets a phone number search result by search id.
   * @param searchId The search Id.
   * @param options The options parameters.
   */
  getSearchResult(
    searchId: string,
    options?: PhoneNumbersGetSearchResultOptionalParams
  ): Promise<PhoneNumbersGetSearchResultResponse>;
  /**
   * Purchases phone numbers.
   * @param body The phone number purchase request
   * @param options The options parameters.
   */
  beginPurchasePhoneNumbers(
    body: PhoneNumberPurchaseRequest,
    options?: PhoneNumbersPurchasePhoneNumbersOptionalParams
  ): Promise<
    SimplePollerLike<
      OperationState<PhoneNumbersPurchasePhoneNumbersResponse>,
      PhoneNumbersPurchasePhoneNumbersResponse
    >
  >;
  /**
   * Purchases phone numbers.
   * @param body The phone number purchase request
   * @param options The options parameters.
   */
  beginPurchasePhoneNumbersAndWait(
    body: PhoneNumberPurchaseRequest,
    options?: PhoneNumbersPurchasePhoneNumbersOptionalParams
  ): Promise<PhoneNumbersPurchasePhoneNumbersResponse>;
  /**
   * Gets an operation by its id.
   * @param operationId The id of the operation
   * @param options The options parameters.
   */
  getOperation(
    operationId: string,
    options?: PhoneNumbersGetOperationOptionalParams
  ): Promise<PhoneNumbersGetOperationResponse>;
  /**
   * Cancels an operation by its id.
   * @param operationId The id of the operation
   * @param options The options parameters.
   */
  cancelOperation(
    operationId: string,
    options?: PhoneNumbersCancelOperationOptionalParams
  ): Promise<void>;
  /**
   * Updates the capabilities of a phone number.
   * @param phoneNumber The phone number id in E.164 format. The leading plus can be either + or encoded
   *                    as %2B, e.g. +11234567890.
   * @param options The options parameters.
   */
  beginUpdateCapabilities(
    phoneNumber: string,
    options?: PhoneNumbersUpdateCapabilitiesOptionalParams
  ): Promise<
    SimplePollerLike<
      OperationState<PhoneNumbersUpdateCapabilitiesResponse>,
      PhoneNumbersUpdateCapabilitiesResponse
    >
  >;
  /**
   * Updates the capabilities of a phone number.
   * @param phoneNumber The phone number id in E.164 format. The leading plus can be either + or encoded
   *                    as %2B, e.g. +11234567890.
   * @param options The options parameters.
   */
  beginUpdateCapabilitiesAndWait(
    phoneNumber: string,
    options?: PhoneNumbersUpdateCapabilitiesOptionalParams
  ): Promise<PhoneNumbersUpdateCapabilitiesResponse>;
  /**
   * Gets the details of the given purchased phone number.
   * @param phoneNumber The purchased phone number whose details are to be fetched in E.164 format, e.g.
   *                    +11234567890.
   * @param options The options parameters.
   */
  getByNumber(
    phoneNumber: string,
    options?: PhoneNumbersGetByNumberOptionalParams
  ): Promise<PhoneNumbersGetByNumberResponse>;
  /**
   * Releases a purchased phone number.
   * @param phoneNumber Phone number to be released, e.g. +11234567890.
   * @param options The options parameters.
   */
  beginReleasePhoneNumber(
    phoneNumber: string,
    options?: PhoneNumbersReleasePhoneNumberOptionalParams
  ): Promise<
    SimplePollerLike<
      OperationState<PhoneNumbersReleasePhoneNumberResponse>,
      PhoneNumbersReleasePhoneNumberResponse
    >
  >;
  /**
   * Releases a purchased phone number.
   * @param phoneNumber Phone number to be released, e.g. +11234567890.
   * @param options The options parameters.
   */
  beginReleasePhoneNumberAndWait(
    phoneNumber: string,
    options?: PhoneNumbersReleasePhoneNumberOptionalParams
  ): Promise<PhoneNumbersReleasePhoneNumberResponse>;
}
