import { inspect } from "util";

/**
 * Syncs Review Date from issue descriptions to GitHub Projects V2
 *
 * This function:
 * 1. Lists all open issues in the repository
 * 2. Parses each issue description for a line matching "Review Date: YYYY-MM-DD"
 * 3. Finds the corresponding item in GitHub Projects (Azure org, project 196)
 * 4. Updates the 'Review Date' custom field with the parsed date
 *
 * @param {object} params
 * @param {import('@actions/github-script').AsyncFunctionArguments["github"]} params.github - GitHub API client
 * @param {import('@actions/github-script').AsyncFunctionArguments["context"]} params.context - GitHub context
 * @param {import('@actions/github-script').AsyncFunctionArguments["core"]} params.core - GitHub Actions core
 */
export default async function syncReviewDate({ github, context, core }) {
  /** @type {{info: (msg: string) => void, warning: (msg: string) => void, error: (msg: string) => void, debug: (msg: string) => void}} */
  const logger = {
    info: (msg) => core.info(msg),
    warning: (msg) => core.warning(msg),
    error: (msg) => core.error(msg),
    debug: (msg) => core.debug(msg),
  };

  logger.info("Starting Review Date sync process...");

  try {
    // Step 1: Get all open issues in the repository
    const issues = await getAllOpenIssues(github, context, logger);
    logger.info(`Found ${issues.length} open issues to process`);

    let processedCount = 0;
    let updatedCount = 0;
    let errorCount = 0;

    // Step 2: Process each issue
    for (const issue of issues) {
      processedCount++;
      // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
      logger.info(`Processing issue #${issue.number}: ${issue.title}`);

      try {
        // Parse the review date from the issue description
        // eslint-disable-next-line @typescript-eslint/no-unsafe-argument, @typescript-eslint/no-unsafe-member-access
        const reviewDate = parseReviewDate(issue.body, logger);

        if (!reviewDate) {
          // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
          logger.debug(`No review date found in issue #${issue.number}, skipping`);
          continue;
        }

        // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
        logger.info(`Found review date "${reviewDate}" in issue #${issue.number}`);

        // Update the project item with the review date
        // eslint-disable-next-line @typescript-eslint/no-unsafe-argument, @typescript-eslint/no-unsafe-member-access
        const updated = await updateProjectReviewDate(github, issue.number, reviewDate, logger);

        if (updated) {
          updatedCount++;
          // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
          logger.info(`Successfully updated review date for issue #${issue.number}`);
        }
      } catch (error) {
        errorCount++;
        // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
        logger.error(`Error processing issue #${issue.number}: ${inspect(error)}`);
      }
    }

    // Summary
    logger.info(
      `Review Date sync completed: ${processedCount} issues processed, ` +
        `${updatedCount} updated, ${errorCount} errors`,
    );

    // Write summary to GitHub Actions output
    await core.summary
      .addHeading("Review Date Sync Summary")
      .addTable([
        [
          { data: "Metric", header: true },
          { data: "Count", header: true },
        ],
        ["Issues Processed", processedCount.toString()],
        ["Issues Updated", updatedCount.toString()],
        ["Errors", errorCount.toString()],
      ])
      .write();
  } catch (error) {
    logger.error(`Fatal error in Review Date sync: ${inspect(error)}`);
    throw error;
  }
}

/**
 * Retrieves all open issues from the repository
 *
 * @param {import('@actions/github-script').AsyncFunctionArguments["github"]} github
 * @param {import('@actions/github-script').AsyncFunctionArguments["context"]} context
 * @param {{info: (msg: string) => void, warning: (msg: string) => void, error: (msg: string) => void, debug: (msg: string) => void}} logger
 * @returns {Promise<Array<any>>}
 */
async function getAllOpenIssues(github, context, logger) {
  const issues = [];
  const perPage = 100;
  let page = 1;

  logger.debug("Fetching open issues from repository...");

  // Paginate through all open issues
  while (true) {
    try {
      const response = await github.rest.issues.listForRepo({
        owner: context.repo.owner,
        repo: context.repo.repo,
        state: "open",
        per_page: perPage,
        page: page,
      });

      // Filter out pull requests (they appear in the issues API)
      const issuesOnly = response.data.filter((item) => !item.pull_request);
      issues.push(...issuesOnly);

      logger.debug(`Fetched page ${page}: ${issuesOnly.length} issues`);

      // If we got fewer items than perPage, we've reached the end
      if (response.data.length < perPage) {
        break;
      }

      page++;
    } catch (error) {
      logger.error(`Error fetching issues on page ${page}: ${inspect(error)}`);
      throw error;
    }
  }

  return issues;
}

/**
 * Parses the review date from an issue body
 *
 * Looks for a line in the format: "Review Date: YYYY-MM-DD"
 * The date must be in ISO format (YYYY-MM-DD)
 *
 * @param {string | null | undefined} body - The issue body text
 * @param {{info: (msg: string) => void, warning: (msg: string) => void, error: (msg: string) => void, debug: (msg: string) => void}} logger
 * @returns {string | null} - The parsed date in YYYY-MM-DD format, or null if not found
 */
function parseReviewDate(body, logger) {
  if (!body) {
    return null;
  }

  // Regular expression to match "Review Date: YYYY-MM-DD"
  // This regex ensures the date is in valid YYYY-MM-DD format
  const reviewDateRegex = /Review Date:\s*(\d{4}-\d{2}-\d{2})/i;
  const match = body.match(reviewDateRegex);

  if (match && match[1]) {
    const dateStr = match[1];

    // Validate the date is actually valid
    const date = new Date(dateStr);
    if (isNaN(date.getTime())) {
      logger.warning(`Found invalid date format: ${dateStr}`);
      return null;
    }

    return dateStr;
  }

  return null;
}

/**
 * Updates the Review Date field in GitHub Projects V2 for a specific issue
 *
 * This function:
 * 1. Finds the project item ID for the issue in Azure org's project 196
 * 2. Gets the field ID for the 'Review Date' custom field
 * 3. Updates the field value with the provided date
 *
 * @param {import('@actions/github-script').AsyncFunctionArguments["github"]} github
 * @param {number} issueNumber - The issue number
 * @param {string} reviewDate - The review date in YYYY-MM-DD format
 * @param {{info: (msg: string) => void, warning: (msg: string) => void, error: (msg: string) => void, debug: (msg: string) => void}} logger
 * @returns {Promise<boolean>} - True if updated successfully, false otherwise
 */
async function updateProjectReviewDate(github, issueNumber, reviewDate, logger) {
  try {
    const orgName = "Azure";
    const projectNumber = 196;

    // Step 1: Get the project's node ID
    logger.debug(`Finding project ${projectNumber} in organization ${orgName}...`);
    const projectNodeId = await getProjectNodeId(github, orgName, projectNumber, logger);

    if (!projectNodeId) {
      logger.warning(`Project ${projectNumber} not found in organization ${orgName}`);
      return false;
    }

    logger.debug(`Found project node ID: ${projectNodeId}`);

    // Step 2: Get the issue's node ID
    const issueNodeId = await getIssueNodeId(
      github,
      "Azure",
      "azure-rest-api-specs",
      issueNumber,
      logger,
    );

    if (!issueNodeId) {
      logger.warning(`Could not find node ID for issue #${issueNumber}`);
      return false;
    }

    logger.debug(`Found issue node ID: ${issueNodeId}`);

    // Step 3: Find the project item ID for this issue
    const projectItemId = await getProjectItemId(github, projectNodeId, issueNodeId, logger);

    if (!projectItemId) {
      logger.debug(`Issue #${issueNumber} is not in project ${projectNumber}, skipping`);
      return false;
    }

    logger.debug(`Found project item ID: ${projectItemId}`);

    // Step 4: Get the field ID for 'Review Date'
    const fieldId = await getReviewDateFieldId(github, projectNodeId, logger);

    if (!fieldId) {
      logger.error(`Could not find 'Review Date' field in project ${projectNumber}`);
      return false;
    }

    logger.debug(`Found Review Date field ID: ${fieldId}`);

    // Step 5: Update the field value
    await updateProjectItemField(github, projectNodeId, projectItemId, fieldId, reviewDate, logger);

    return true;
  } catch (error) {
    logger.error(`Error updating project for issue #${issueNumber}: ${inspect(error)}`);
    return false;
  }
}

/**
 * Gets the node ID for a project by organization and project number
 *
 * @param {import('@actions/github-script').AsyncFunctionArguments["github"]} github
 * @param {string} orgName - The organization name
 * @param {number} projectNumber - The project number
 * @param {{info: (msg: string) => void, warning: (msg: string) => void, error: (msg: string) => void, debug: (msg: string) => void}} logger
 * @returns {Promise<string | null>} - The project node ID or null if not found
 */
async function getProjectNodeId(github, orgName, projectNumber, logger) {
  try {
    const query = `
      query($orgName: String!, $projectNumber: Int!) {
        organization(login: $orgName) {
          projectV2(number: $projectNumber) {
            id
          }
        }
      }
    `;

    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
    const result = /** @type {any} */ (
      await github.graphql(query, {
        orgName,
        projectNumber,
      })
    );

    // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access, @typescript-eslint/no-unsafe-return
    return result?.organization?.projectV2?.id ?? null;
  } catch (error) {
    logger.error(`Error fetching project node ID: ${inspect(error)}`);
    return null;
  }
}

/**
 * Gets the node ID for an issue
 *
 * @param {import('@actions/github-script').AsyncFunctionArguments["github"]} github
 * @param {string} owner - The repository owner
 * @param {string} repo - The repository name
 * @param {number} issueNumber - The issue number
 * @param {{info: (msg: string) => void, warning: (msg: string) => void, error: (msg: string) => void, debug: (msg: string) => void}} logger
 * @returns {Promise<string | null>} - The issue node ID or null if not found
 */
async function getIssueNodeId(github, owner, repo, issueNumber, logger) {
  try {
    const query = `
      query($owner: String!, $repo: String!, $issueNumber: Int!) {
        repository(owner: $owner, name: $repo) {
          issue(number: $issueNumber) {
            id
          }
        }
      }
    `;

    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
    const result = /** @type {any} */ (
      await github.graphql(query, {
        owner,
        repo,
        issueNumber,
      })
    );

    // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access, @typescript-eslint/no-unsafe-return
    return result?.repository?.issue?.id ?? null;
  } catch (error) {
    logger.error(`Error fetching issue node ID: ${inspect(error)}`);
    return null;
  }
}

/**
 * Finds the project item ID for a specific issue in a project
 *
 * @param {import('@actions/github-script').AsyncFunctionArguments["github"]} github
 * @param {string} projectNodeId - The project node ID
 * @param {string} issueNodeId - The issue node ID
 * @param {{info: (msg: string) => void, warning: (msg: string) => void, error: (msg: string) => void, debug: (msg: string) => void}} logger
 * @returns {Promise<string | null>} - The project item ID or null if not found
 */
async function getProjectItemId(github, projectNodeId, issueNodeId, logger) {
  try {
    let cursor = null;
    let hasNextPage = true;

    // Paginate through project items to find the matching issue
    while (hasNextPage) {
      const query = `
        query($projectId: ID!, $cursor: String) {
          node(id: $projectId) {
            ... on ProjectV2 {
              items(first: 100, after: $cursor) {
                pageInfo {
                  hasNextPage
                  endCursor
                }
                nodes {
                  id
                  content {
                    ... on Issue {
                      id
                    }
                  }
                }
              }
            }
          }
        }
      `;

      // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
      const result = /** @type {any} */ (
        await github.graphql(query, {
          projectId: projectNodeId,
          cursor,
        })
      );

      /** @type {any[]} */
      // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-member-access
      const items = result?.node?.items?.nodes ?? [];

      // Find the item that matches our issue
      for (const item of items) {
        // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
        if (item.content?.id === issueNodeId) {
          // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access, @typescript-eslint/no-unsafe-return
          return item.id;
        }
      }

      // Check if there are more pages
      // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access, @typescript-eslint/no-unsafe-assignment
      hasNextPage = result?.node?.items?.pageInfo?.hasNextPage ?? false;
      // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-member-access
      cursor = result?.node?.items?.pageInfo?.endCursor ?? null;
    }

    // Not found after checking all pages
    return null;
  } catch (error) {
    logger.error(`Error finding project item: ${inspect(error)}`);
    return null;
  }
}

/**
 * Gets the field ID for the 'Review Date' custom field in a project
 *
 * @param {import('@actions/github-script').AsyncFunctionArguments["github"]} github
 * @param {string} projectNodeId - The project node ID
 * @param {{info: (msg: string) => void, warning: (msg: string) => void, error: (msg: string) => void, debug: (msg: string) => void}} logger
 * @returns {Promise<string | null>} - The field ID or null if not found
 */
async function getReviewDateFieldId(github, projectNodeId, logger) {
  try {
    const query = `
      query($projectId: ID!) {
        node(id: $projectId) {
          ... on ProjectV2 {
            fields(first: 50) {
              nodes {
                ... on ProjectV2Field {
                  id
                  name
                }
                ... on ProjectV2SingleSelectField {
                  id
                  name
                }
                ... on ProjectV2IterationField {
                  id
                  name
                }
              }
            }
          }
        }
      }
    `;

    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
    const result = /** @type {any} */ (
      await github.graphql(query, {
        projectId: projectNodeId,
      })
    );

    /** @type {any[]} */
    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-member-access
    const fields = result?.node?.fields?.nodes ?? [];

    // Look for a field named 'Review Date'
    for (const field of fields) {
      // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
      if (field.name === "Review Date") {
        // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access, @typescript-eslint/no-unsafe-return
        return field.id;
      }
    }

    logger.warning("Review Date field not found in project. Available fields:");
    // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
    fields.forEach((field) => logger.warning(`  - ${String(field.name)}`));

    return null;
  } catch (error) {
    logger.error(`Error fetching field ID: ${inspect(error)}`);
    return null;
  }
}

/**
 * Updates a project item's field value
 *
 * @param {import('@actions/github-script').AsyncFunctionArguments["github"]} github
 * @param {string} projectNodeId - The project node ID
 * @param {string} projectItemId - The project item ID
 * @param {string} fieldId - The field ID
 * @param {string} value - The value to set (date in YYYY-MM-DD format)
 * @param {{info: (msg: string) => void, warning: (msg: string) => void, error: (msg: string) => void, debug: (msg: string) => void}} logger
 * @returns {Promise<void>}
 */
async function updateProjectItemField(
  github,
  projectNodeId,
  projectItemId,
  fieldId,
  value,
  logger,
) {
  try {
    const mutation = `
      mutation($projectId: ID!, $itemId: ID!, $fieldId: ID!, $value: Date!) {
        updateProjectV2ItemFieldValue(
          input: {
            projectId: $projectId
            itemId: $itemId
            fieldId: $fieldId
            value: { date: $value }
          }
        ) {
          projectV2Item {
            id
          }
        }
      }
    `;

    await github.graphql(mutation, {
      projectId: projectNodeId,
      itemId: projectItemId,
      fieldId: fieldId,
      value: value,
    });

    logger.info(`Successfully updated field to ${value}`);
  } catch (error) {
    logger.error(`Error updating project item field: ${inspect(error)}`);
    throw error;
  }
}
