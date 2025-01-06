# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"  # Altere para sua região desejada
}

# Cria um bucket S3
resource "aws_s3_bucket" "app_bucket" {
  bucket = "meu-app-bucket-nome-unico"  # Altere para um nome único
  force_destroy = true
}

# Configura o bucket como privado por padrão
resource "aws_s3_bucket_public_access_block" "app_bucket_public_access" {
  bucket = aws_s3_bucket.app_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Cria uma política IAM para acesso ao bucket
resource "aws_iam_policy" "s3_access_policy" {
  name        = "s3-app-access-policy"
  description = "Política de acesso ao bucket S3 para a aplicação"

  policy = jsonencode({
    Version = "2025-01-06"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.app_bucket.arn,
          "${aws_s3_bucket.app_bucket.arn}/*"
        ]
      }
    ]
  })
}

# Opcional: CORS configuration se necessário para acesso web
resource "aws_s3_bucket_cors_configuration" "app_bucket_cors" {
  bucket = aws_s3_bucket.app_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE"]
    allowed_origins = ["*"]  # Em produção, especifique os domínios permitidos
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

# Outputs úteis
output "bucket_name" {
  value = aws_s3_bucket.app_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.app_bucket.arn
}

output "bucket_region" {
  value = aws_s3_bucket.app_bucket.region
}

output "access_policy_arn" {
  value = aws_iam_policy.s3_access_policy.arn
}