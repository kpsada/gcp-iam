output "id" {
  value       = module.iam_group.id
  description = "ID of the group. For Google-managed entities, the ID is the email address the group"
}