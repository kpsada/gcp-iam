variable "project" {
  default = null
}

variable "domain" {
  type = string
}
variable "group_id" {
  type    = string
  default = ""
}

variable "project_iam_roles" {
  type = list(string)
  default = [
    "roles/compute.admin"
  ]
}

variable "display_name" {
  type    = string
  default = "Cloud Identity Group"
}

variable "description" {
  default = "Cloud Identity Group"
}

variable "owners" {
  description = "Owners of the group. Each entry is the ID of an entity. For Google-managed entities, the ID must be the email address of an existing group, user or service account"
  default     = []
}

variable "managers" {
  description = "Managers of the group. Each entry is the ID of an entity. For Google-managed entities, the ID must be the email address of an existing group, user or service account"
  default     = []
}

variable "members" {
  description = "Members of the group. Each entry is the ID of an entity. For Google-managed entities, the ID must be the email address of an existing group, user or service account"
  default     = []
}

variable "group_memberships" {
  description = "List of groups of which this group is a member. Each entry is the name of a group."
  default =[]
}