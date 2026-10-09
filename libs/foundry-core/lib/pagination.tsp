using TypeSpec.Http;

namespace Microsoft.Foundry.Core;

/**
 * The response data for a requested list of items.
 * @template T The item type.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model AgentsPagedResult<T> {
  /** The requested list of items. */
  @pageItems
  data: T[];

  /** The first ID represented in this list. */
  first_id?: string;

  /** The last ID represented in this list. */
  @continuationToken
  last_id?: string;

  /** A value indicating whether there are additional values available not captured in this list. */
  has_more: boolean;
}

/**
 * A page of items with a URL cursor to the next page.
 * @template T The item type.
 */
model PagedResultWithNextLink<T> {
  /** The requested list of items. */
  @pageItems
  data: T[];

  /** The URL to fetch the next page of results, or absent if there are no additional pages. */
  @nextLink
  next_link?: url;
}

alias PageLimitQueryParameter = {
  /**
   * A limit on the number of objects to be returned. Limit can range between 1 and 100, and the
   * default is 20.
   */
  @query limit?: int32 = 20;
};

/** Sort order for paginated list results. */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Foundry cursor ordering is intentionally restricted to asc and desc."
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserves the existing PageOrder schema and enum descriptions."
union PageOrder {
  "asc",
  "desc",
}

alias PageOrderQueryParameter<TOrder extends string = PageOrder> = {
  /**
   * Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and`desc`
   * for descending order.
   */
  @query order?: TOrder;
};

alias PageAfterQueryParameter = {
  /**
   * A cursor for use in pagination. `after` is an object ID that defines your place in the list.
   * For instance, if you make a list request and receive 100 objects, ending with obj_foo, your
   * subsequent call can include after=obj_foo in order to fetch the next page of the list.
   */
  @query @continuationToken after?: string;
};

alias PageBeforeQueryParameter = {
  /**
   * A cursor for use in pagination. `before` is an object ID that defines your place in the list.
   * For instance, if you make a list request and receive 100 objects, ending with obj_foo, your
   * subsequent call can include before=obj_foo in order to fetch the previous page of the list.
   */
  @query before?: string;
};

alias CommonPageQueryParameters<TOrder extends string = PageOrder> = {
  ...PageLimitQueryParameter;
  ...PageOrderQueryParameter<TOrder>;
  ...PageAfterQueryParameter;
  ...PageBeforeQueryParameter;
};
