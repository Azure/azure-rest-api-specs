import { inspect } from "util";

/**
 * Syncs Review Date from issue descriptions to GitHub Projects V2
 *
 * This function:
 * 1. Lists all open issues with the label "API Review Scoping"
 * 2. Parses each issue description and comments for a line matching "Review Date: MM/DD/YYYY HH:MM AM/PM PT"
 * 3. Uses the last review date found (from issue body or comments)
 * 4. Finds the corresponding item in GitHub Projects (Azure org, project 196)
 * 5. Updates the 'Review Date' custom field with the parsed date
 * 6. Links any PR mentioned in the format "PR: https://github.com/Azure/azure-rest-api-specs/pull/XXXXX"
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
    // Step 1: Get all open issues with the "API Review Scoping" label
    const issues = await getAllOpenIssues(github, context, logger);
    logger.info(`Found ${issues.length} open issues with "API Review Scoping" label to process`);

    let processedCount = 0;
    let updatedCount = 0;
    let errorCount = 0;

    // Step 2: Process each issue
    for (const issue of issues) {
      processedCount++;
      // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
      logger.info(`Processing issue #${issue.number}: ${issue.title}`);

      try {
        // Get all comments for the issue
        // eslint-disable-next-line @typescript-eslint/no-unsafe-argument, @typescript-eslint/no-unsafe-member-access
        const comments = await getIssueComments(github, context, issue.number, logger);

        // Parse the review date from issue body and all comments, use the last one found
        // eslint-disable-next-line @typescript-eslint/no-unsafe-argument, @typescript-eslint/no-unsafe-member-access
        const reviewDate = findLastReviewDate(issue.body, comments, logger);

        if (!reviewDate) {
          // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
          logger.debug(`No review date found in issue #${issue.number}, skipping`);
          continue;
        }

        // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
        logger.info(`Found review date "${reviewDate}" in issue #${issue.number}`);

        // Extract PR link from issue body or comments
        // eslint-disable-next-line @typescript-eslint/no-unsafe-argument, @typescript-eslint/no-unsafe-member-access
        const prNumber = findPRLink(issue.body, comments, logger);

        // Update the project item with the review date
        const updated = await updateProjectReviewDate(
          github,
          // eslint-disable-next-line @typescript-eslint/no-unsafe-argument, @typescript-eslint/no-unsafe-member-access
          issue.number,
          reviewDate,
          logger,
        );

        if (updated) {
          updatedCount++;
          // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
          logger.info(`Successfully updated review date for issue #${issue.number}`);

          // If there's a PR link, try to link it to the issue
          if (prNumber) {
            // eslint-disable-next-line @typescript-eslint/no-unsafe-argument, @typescript-eslint/no-unsafe-member-access
            await linkPRToIssue(github, context, issue.number, prNumber, logger);
          }
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
 * Retrieves all open issues with the "API Review Scoping" label from the repository
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

  logger.debug("Fetching open issues with 'API Review Scoping' label from repository...");

  // Paginate through all open issues with the label
  while (true) {
    try {
      const response = await github.rest.issues.listForRepo({
        owner: context.repo.owner,
        repo: context.repo.repo,
        state: "open",
        labels: "API Review Scoping",
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
 * Retrieves all comments for an issue
 *
 * @param {import('@actions/github-script').AsyncFunctionArguments["github"]} github
 * @param {import('@actions/github-script').AsyncFunctionArguments["context"]} context
 * @param {number} issueNumber - The issue number
 * @param {{info: (msg: string) => void, warning: (msg: string) => void, error: (msg: string) => void, debug: (msg: string) => void}} logger
 * @returns {Promise<Array<any>>}
 */
async function getIssueComments(github, context, issueNumber, logger) {
  const comments = [];
  const perPage = 100;
  let page = 1;

  logger.debug(`Fetching comments for issue #${issueNumber}...`);

  // Paginate through all comments
  while (true) {
    try {
      const response = await github.rest.issues.listComments({
        owner: context.repo.owner,
        repo: context.repo.repo,
        issue_number: issueNumber,
        per_page: perPage,
        page: page,
      });

      comments.push(...response.data);

      logger.debug(`Fetched page ${page}: ${response.data.length} comments`);

      // If we got fewer items than perPage, we've reached the end
      if (response.data.length < perPage) {
        break;
      }

      page++;
    } catch (error) {
      logger.error(`Error fetching comments for issue #${issueNumber}: ${inspect(error)}`);
      throw error;
    }
  }

  return comments;
}

/**
 * Finds the last review date from issue body and comments
 *
 * Scans the issue body and all comments for review dates, and returns the last one found.
 * This allows for rescheduled meetings where the new date is in a comment.
 *
 * @param {string | null | undefined} issueBody - The issue body text
 * @param {Array<any>} comments - Array of comment objects
 * @param {{info: (msg: string) => void, warning: (msg: string) => void, error: (msg: string) => void, debug: (msg: string) => void}} logger
 * @returns {string | null} - The last review date found in YYYY-MM-DD format, or null if not found
 */
function findLastReviewDate(issueBody, comments, logger) {
  const allDates = [];

  // Parse date from issue body
  const bodyDate = parseReviewDate(issueBody, logger);
  if (bodyDate) {
    allDates.push(bodyDate);
    logger.debug(`Found review date in issue body: ${bodyDate}`);
  }

  // Parse dates from all comments
  for (const comment of comments) {
    // eslint-disable-next-line @typescript-eslint/no-unsafe-argument, @typescript-eslint/no-unsafe-member-access
    const commentDate = parseReviewDate(comment.body, logger);
    if (commentDate) {
      allDates.push(commentDate);
      logger.debug(`Found review date in comment: ${commentDate}`);
    }
  }

  // Return the last date found (most recent mention)
  if (allDates.length > 0) {
    const lastDate = allDates[allDates.length - 1];
    logger.info(`Using last review date found: ${lastDate}`);
    return lastDate;
  }

  return null;
}

/**
 * Finds a PR link from issue body or comments
 *
 * Looks for a line in the format: "PR: https://github.com/Azure/azure-rest-api-specs/pull/XXXXX"
 *
 * @param {string | null | undefined} issueBody - The issue body text
 * @param {Array<any>} comments - Array of comment objects
 * @param {{info: (msg: string) => void, warning: (msg: string) => void, error: (msg: string) => void, debug: (msg: string) => void}} logger
 * @returns {number | null} - The PR number, or null if not found
 */
function findPRLink(issueBody, comments, logger) {
  // Regular expression to match PR link
  const prLinkRegex = /PR:\s*https:\/\/github\.com\/Azure\/azure-rest-api-specs\/pull\/(\d+)/i;

  // Check issue body
  if (issueBody) {
    const match = issueBody.match(prLinkRegex);
    if (match) {
      const prNumber = parseInt(match[1]);
      logger.info(`Found PR link in issue body: #${prNumber}`);
      return prNumber;
    }
  }

  // Check comments
  for (const comment of comments) {
    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-call, @typescript-eslint/no-unsafe-member-access
    const match = comment.body?.match(prLinkRegex);
    if (match) {
      // eslint-disable-next-line @typescript-eslint/no-unsafe-argument, @typescript-eslint/no-unsafe-member-access
      const prNumber = parseInt(match[1]);
      logger.info(`Found PR link in comment: #${prNumber}`);
      return prNumber;
    }
  }

  return null;
}

/**
 * Links a PR to an issue by adding a comment
 *
 * @param {import('@actions/github-script').AsyncFunctionArguments["github"]} github
 * @param {import('@actions/github-script').AsyncFunctionArguments["context"]} context
 * @param {number} issueNumber - The issue number
 * @param {number} prNumber - The PR number
 * @param {{info: (msg: string) => void, warning: (msg: string) => void, error: (msg: string) => void, debug: (msg: string) => void}} logger
 * @returns {Promise<void>}
 */
async function linkPRToIssue(github, context, issueNumber, prNumber, logger) {
  try {
    logger.info(`Linking PR #${prNumber} to issue #${issueNumber}...`);

    // Check if the PR exists and get its details
    await github.rest.pulls.get({
      owner: context.repo.owner,
      repo: context.repo.repo,
      pull_number: prNumber,
    });

    // Link the issue by mentioning it in the PR (creates a reference)
    // First check if we already have a comment linking them
    const prComments = await github.rest.issues.listComments({
      owner: context.repo.owner,
      repo: context.repo.repo,
      issue_number: prNumber,
    });

    const linkComment = `Linked to issue #${issueNumber} for API review tracking.`;
    const alreadyLinked = prComments.data.some((comment) => comment.body?.includes(linkComment));

    if (!alreadyLinked) {
      await github.rest.issues.createComment({
        owner: context.repo.owner,
        repo: context.repo.repo,
        issue_number: prNumber,
        body: linkComment,
      });
      logger.info(`Successfully linked PR #${prNumber} to issue #${issueNumber}`);
    } else {
      logger.debug(`PR #${prNumber} is already linked to issue #${issueNumber}`);
    }
  } catch (error) {
    logger.error(`Error linking PR #${prNumber} to issue #${issueNumber}: ${inspect(error)}`);
    // Don't throw - this is a nice-to-have feature, not critical
  }
}

/**
 * Parses the review date from an issue body
 *
 * Looks for a line in the format: "Review Date: MM/DD/YYYY HH:MM AM/PM PT"
 * Example: "Review Date: 01/15/2026 08:00 AM PT"
 *
 * @param {string | null | undefined} body - The issue body text
 * @param {{info: (msg: string) => void, warning: (msg: string) => void, error: (msg: string) => void, debug: (msg: string) => void}} logger
 * @returns {string | null} - The parsed date in YYYY-MM-DD format (ISO), or null if not found
 */
function parseReviewDate(body, logger) {
  if (!body) {
    return null;
  }

  // Regular expression to match "Review Date: MM/DD/YYYY HH:MM AM/PM PT"
  // Captures: month, day, year, hour, minute, AM/PM
  const reviewDateRegex =
    /Review Date:\s*(\d{1,2})\/(\d{1,2})\/(\d{4})\s+(\d{1,2}):(\d{2})\s+(AM|PM)\s+PT/i;
  const match = body.match(reviewDateRegex);

  if (match) {
    const month = match[1];
    const day = match[2];
    const year = match[3];
    const hour = match[4];
    const minute = match[5];
    const ampm = match[6].toUpperCase();

    // Convert to 24-hour format for validation
    let hour24 = parseInt(hour);
    if (ampm === "PM" && hour24 !== 12) {
      hour24 += 12;
    } else if (ampm === "AM" && hour24 === 12) {
      hour24 = 0;
    }

    // Create a date string in ISO format for validation
    // Note: The GitHub Projects date field only stores dates (not times), so we only need YYYY-MM-DD
    const dateStr = `${year}-${month.padStart(2, "0")}-${day.padStart(2, "0")}`;

    // Validate the date is actually valid
    const date = new Date(`${dateStr}T${hour24.toString().padStart(2, "0")}:${minute}:00`);
    if (isNaN(date.getTime())) {
      logger.warning(`Found invalid date format: ${match[0]}`);
      return null;
    }

    // Return date in ISO format (YYYY-MM-DD) for GitHub Projects API
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
