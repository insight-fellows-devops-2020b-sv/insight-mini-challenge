output "image_id" {
  value = data.aws_ami.ubuntu.id
}

output "private_ip" {
  value = aws_instance.this[0].private_ip
}

output "public_ip" {
  value = aws_instance.this[0].public_ip
}

output "key_name" {
  value = aws_key_pair.this.key_name
}