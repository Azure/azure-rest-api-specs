
module.exports = async ({ github, context, core }) => {
    
    core.info(`extractInputs(${context.eventName}, ${context.payload.action})`);

    console.log('context', JSON.stringify(context));
    console.log('context.payload', JSON.stringify(context.payload));
    github.rest.issues.createComment({
      owner: context.repo.owner,
      repo: context.repo.repo,
      issue_number: context.issue.number,
      body: "Thank you for your contribution! 123123🚀"
    });

}