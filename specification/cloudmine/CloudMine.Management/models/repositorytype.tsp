@doc("Repository type enum")
union RepositoryType {
  string,

  @doc("TfsGit repository type")
  TfsGit: "TfsGit",

  @doc("GitHub repository type")
  GitHub: "GitHub",

  @doc("Git repository type")
  Git: "Git",

  @doc("GitHubEnterprise repository type")
  GitHubEnterprise: "GitHubEnterprise",

  @doc("Svn repository type")
  Svn: "Svn",

  @doc("Bitbucket repository type")
  Bitbucket: "Bitbucket",

  @doc("TfsVersionControl repository type")
  TfsVersionControl: "TfsVersionControl",
}
