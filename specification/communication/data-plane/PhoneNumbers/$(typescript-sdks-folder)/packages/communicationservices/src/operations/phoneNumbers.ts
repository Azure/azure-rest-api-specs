import { PagedAsyncIterableIterator, PageSettings } from "@azure/core-paging";
import { setContinuationToken } from "../pagingHelper";
import { PhoneNumbers } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { AzureCommunicationServices } from "../azureCommunicationServices";
import {
  SimplePollerLike,
  OperationState,
  createHttpPoller
} from "@azure/core-lro";
import { createLroSpec } from "../lroImpl";
import {
  PhoneNumberAreaCode,
  PhoneNumbersListAreaCodesNextOptionalParams,
  PhoneNumberType,
  PhoneNumbersListAreaCodesOptionalParams,
  PhoneNumbersListAreaCodesResponse,
  PhoneNumberCountry,
  PhoneNumbersListAvailableCountriesNextOptionalParams,
  PhoneNumbersListAvailableCountriesOptionalParams,
  PhoneNumbersListAvailableCountriesResponse,
  PhoneNumberLocality,
  PhoneNumbersListAvailableLocalitiesNextOptionalParams,
  PhoneNumbersListAvailableLocalitiesOptionalParams,
  PhoneNumbersListAvailableLocalitiesResponse,
  PhoneNumberOffering,
  PhoneNumbersListOfferingsNextOptionalParams,
  PhoneNumbersListOfferingsOptionalParams,
  PhoneNumbersListOfferingsResponse,
  PurchasedPhoneNumber,
  PhoneNumbersListPhoneNumbersNextOptionalParams,
  PhoneNumbersListPhoneNumbersOptionalParams,
  PhoneNumbersListPhoneNumbersResponse,
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
  PhoneNumbersReleasePhoneNumberResponse,
  PhoneNumbersListAreaCodesNextResponse,
  PhoneNumbersListAvailableCountriesNextResponse,
  PhoneNumbersListAvailableLocalitiesNextResponse,
  PhoneNumbersListOfferingsNextResponse,
  PhoneNumbersListPhoneNumbersNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing PhoneNumbers operations. */
export class PhoneNumbersImpl implements PhoneNumbers {
  private readonly client: AzureCommunicationServices;

  /**
   * Initialize a new instance of the class PhoneNumbers class.
   * @param client Reference to the service client
   */
  constructor(client: AzureCommunicationServices) {
    this.client = client;
  }

  /**
   * Gets the list of available area codes.
   * @param countryCode The ISO 3166-2 country code, e.g. US.
   * @param phoneNumberType Filter by numberType, e.g. Geographic, TollFree.
   * @param options The options parameters.
   */
  public listAreaCodes(
    countryCode: string,
    phoneNumberType: PhoneNumberType,
    options?: PhoneNumbersListAreaCodesOptionalParams
  ): PagedAsyncIterableIterator<PhoneNumberAreaCode> {
    const iter = this.listAreaCodesPagingAll(
      countryCode,
      phoneNumberType,
      options
    );
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: (settings?: PageSettings) => {
        if (settings?.maxPageSize) {
          throw new Error("maxPageSize is not supported by this operation.");
        }
        return this.listAreaCodesPagingPage(
          countryCode,
          phoneNumberType,
          options,
          settings
        );
      }
    };
  }

  private async *listAreaCodesPagingPage(
    countryCode: string,
    phoneNumberType: PhoneNumberType,
    options?: PhoneNumbersListAreaCodesOptionalParams,
    settings?: PageSettings
  ): AsyncIterableIterator<PhoneNumberAreaCode[]> {
    let result: PhoneNumbersListAreaCodesResponse;
    let continuationToken = settings?.continuationToken;
    if (!continuationToken) {
      result = await this._listAreaCodes(countryCode, phoneNumberType, options);
      let page = result.areaCodes || [];
      continuationToken = result.nextLink;
      setContinuationToken(page, continuationToken);
      yield page;
    }
    while (continuationToken) {
      result = await this._listAreaCodesNext(
        countryCode,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      let page = result.areaCodes || [];
      setContinuationToken(page, continuationToken);
      yield page;
    }
  }

  private async *listAreaCodesPagingAll(
    countryCode: string,
    phoneNumberType: PhoneNumberType,
    options?: PhoneNumbersListAreaCodesOptionalParams
  ): AsyncIterableIterator<PhoneNumberAreaCode> {
    for await (const page of this.listAreaCodesPagingPage(
      countryCode,
      phoneNumberType,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Gets the list of supported countries.
   * @param options The options parameters.
   */
  public listAvailableCountries(
    options?: PhoneNumbersListAvailableCountriesOptionalParams
  ): PagedAsyncIterableIterator<PhoneNumberCountry> {
    const iter = this.listAvailableCountriesPagingAll(options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: (settings?: PageSettings) => {
        if (settings?.maxPageSize) {
          throw new Error("maxPageSize is not supported by this operation.");
        }
        return this.listAvailableCountriesPagingPage(options, settings);
      }
    };
  }

  private async *listAvailableCountriesPagingPage(
    options?: PhoneNumbersListAvailableCountriesOptionalParams,
    settings?: PageSettings
  ): AsyncIterableIterator<PhoneNumberCountry[]> {
    let result: PhoneNumbersListAvailableCountriesResponse;
    let continuationToken = settings?.continuationToken;
    if (!continuationToken) {
      result = await this._listAvailableCountries(options);
      let page = result.countries || [];
      continuationToken = result.nextLink;
      setContinuationToken(page, continuationToken);
      yield page;
    }
    while (continuationToken) {
      result = await this._listAvailableCountriesNext(
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      let page = result.countries || [];
      setContinuationToken(page, continuationToken);
      yield page;
    }
  }

  private async *listAvailableCountriesPagingAll(
    options?: PhoneNumbersListAvailableCountriesOptionalParams
  ): AsyncIterableIterator<PhoneNumberCountry> {
    for await (const page of this.listAvailableCountriesPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Gets the list of cities or towns with available phone numbers.
   * @param countryCode The ISO 3166-2 country code, e.g. US.
   * @param options The options parameters.
   */
  public listAvailableLocalities(
    countryCode: string,
    options?: PhoneNumbersListAvailableLocalitiesOptionalParams
  ): PagedAsyncIterableIterator<PhoneNumberLocality> {
    const iter = this.listAvailableLocalitiesPagingAll(countryCode, options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: (settings?: PageSettings) => {
        if (settings?.maxPageSize) {
          throw new Error("maxPageSize is not supported by this operation.");
        }
        return this.listAvailableLocalitiesPagingPage(
          countryCode,
          options,
          settings
        );
      }
    };
  }

  private async *listAvailableLocalitiesPagingPage(
    countryCode: string,
    options?: PhoneNumbersListAvailableLocalitiesOptionalParams,
    settings?: PageSettings
  ): AsyncIterableIterator<PhoneNumberLocality[]> {
    let result: PhoneNumbersListAvailableLocalitiesResponse;
    let continuationToken = settings?.continuationToken;
    if (!continuationToken) {
      result = await this._listAvailableLocalities(countryCode, options);
      let page = result.phoneNumberLocalities || [];
      continuationToken = result.nextLink;
      setContinuationToken(page, continuationToken);
      yield page;
    }
    while (continuationToken) {
      result = await this._listAvailableLocalitiesNext(
        countryCode,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      let page = result.phoneNumberLocalities || [];
      setContinuationToken(page, continuationToken);
      yield page;
    }
  }

  private async *listAvailableLocalitiesPagingAll(
    countryCode: string,
    options?: PhoneNumbersListAvailableLocalitiesOptionalParams
  ): AsyncIterableIterator<PhoneNumberLocality> {
    for await (const page of this.listAvailableLocalitiesPagingPage(
      countryCode,
      options
    )) {
      yield* page;
    }
  }

  /**
   * List available offerings of capabilities with rates for the given country.
   * @param countryCode The ISO 3166-2 country code, e.g. US.
   * @param options The options parameters.
   */
  public listOfferings(
    countryCode: string,
    options?: PhoneNumbersListOfferingsOptionalParams
  ): PagedAsyncIterableIterator<PhoneNumberOffering> {
    const iter = this.listOfferingsPagingAll(countryCode, options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: (settings?: PageSettings) => {
        if (settings?.maxPageSize) {
          throw new Error("maxPageSize is not supported by this operation.");
        }
        return this.listOfferingsPagingPage(countryCode, options, settings);
      }
    };
  }

  private async *listOfferingsPagingPage(
    countryCode: string,
    options?: PhoneNumbersListOfferingsOptionalParams,
    settings?: PageSettings
  ): AsyncIterableIterator<PhoneNumberOffering[]> {
    let result: PhoneNumbersListOfferingsResponse;
    let continuationToken = settings?.continuationToken;
    if (!continuationToken) {
      result = await this._listOfferings(countryCode, options);
      let page = result.phoneNumberOfferings || [];
      continuationToken = result.nextLink;
      setContinuationToken(page, continuationToken);
      yield page;
    }
    while (continuationToken) {
      result = await this._listOfferingsNext(
        countryCode,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      let page = result.phoneNumberOfferings || [];
      setContinuationToken(page, continuationToken);
      yield page;
    }
  }

  private async *listOfferingsPagingAll(
    countryCode: string,
    options?: PhoneNumbersListOfferingsOptionalParams
  ): AsyncIterableIterator<PhoneNumberOffering> {
    for await (const page of this.listOfferingsPagingPage(
      countryCode,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Gets the list of all purchased phone numbers.
   * @param options The options parameters.
   */
  public listPhoneNumbers(
    options?: PhoneNumbersListPhoneNumbersOptionalParams
  ): PagedAsyncIterableIterator<PurchasedPhoneNumber> {
    const iter = this.listPhoneNumbersPagingAll(options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: (settings?: PageSettings) => {
        if (settings?.maxPageSize) {
          throw new Error("maxPageSize is not supported by this operation.");
        }
        return this.listPhoneNumbersPagingPage(options, settings);
      }
    };
  }

  private async *listPhoneNumbersPagingPage(
    options?: PhoneNumbersListPhoneNumbersOptionalParams,
    settings?: PageSettings
  ): AsyncIterableIterator<PurchasedPhoneNumber[]> {
    let result: PhoneNumbersListPhoneNumbersResponse;
    let continuationToken = settings?.continuationToken;
    if (!continuationToken) {
      result = await this._listPhoneNumbers(options);
      let page = result.phoneNumbers || [];
      continuationToken = result.nextLink;
      setContinuationToken(page, continuationToken);
      yield page;
    }
    while (continuationToken) {
      result = await this._listPhoneNumbersNext(continuationToken, options);
      continuationToken = result.nextLink;
      let page = result.phoneNumbers || [];
      setContinuationToken(page, continuationToken);
      yield page;
    }
  }

  private async *listPhoneNumbersPagingAll(
    options?: PhoneNumbersListPhoneNumbersOptionalParams
  ): AsyncIterableIterator<PurchasedPhoneNumber> {
    for await (const page of this.listPhoneNumbersPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Gets the list of available area codes.
   * @param countryCode The ISO 3166-2 country code, e.g. US.
   * @param phoneNumberType Filter by numberType, e.g. Geographic, TollFree.
   * @param options The options parameters.
   */
  private _listAreaCodes(
    countryCode: string,
    phoneNumberType: PhoneNumberType,
    options?: PhoneNumbersListAreaCodesOptionalParams
  ): Promise<PhoneNumbersListAreaCodesResponse> {
    return this.client.sendOperationRequest(
      { countryCode, phoneNumberType, options },
      listAreaCodesOperationSpec
    );
  }

  /**
   * Gets the list of supported countries.
   * @param options The options parameters.
   */
  private _listAvailableCountries(
    options?: PhoneNumbersListAvailableCountriesOptionalParams
  ): Promise<PhoneNumbersListAvailableCountriesResponse> {
    return this.client.sendOperationRequest(
      { options },
      listAvailableCountriesOperationSpec
    );
  }

  /**
   * Gets the list of cities or towns with available phone numbers.
   * @param countryCode The ISO 3166-2 country code, e.g. US.
   * @param options The options parameters.
   */
  private _listAvailableLocalities(
    countryCode: string,
    options?: PhoneNumbersListAvailableLocalitiesOptionalParams
  ): Promise<PhoneNumbersListAvailableLocalitiesResponse> {
    return this.client.sendOperationRequest(
      { countryCode, options },
      listAvailableLocalitiesOperationSpec
    );
  }

  /**
   * List available offerings of capabilities with rates for the given country.
   * @param countryCode The ISO 3166-2 country code, e.g. US.
   * @param options The options parameters.
   */
  private _listOfferings(
    countryCode: string,
    options?: PhoneNumbersListOfferingsOptionalParams
  ): Promise<PhoneNumbersListOfferingsResponse> {
    return this.client.sendOperationRequest(
      { countryCode, options },
      listOfferingsOperationSpec
    );
  }

  /**
   * Search for available phone numbers to purchase.
   * @param countryCode The ISO 3166-2 country code, e.g. US.
   * @param body The phone number search request.
   * @param options The options parameters.
   */
  async beginSearchAvailablePhoneNumbers(
    countryCode: string,
    body: PhoneNumberSearchRequest,
    options?: PhoneNumbersSearchAvailablePhoneNumbersOptionalParams
  ): Promise<
    SimplePollerLike<
      OperationState<PhoneNumbersSearchAvailablePhoneNumbersResponse>,
      PhoneNumbersSearchAvailablePhoneNumbersResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<PhoneNumbersSearchAvailablePhoneNumbersResponse> => {
      return this.client.sendOperationRequest(args, spec);
    };
    const sendOperationFn = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ) => {
      let currentRawResponse:
        | coreClient.FullOperationResponse
        | undefined = undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback
        }
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON()
        }
      };
    };

    const lro = createLroSpec({
      sendOperationFn,
      args: { countryCode, body, options },
      spec: searchAvailablePhoneNumbersOperationSpec
    });
    const poller = await createHttpPoller<
      PhoneNumbersSearchAvailablePhoneNumbersResponse,
      OperationState<PhoneNumbersSearchAvailablePhoneNumbersResponse>
    >(lro, {
      restoreFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      resourceLocationConfig: "location"
    });
    await poller.poll();
    return poller;
  }

  /**
   * Search for available phone numbers to purchase.
   * @param countryCode The ISO 3166-2 country code, e.g. US.
   * @param body The phone number search request.
   * @param options The options parameters.
   */
  async beginSearchAvailablePhoneNumbersAndWait(
    countryCode: string,
    body: PhoneNumberSearchRequest,
    options?: PhoneNumbersSearchAvailablePhoneNumbersOptionalParams
  ): Promise<PhoneNumbersSearchAvailablePhoneNumbersResponse> {
    const poller = await this.beginSearchAvailablePhoneNumbers(
      countryCode,
      body,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets a phone number search result by search id.
   * @param searchId The search Id.
   * @param options The options parameters.
   */
  getSearchResult(
    searchId: string,
    options?: PhoneNumbersGetSearchResultOptionalParams
  ): Promise<PhoneNumbersGetSearchResultResponse> {
    return this.client.sendOperationRequest(
      { searchId, options },
      getSearchResultOperationSpec
    );
  }

  /**
   * Purchases phone numbers.
   * @param body The phone number purchase request
   * @param options The options parameters.
   */
  async beginPurchasePhoneNumbers(
    body: PhoneNumberPurchaseRequest,
    options?: PhoneNumbersPurchasePhoneNumbersOptionalParams
  ): Promise<
    SimplePollerLike<
      OperationState<PhoneNumbersPurchasePhoneNumbersResponse>,
      PhoneNumbersPurchasePhoneNumbersResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<PhoneNumbersPurchasePhoneNumbersResponse> => {
      return this.client.sendOperationRequest(args, spec);
    };
    const sendOperationFn = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ) => {
      let currentRawResponse:
        | coreClient.FullOperationResponse
        | undefined = undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback
        }
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON()
        }
      };
    };

    const lro = createLroSpec({
      sendOperationFn,
      args: { body, options },
      spec: purchasePhoneNumbersOperationSpec
    });
    const poller = await createHttpPoller<
      PhoneNumbersPurchasePhoneNumbersResponse,
      OperationState<PhoneNumbersPurchasePhoneNumbersResponse>
    >(lro, {
      restoreFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs
    });
    await poller.poll();
    return poller;
  }

  /**
   * Purchases phone numbers.
   * @param body The phone number purchase request
   * @param options The options parameters.
   */
  async beginPurchasePhoneNumbersAndWait(
    body: PhoneNumberPurchaseRequest,
    options?: PhoneNumbersPurchasePhoneNumbersOptionalParams
  ): Promise<PhoneNumbersPurchasePhoneNumbersResponse> {
    const poller = await this.beginPurchasePhoneNumbers(body, options);
    return poller.pollUntilDone();
  }

  /**
   * Gets an operation by its id.
   * @param operationId The id of the operation
   * @param options The options parameters.
   */
  getOperation(
    operationId: string,
    options?: PhoneNumbersGetOperationOptionalParams
  ): Promise<PhoneNumbersGetOperationResponse> {
    return this.client.sendOperationRequest(
      { operationId, options },
      getOperationOperationSpec
    );
  }

  /**
   * Cancels an operation by its id.
   * @param operationId The id of the operation
   * @param options The options parameters.
   */
  cancelOperation(
    operationId: string,
    options?: PhoneNumbersCancelOperationOptionalParams
  ): Promise<void> {
    return this.client.sendOperationRequest(
      { operationId, options },
      cancelOperationOperationSpec
    );
  }

  /**
   * Updates the capabilities of a phone number.
   * @param phoneNumber The phone number id in E.164 format. The leading plus can be either + or encoded
   *                    as %2B, e.g. +11234567890.
   * @param options The options parameters.
   */
  async beginUpdateCapabilities(
    phoneNumber: string,
    options?: PhoneNumbersUpdateCapabilitiesOptionalParams
  ): Promise<
    SimplePollerLike<
      OperationState<PhoneNumbersUpdateCapabilitiesResponse>,
      PhoneNumbersUpdateCapabilitiesResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<PhoneNumbersUpdateCapabilitiesResponse> => {
      return this.client.sendOperationRequest(args, spec);
    };
    const sendOperationFn = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ) => {
      let currentRawResponse:
        | coreClient.FullOperationResponse
        | undefined = undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback
        }
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON()
        }
      };
    };

    const lro = createLroSpec({
      sendOperationFn,
      args: { phoneNumber, options },
      spec: updateCapabilitiesOperationSpec
    });
    const poller = await createHttpPoller<
      PhoneNumbersUpdateCapabilitiesResponse,
      OperationState<PhoneNumbersUpdateCapabilitiesResponse>
    >(lro, {
      restoreFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      resourceLocationConfig: "location"
    });
    await poller.poll();
    return poller;
  }

  /**
   * Updates the capabilities of a phone number.
   * @param phoneNumber The phone number id in E.164 format. The leading plus can be either + or encoded
   *                    as %2B, e.g. +11234567890.
   * @param options The options parameters.
   */
  async beginUpdateCapabilitiesAndWait(
    phoneNumber: string,
    options?: PhoneNumbersUpdateCapabilitiesOptionalParams
  ): Promise<PhoneNumbersUpdateCapabilitiesResponse> {
    const poller = await this.beginUpdateCapabilities(phoneNumber, options);
    return poller.pollUntilDone();
  }

  /**
   * Gets the details of the given purchased phone number.
   * @param phoneNumber The purchased phone number whose details are to be fetched in E.164 format, e.g.
   *                    +11234567890.
   * @param options The options parameters.
   */
  getByNumber(
    phoneNumber: string,
    options?: PhoneNumbersGetByNumberOptionalParams
  ): Promise<PhoneNumbersGetByNumberResponse> {
    return this.client.sendOperationRequest(
      { phoneNumber, options },
      getByNumberOperationSpec
    );
  }

  /**
   * Releases a purchased phone number.
   * @param phoneNumber Phone number to be released, e.g. +11234567890.
   * @param options The options parameters.
   */
  async beginReleasePhoneNumber(
    phoneNumber: string,
    options?: PhoneNumbersReleasePhoneNumberOptionalParams
  ): Promise<
    SimplePollerLike<
      OperationState<PhoneNumbersReleasePhoneNumberResponse>,
      PhoneNumbersReleasePhoneNumberResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<PhoneNumbersReleasePhoneNumberResponse> => {
      return this.client.sendOperationRequest(args, spec);
    };
    const sendOperationFn = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ) => {
      let currentRawResponse:
        | coreClient.FullOperationResponse
        | undefined = undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback
        }
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON()
        }
      };
    };

    const lro = createLroSpec({
      sendOperationFn,
      args: { phoneNumber, options },
      spec: releasePhoneNumberOperationSpec
    });
    const poller = await createHttpPoller<
      PhoneNumbersReleasePhoneNumberResponse,
      OperationState<PhoneNumbersReleasePhoneNumberResponse>
    >(lro, {
      restoreFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs
    });
    await poller.poll();
    return poller;
  }

  /**
   * Releases a purchased phone number.
   * @param phoneNumber Phone number to be released, e.g. +11234567890.
   * @param options The options parameters.
   */
  async beginReleasePhoneNumberAndWait(
    phoneNumber: string,
    options?: PhoneNumbersReleasePhoneNumberOptionalParams
  ): Promise<PhoneNumbersReleasePhoneNumberResponse> {
    const poller = await this.beginReleasePhoneNumber(phoneNumber, options);
    return poller.pollUntilDone();
  }

  /**
   * Gets the list of all purchased phone numbers.
   * @param options The options parameters.
   */
  private _listPhoneNumbers(
    options?: PhoneNumbersListPhoneNumbersOptionalParams
  ): Promise<PhoneNumbersListPhoneNumbersResponse> {
    return this.client.sendOperationRequest(
      { options },
      listPhoneNumbersOperationSpec
    );
  }

  /**
   * ListAreaCodesNext
   * @param countryCode The ISO 3166-2 country code, e.g. US.
   * @param nextLink The nextLink from the previous successful call to the ListAreaCodes method.
   * @param options The options parameters.
   */
  private _listAreaCodesNext(
    countryCode: string,
    nextLink: string,
    options?: PhoneNumbersListAreaCodesNextOptionalParams
  ): Promise<PhoneNumbersListAreaCodesNextResponse> {
    return this.client.sendOperationRequest(
      { countryCode, nextLink, options },
      listAreaCodesNextOperationSpec
    );
  }

  /**
   * ListAvailableCountriesNext
   * @param nextLink The nextLink from the previous successful call to the ListAvailableCountries method.
   * @param options The options parameters.
   */
  private _listAvailableCountriesNext(
    nextLink: string,
    options?: PhoneNumbersListAvailableCountriesNextOptionalParams
  ): Promise<PhoneNumbersListAvailableCountriesNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listAvailableCountriesNextOperationSpec
    );
  }

  /**
   * ListAvailableLocalitiesNext
   * @param countryCode The ISO 3166-2 country code, e.g. US.
   * @param nextLink The nextLink from the previous successful call to the ListAvailableLocalities
   *                 method.
   * @param options The options parameters.
   */
  private _listAvailableLocalitiesNext(
    countryCode: string,
    nextLink: string,
    options?: PhoneNumbersListAvailableLocalitiesNextOptionalParams
  ): Promise<PhoneNumbersListAvailableLocalitiesNextResponse> {
    return this.client.sendOperationRequest(
      { countryCode, nextLink, options },
      listAvailableLocalitiesNextOperationSpec
    );
  }

  /**
   * ListOfferingsNext
   * @param countryCode The ISO 3166-2 country code, e.g. US.
   * @param nextLink The nextLink from the previous successful call to the ListOfferings method.
   * @param options The options parameters.
   */
  private _listOfferingsNext(
    countryCode: string,
    nextLink: string,
    options?: PhoneNumbersListOfferingsNextOptionalParams
  ): Promise<PhoneNumbersListOfferingsNextResponse> {
    return this.client.sendOperationRequest(
      { countryCode, nextLink, options },
      listOfferingsNextOperationSpec
    );
  }

  /**
   * ListPhoneNumbersNext
   * @param nextLink The nextLink from the previous successful call to the ListPhoneNumbers method.
   * @param options The options parameters.
   */
  private _listPhoneNumbersNext(
    nextLink: string,
    options?: PhoneNumbersListPhoneNumbersNextOptionalParams
  ): Promise<PhoneNumbersListPhoneNumbersNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listPhoneNumbersNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listAreaCodesOperationSpec: coreClient.OperationSpec = {
  path: "/availablePhoneNumbers/countries/{countryCode}/areaCodes",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PhoneNumberAreaCodes
    },
    default: {
      bodyMapper: Mappers.CommunicationErrorResponse
    }
  },
  queryParameters: [
    Parameters.phoneNumberType,
    Parameters.skip,
    Parameters.maxPageSize,
    Parameters.assignmentType,
    Parameters.locality,
    Parameters.administrativeDivision,
    Parameters.apiVersion
  ],
  urlParameters: [Parameters.endpoint, Parameters.countryCode],
  headerParameters: [Parameters.accept, Parameters.acceptLanguage],
  serializer
};
const listAvailableCountriesOperationSpec: coreClient.OperationSpec = {
  path: "/availablePhoneNumbers/countries",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PhoneNumberCountries
    },
    default: {
      bodyMapper: Mappers.CommunicationErrorResponse
    }
  },
  queryParameters: [
    Parameters.skip,
    Parameters.maxPageSize,
    Parameters.apiVersion
  ],
  urlParameters: [Parameters.endpoint],
  headerParameters: [Parameters.accept, Parameters.acceptLanguage],
  serializer
};
const listAvailableLocalitiesOperationSpec: coreClient.OperationSpec = {
  path: "/availablePhoneNumbers/countries/{countryCode}/localities",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PhoneNumberLocalities
    },
    default: {
      bodyMapper: Mappers.CommunicationErrorResponse
    }
  },
  queryParameters: [
    Parameters.skip,
    Parameters.maxPageSize,
    Parameters.administrativeDivision,
    Parameters.apiVersion
  ],
  urlParameters: [Parameters.endpoint, Parameters.countryCode],
  headerParameters: [Parameters.accept, Parameters.acceptLanguage],
  serializer
};
const listOfferingsOperationSpec: coreClient.OperationSpec = {
  path: "/availablePhoneNumbers/countries/{countryCode}/offerings",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.OfferingsResponse
    },
    default: {
      bodyMapper: Mappers.CommunicationErrorResponse
    }
  },
  queryParameters: [
    Parameters.skip,
    Parameters.maxPageSize,
    Parameters.assignmentType,
    Parameters.apiVersion,
    Parameters.phoneNumberType1
  ],
  urlParameters: [Parameters.endpoint, Parameters.countryCode],
  headerParameters: [Parameters.accept, Parameters.acceptLanguage],
  serializer
};
const searchAvailablePhoneNumbersOperationSpec: coreClient.OperationSpec = {
  path: "/availablePhoneNumbers/countries/{countryCode}/:search",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.PhoneNumberSearchResult,
      headersMapper: Mappers.PhoneNumbersSearchAvailablePhoneNumbersHeaders
    },
    201: {
      bodyMapper: Mappers.PhoneNumberSearchResult,
      headersMapper: Mappers.PhoneNumbersSearchAvailablePhoneNumbersHeaders
    },
    202: {
      bodyMapper: Mappers.PhoneNumberSearchResult,
      headersMapper: Mappers.PhoneNumbersSearchAvailablePhoneNumbersHeaders
    },
    204: {
      bodyMapper: Mappers.PhoneNumberSearchResult,
      headersMapper: Mappers.PhoneNumbersSearchAvailablePhoneNumbersHeaders
    },
    default: {
      bodyMapper: Mappers.CommunicationErrorResponse
    }
  },
  requestBody: Parameters.body,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [Parameters.endpoint, Parameters.countryCode],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getSearchResultOperationSpec: coreClient.OperationSpec = {
  path: "/availablePhoneNumbers/searchResults/{searchId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PhoneNumberSearchResult
    },
    default: {
      bodyMapper: Mappers.CommunicationErrorResponse
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [Parameters.endpoint, Parameters.searchId],
  headerParameters: [Parameters.accept],
  serializer
};
const purchasePhoneNumbersOperationSpec: coreClient.OperationSpec = {
  path: "/availablePhoneNumbers/:purchase",
  httpMethod: "POST",
  responses: {
    200: {
      headersMapper: Mappers.PhoneNumbersPurchasePhoneNumbersHeaders
    },
    201: {
      headersMapper: Mappers.PhoneNumbersPurchasePhoneNumbersHeaders
    },
    202: {
      headersMapper: Mappers.PhoneNumbersPurchasePhoneNumbersHeaders
    },
    204: {
      headersMapper: Mappers.PhoneNumbersPurchasePhoneNumbersHeaders
    },
    default: {
      bodyMapper: Mappers.CommunicationErrorResponse
    }
  },
  requestBody: Parameters.body1,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [Parameters.endpoint],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getOperationOperationSpec: coreClient.OperationSpec = {
  path: "/phoneNumbers/operations/{operationId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PhoneNumberOperation,
      headersMapper: Mappers.PhoneNumbersGetOperationHeaders
    },
    default: {
      bodyMapper: Mappers.CommunicationErrorResponse
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [Parameters.endpoint, Parameters.operationId],
  headerParameters: [Parameters.accept],
  serializer
};
const cancelOperationOperationSpec: coreClient.OperationSpec = {
  path: "/phoneNumbers/operations/{operationId}",
  httpMethod: "DELETE",
  responses: {
    204: {},
    default: {
      bodyMapper: Mappers.CommunicationErrorResponse
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [Parameters.endpoint, Parameters.operationId],
  headerParameters: [Parameters.accept],
  serializer
};
const updateCapabilitiesOperationSpec: coreClient.OperationSpec = {
  path: "/phoneNumbers/{phoneNumber}/capabilities",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.PurchasedPhoneNumber,
      headersMapper: Mappers.PhoneNumbersUpdateCapabilitiesHeaders
    },
    201: {
      bodyMapper: Mappers.PurchasedPhoneNumber,
      headersMapper: Mappers.PhoneNumbersUpdateCapabilitiesHeaders
    },
    202: {
      bodyMapper: Mappers.PurchasedPhoneNumber,
      headersMapper: Mappers.PhoneNumbersUpdateCapabilitiesHeaders
    },
    204: {
      bodyMapper: Mappers.PurchasedPhoneNumber,
      headersMapper: Mappers.PhoneNumbersUpdateCapabilitiesHeaders
    },
    default: {
      bodyMapper: Mappers.CommunicationErrorResponse
    }
  },
  requestBody: Parameters.body2,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [Parameters.endpoint, Parameters.phoneNumber],
  headerParameters: [Parameters.accept, Parameters.contentType1],
  mediaType: "json",
  serializer
};
const getByNumberOperationSpec: coreClient.OperationSpec = {
  path: "/phoneNumbers/{phoneNumber}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PurchasedPhoneNumber
    },
    default: {
      bodyMapper: Mappers.CommunicationErrorResponse
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [Parameters.endpoint, Parameters.phoneNumber],
  headerParameters: [Parameters.accept],
  serializer
};
const releasePhoneNumberOperationSpec: coreClient.OperationSpec = {
  path: "/phoneNumbers/{phoneNumber}",
  httpMethod: "DELETE",
  responses: {
    200: {
      headersMapper: Mappers.PhoneNumbersReleasePhoneNumberHeaders
    },
    201: {
      headersMapper: Mappers.PhoneNumbersReleasePhoneNumberHeaders
    },
    202: {
      headersMapper: Mappers.PhoneNumbersReleasePhoneNumberHeaders
    },
    204: {
      headersMapper: Mappers.PhoneNumbersReleasePhoneNumberHeaders
    },
    default: {
      bodyMapper: Mappers.CommunicationErrorResponse
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [Parameters.endpoint, Parameters.phoneNumber],
  headerParameters: [Parameters.accept],
  serializer
};
const listPhoneNumbersOperationSpec: coreClient.OperationSpec = {
  path: "/phoneNumbers",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PurchasedPhoneNumbers
    },
    default: {
      bodyMapper: Mappers.CommunicationErrorResponse
    }
  },
  queryParameters: [Parameters.skip, Parameters.apiVersion, Parameters.top],
  urlParameters: [Parameters.endpoint],
  headerParameters: [Parameters.accept],
  serializer
};
const listAreaCodesNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PhoneNumberAreaCodes
    },
    default: {
      bodyMapper: Mappers.CommunicationErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.countryCode,
    Parameters.nextLink
  ],
  headerParameters: [Parameters.accept, Parameters.acceptLanguage],
  serializer
};
const listAvailableCountriesNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PhoneNumberCountries
    },
    default: {
      bodyMapper: Mappers.CommunicationErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint, Parameters.nextLink],
  headerParameters: [Parameters.accept, Parameters.acceptLanguage],
  serializer
};
const listAvailableLocalitiesNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PhoneNumberLocalities
    },
    default: {
      bodyMapper: Mappers.CommunicationErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.countryCode,
    Parameters.nextLink
  ],
  headerParameters: [Parameters.accept, Parameters.acceptLanguage],
  serializer
};
const listOfferingsNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.OfferingsResponse
    },
    default: {
      bodyMapper: Mappers.CommunicationErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.countryCode,
    Parameters.nextLink
  ],
  headerParameters: [Parameters.accept, Parameters.acceptLanguage],
  serializer
};
const listPhoneNumbersNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PurchasedPhoneNumbers
    },
    default: {
      bodyMapper: Mappers.CommunicationErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint, Parameters.nextLink],
  headerParameters: [Parameters.accept],
  serializer
};
