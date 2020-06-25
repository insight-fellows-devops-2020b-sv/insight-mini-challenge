module "ami" {
  source = "github.com/insight-infrastructure/terraform-aws-ami.git?ref=v0.1.0"
}

resource "aws_eip" "this" {
  tags = var.tags
}

resource "aws_eip_association" "this" {
  instance_id = aws_instance.mini_challenge_1.id
  public_ip   = aws_eip.this.public_ip
}

resource "aws_key_pair" "this" {
  count      = var.public_key_path == "" ? 0 : 1
  public_key = file(var.public_key_path)
  tags       = var.tags
}

resource "aws_instance" "mini_challenge_1" {
  ami           = module.ami.ubuntu_1804_ami_id
  instance_type = var.instance_type

  subnet_id              = aws_subnet.main-public-1.id
  vpc_security_group_ids = [aws_security_group.open_access.id]
  key_name               = var.public_key_path == "" ? var.key_name : aws_key_pair.this.*.key_name[0]
  # iam_instance_profile   = aws_iam_role.this.id
  associate_public_ip_address = true

  tags = var.tags
}

