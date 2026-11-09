output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.demo_bucket.bucket
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.demo_server.id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.demo_server.public_ip
}

output "website_url" {
  description = "URL of the test page served by nginx"
  value       = "http://${aws_instance.demo_server.public_ip}"
}
