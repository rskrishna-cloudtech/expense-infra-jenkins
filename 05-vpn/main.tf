# Resource to create the key pair for VPN instance.
resource "aws_key_pair" "vpn" {
  key_name = "vpn"
  #   public_key = file("<public_key_path>")
  public_key = file("~/.ssh/openvpn.pub") # ~ means windows home directory of the user.
}

# Resource module to create an EC2 instance for VPN.
module "vpn" {
  source   = "terraform-aws-modules/ec2-instance/aws"
  key_name = aws_key_pair.vpn.key_name

  name                   = "${var.project_name}-${var.environment}-vpn"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  # Convert StringList into String and get the 1st value.
  subnet_id = local.public_subnet_id
  ami       = data.aws_ami.ami_info.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-vpn"
    }
  )
}
