# create github repository
resource "github_repository" "repo" {
  name        = "Cool-repo"
  visibility  = "public"
}

# create github team
resource "github_team" "team" {
  name        = "Cool-team"
  privacy     = "closed"
}

# add a repository to the team
resource "github_team_repository" "team_repo" {
  team_id    = github_team.team.id
  repository = github_repository.repo.name
  permission = "push"
}

#-------------------------

# create github repositories
resource "github_repository" "repos" {
  for_each = toset(var.repo_names)
  name        = each.value
  visibility  = "private"
}

# create github teams
resource "github_team" "teams" {
  for_each = toset(var.team_names)
  name      = each.value
  privacy   = "closed"
}

# add each repository to their team
resource "github_team_repository" "groups" {
  for_each = {
    for group in var.groups : 
    "${group.repo}_${group.team}" => {
      team       = group.team,
      repo       = group.repo,
      permission = group.permission
    }
  }
  team_id    = github_team.teams[each.value.team].id
  repository = github_repository.repos[each.value.repo].name
  permission = each.value.permission
}
