terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "6.2.1"
    }
  }
}

provider "github" {
  owner = "JSarunn"
}

# create github repository
resource "github_repository" "repo" {
  name        = "First-repo"
  description = "Created my first terraform repository"
  visibility  = "public"
}

# create github team
resource "github_team" "cloudnc_team" {
  name        = "Cool-team"
  description = "Created my first cool team"
  privacy     = "closed"
}

# add a repository to the team
resource "github_team_repository" "public_repo" {
  team_id    = github_team.example.id
  repository = github_repository.example.name
}

# create multiple github repositories
variable "repo_names" {
  type    = list(string)
  default = ["repo1", "repo2", "repo3", "repo4", "repo5"]
}

resource "github_repository" "repos" {
  for_each = toset(var.repo_names)

  name        = each.value
  visibility  = "private"
}

# add repositories to the team
resource "github_team_repository" "team_repos" {
  for_each = toset(var.repo_names)

  team_id    = github_team.example.id
  repository = each.value
}
