// @ts-check
import { sdkLabels } from "../../src/sdk-types.js";
import { LabelAction } from "../../src/label.js";
import { stringify } from "querystring";

const wfName = 'sdk-breaking-change-labels';

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<{labelName: string, labelAction: LabelAction, issueNumber: number}>}
 */
export async function getLabelAndAction({ github, context, core }) {
  let issue_number = NaN;
  let check_run_id = process.env.CHECK_RUN_ID;
  let labelAction;
  let labelName = "";
  let checkRun = context.payload.check_run;
  // Determine check run ID to use (from manual input or hardcoded default)
  if (check_run_id) {
    core.info(`Fetching check run with ID from input: ${check_run_id}`);

    // First fetch the check run with specific ID
    checkRun = await github.rest.checks.get({
      owner: context.repo.owner,
      repo: context.repo.repo,
      check_run_id: parseInt(check_run_id, 10)
    }).data;
    if (!checkRun) {
      throw new Error('No check run data found in the API response');
    }
  }
  
  core.info(`Check run name: ${checkRun.name}`);
  if (!checkRun.name.includes("(SDK Generation Job)")) {
    core.info(`Ignoring check run as it's not an SDK generation job`);
    return { labelName, labelAction: LabelAction.None, issueNumber: issue_number };
  }

  // Extract build ID from details_url if available
  if (checkRun.details_url) {
    core.info(`Details URL:, ${checkRun.details_url}`);

    const buildUrlRegex = /^(.*?)(?=\/_build\/).*?[?&]buildId=(\d+)/;
    const match = checkRun.details_url.match(buildUrlRegex);
    const artifactName = "spec-gen-sdk_azure-sdk-for-js_true";
    if (match) {
      const apiUrl = `${match[1]}/_apis/build/builds/${match[2]}/artifacts/${artifactName}?api-version=7.0`;
      // Call Azure DevOps REST API to list artifacts
      try {
        core.info(`Calling Azure DevOps API to get the artifacts: ${apiUrl}`);
        
        // Use Node.js fetch to call the API
        const response = await fetch(apiUrl, {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json'
          }
        });

        if (response.ok) {
          const artifacts = await response.json();
          core.info(`Artifacts found: ${stringify(artifacts)}`);
          /*
          core.info(`Artifacts found: ${artifacts.count}`);
          
          // Process artifacts as needed
          let addLabel = false;
          let removeLabel = false;
          let language = "";
          for (const artifact of artifacts.value) {

            // label artifact name example: 'spec-gen-sdk-azure-sdk-for-js-true'
            if (artifact.name.startsWith("spec-gen-sdk_")) {
              core.info(`Artifact: ${artifact.name}`);
              if(artifact.name.endsWith("true")) {
                addLabel = true;
                language = artifact.name.split("_")[1];
              } else if(artifact.name.endsWith("false")) {
                removeLabel = true;
                language = artifact.name.split("_")[1];
              }
            }
          }

          // Set label action and name based on the artifacts
          if (addLabel) {
            labelAction = LabelAction.Add;
          } else if (removeLabel) {
            labelAction = LabelAction.Remove;
          }
          if (language) {
            labelName = sdkLabels[`${language}`].breakingChange;
          }*/
        } else {
          core.error(`Failed to fetch artifacts: ${response.status}, ${response.statusText}`);
          const errorText = await response.text();
          core.error(`Error details: ${errorText}`);
        }
      } catch (apiError) {
        core.error(`Error calling Azure DevOps API: ${apiError}`);
      }
    } else {
      core.error(`Could not extract devops info from details_url: ${checkRun.details_url}`);
    }
  } else {
    core.info('No details_url found in check run');
  }

  // Get the issue number from the check run
  if (Number.isNaN(issue_number)) {
    const { issueNumber } = await getIssueNumber({checkRun, core, github});
    issue_number = issueNumber;
  }

  if (!labelAction) {
    core.info('No label action found, defaulting to None');
    labelAction = LabelAction.None;
  }  
  
  return { labelName, labelAction, issueNumber: issue_number };
}

/**
 * Retrieves the PR number associated with a specific commit SHA
 * @param {Object} params
 * @param {import('github').CheckRun} params.checkRun - The check run object containing head_sha
 * @param {typeof import("@actions/core")} params.core - GitHub Actions core for logging
 * @param {import('github-script').GitHub} params.github - GitHub API client
 * @returns {Promise<{issueNumber: number}>} - The PR number or NaN if not found
 */
async function getIssueNumber({checkRun, core, github})
{
  let issueNumber = NaN;

  if (!checkRun.head_sha) {
    core.info('No head_sha found in check run');
    return { issueNumber };
  }

  core.info(`Searching for PRs with commit SHA: ${checkRun.head_sha}`);

  try {
    const searchResponse = await github.rest.search.issuesAndPullRequests({
      q: `sha:${checkRun.head_sha} type:pr state:open`
    });

    const totalCount = searchResponse.data.total_count;
    const itemsCount = searchResponse.data.items.length;

    core.info(`Search results: ${totalCount} total matches, ${itemsCount} items returned`);

    if (itemsCount > 0) {
      const firstItem = searchResponse.data.items[0];
      issueNumber = firstItem.number;
      core.info(`Found the first matched PR #${issueNumber}: ${firstItem.html_url}`);

      if (itemsCount > 1) {
        core.warning(`Multiple PRs found for commit ${checkRun.head_sha}: ${searchResponse.data.items.map(item => `#${item.html_url}`).join(', ')}`);
      }
    } else {
      core.info(`No open PRs found for commit ${checkRun.head_sha}`);
    }
  } catch (error) {
    core.error(`${wfName}: Error searching for PRs with commit ${checkRun.head_sha}: ${error.message}`);
    throw error;
  }

  return { issueNumber };
}