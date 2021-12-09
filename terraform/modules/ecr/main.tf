resource "aws_ecr_repository" "main" {
  name                 = var.app_name
  image_tag_mutability = "MUTABLE"
}