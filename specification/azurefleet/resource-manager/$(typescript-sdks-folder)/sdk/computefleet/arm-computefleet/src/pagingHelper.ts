export interface PageInfo {
  continuationToken?: string;
}

const pageMap = new WeakMap<object, PageInfo>();

/**
 * Given the last `.value` produced by the `byPage` iterator,
 * returns a continuation token that can be used to begin paging from
 * that point later.
 * @param page An object from accessing `value` on the IteratorResult from a `byPage` iterator.
 * @returns The continuation token that can be passed into byPage() during future calls.
 */
export function getContinuationToken(page: unknown): string | undefined {
  if (typeof page !== "object" || page === null) {
    return undefined;
  }
  return pageMap.get(page)?.continuationToken;
}

export function setContinuationToken(
  page: unknown,
  continuationToken: string | undefined,
): void {
  if (typeof page !== "object" || page === null || !continuationToken) {
    return;
  }
  const pageInfo = pageMap.get(page) ?? {};
  pageInfo.continuationToken = continuationToken;
  pageMap.set(page, pageInfo);
}
