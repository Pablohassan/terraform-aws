resource "aws_instance" "datascientest_a" {
  ami                    = data.aws_ami.datascientest-ami.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.app_subnet_a.id
  vpc_security_group_ids = ["${aws_security_group.sg_datascientest.id}"]
  key_name               = aws_key_pair.myec2key.key_name
  user_data              = file("install_wordpress.sh")
  tags = {
    Name = "Datascientest-a"
  }
}

## Fin

## Création de serveur datascientest pour le sous-réseau d'application B

resource "aws_instance" "datascientest_b" {
  ami                    = data.aws_ami.datascientest-ami.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.app_subnet_b.id
  vpc_security_group_ids = ["${aws_security_group.sg_datascientest.id}"]
  key_name               = aws_key_pair.myec2key.key_name
  user_data              = file("install_wordpress.sh")
  tags = {
    Name = "Datascientest-alb-sg"
  }

}
## Fin

resource "aws_instance" "datascientest_bastion" {
  ami                    = data.aws_ami.datascientest-ami.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_a.id
  vpc_security_group_ids = ["${aws_security_group.sg_22.id}"]
  key_name               = aws_key_pair.myec2key.key_name

  tags = {
    Name = "datascientest-bastion"
  }



}
data "aws_ami" "datascientest-ami" { # déclaration de la source de données de type aws_ami (ami aws)

  most_recent = true       # demande à avoir l'image la plus recente disponible
  owners      = ["amazon"] # Le proriétaire de l'image

  filter {          # on ajoute un filtre
    name   = "name" # on veut filtrer l'image lorsque le nom commence par amzn2-ami-hvm-*
    values = ["amzn2-ami-hvm-*"]
  }
}

resource "aws_key_pair" "myec2key" {
  key_name   = "datascientest_keypair"
  public_key = file("~/.ssh/id_rsa.pub")
}
