variable "repo_names" {
  type = list(string)
}

variable "team_names" {
  type = list(string)
}

variable "groups" {
  type = list(object({
    repo       = string
    team       = string
    permission = string
  }))
}
